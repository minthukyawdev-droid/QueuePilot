#!/usr/bin/env bash

set -Eeuo pipefail

DEPLOY_SHA="${1:-}"
REPOSITORY_URL="https://github.com/minthukyawdev-droid/QueuePilot.git"
APP_ROOT="/opt/queuepilot"
RELEASES_DIR="${APP_ROOT}/releases"
RELEASE_DIR="${RELEASES_DIR}/${DEPLOY_SHA}"
CURRENT_LINK="${APP_ROOT}/current"
ENV_DIR="/etc/queuepilot"
ENV_FILE="${ENV_DIR}/api.env"
PUBLIC_IP="13.212.155.222"
CERTBOT="/snap/bin/certbot"
CERTIFICATE_DIR="/etc/letsencrypt/live/${PUBLIC_IP}"
ACME_WEBROOT="/var/www/letsencrypt"

if [[ ! "${DEPLOY_SHA}" =~ ^[0-9a-f]{40}$ ]]; then
    echo "A full Git commit SHA is required." >&2
    exit 1
fi

if ! command -v nginx >/dev/null 2>&1 \
    || ! dpkg-query -W -f='${Status}' python3-venv 2>/dev/null \
        | grep -q 'ok installed'; then
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
        nginx \
        python3-venv
fi

if [[ ! -x "${CERTBOT}" ]]; then
    sudo snap install certbot --classic
fi

sudo install -d -m 0755 -o ubuntu -g ubuntu "${APP_ROOT}" "${RELEASES_DIR}"
sudo install -d -m 0750 -o root -g ubuntu "${ENV_DIR}"
sudo install -d -m 0755 -o root -g root "${ACME_WEBROOT}"

if [[ ! -f "${ENV_FILE}" ]]; then
    printf '%s\n' \
        'APP_ENV=production' \
        'CORS_ORIGINS=http://localhost:3000' \
        | sudo tee "${ENV_FILE}" >/dev/null
    sudo chmod 0640 "${ENV_FILE}"
fi

if [[ ! -d "${RELEASE_DIR}" ]]; then
    mkdir -p "${RELEASE_DIR}"
    git -C "${RELEASE_DIR}" init
    git -C "${RELEASE_DIR}" remote add origin "${REPOSITORY_URL}"
    git -C "${RELEASE_DIR}" fetch --depth 1 origin "${DEPLOY_SHA}"
    git -C "${RELEASE_DIR}" checkout --detach FETCH_HEAD
fi

if [[ "$(git -C "${RELEASE_DIR}" rev-parse HEAD)" != "${DEPLOY_SHA}" ]]; then
    echo "Checked-out release does not match ${DEPLOY_SHA}." >&2
    exit 1
fi

rm -rf "${RELEASE_DIR}/.venv"
python3 -m venv "${RELEASE_DIR}/.venv"
"${RELEASE_DIR}/.venv/bin/python" -m pip install --upgrade pip
"${RELEASE_DIR}/.venv/bin/python" -m pip install \
    -r "${RELEASE_DIR}/services/api/requirements.txt"

sudo install -m 0644 \
    "${RELEASE_DIR}/infra/aws/queuepilot-api.service" \
    /etc/systemd/system/queuepilot-api.service
sudo install -m 0644 \
    "${RELEASE_DIR}/infra/aws/queuepilot-api.bootstrap.nginx" \
    /etc/nginx/sites-available/queuepilot-api
sudo install -d -m 0755 \
    /etc/letsencrypt/renewal-hooks/deploy
sudo install -m 0755 \
    "${RELEASE_DIR}/infra/aws/reload-nginx.sh" \
    /etc/letsencrypt/renewal-hooks/deploy/reload-nginx
sudo ln -sfn \
    /etc/nginx/sites-available/queuepilot-api \
    /etc/nginx/sites-enabled/queuepilot-api
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx

if [[ ! -f "${CERTIFICATE_DIR}/fullchain.pem" ]]; then
    sudo "${CERTBOT}" certonly \
        --webroot \
        --webroot-path "${ACME_WEBROOT}" \
        --preferred-profile shortlived \
        --ip-address "${PUBLIC_IP}" \
        --cert-name "${PUBLIC_IP}" \
        --non-interactive \
        --agree-tos \
        --register-unsafely-without-email
else
    sudo "${CERTBOT}" renew --quiet
fi

sudo systemctl enable --now snap.certbot.renew.timer
sudo install -m 0644 \
    "${RELEASE_DIR}/infra/aws/queuepilot-api.nginx" \
    /etc/nginx/sites-available/queuepilot-api
sudo nginx -t

ln -sfn "${RELEASE_DIR}" "${APP_ROOT}/current-next"
mv -Tf "${APP_ROOT}/current-next" "${CURRENT_LINK}"

sudo systemctl daemon-reload
sudo systemctl enable --now queuepilot-api
sudo systemctl restart queuepilot-api
sudo systemctl reload nginx

for attempt in {1..20}; do
    if curl --fail --silent --show-error \
        "https://${PUBLIC_IP}/api/v1/health" >/dev/null; then
        echo "QueuePilot API ${DEPLOY_SHA} is healthy."
        ls -1dt "${RELEASES_DIR}"/*/ 2>/dev/null \
            | awk 'NR > 5' \
            | xargs -r rm -rf
        exit 0
    fi

    sleep 2
done

sudo systemctl status queuepilot-api --no-pager || true
sudo journalctl -u queuepilot-api -n 50 --no-pager || true
echo "QueuePilot API failed its post-deployment health check." >&2
exit 1
