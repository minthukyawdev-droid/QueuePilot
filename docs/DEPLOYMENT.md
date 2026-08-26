# Production Deployment

QueuePilot uses GitHub Actions for continuous integration and production deployment.

## Release flow

```text
Pull request
    |
    v
CI: web lint, type-check, build + API tests
    |
    v
Merge to main
    |
    +--> Netlify Git build --> web production
    |
    +--> GitHub CI succeeds --> AWS API atomic release + health check
```

Netlify watches `main` through its Git integration and publishes only after its own production build succeeds. The GitHub `Deploy production` workflow is triggered only after the `CI` workflow completes successfully for `main`; a failed GitHub check prevents the AWS deployment. The AWS workflow can also be started manually from GitHub Actions.

## GitHub configuration

Create these repository variables:

```text
AWS_HOST=13.212.155.222
AWS_USER=ubuntu
```

Create these repository secrets:

```text
AWS_SSH_PRIVATE_KEY
AWS_KNOWN_HOSTS
```

Never commit the SSH private key. `AWS_KNOWN_HOSTS` must contain the verified SSH host-key entry for the AWS host; the deployment does not accept unknown host keys.

The API deploy job uses the GitHub `production` environment. Optional reviewers or branch restrictions can be configured for that environment, but required reviewers will pause automatic deployment and therefore change the merge-to-production behavior.

## Netlify

The web app uses the root `netlify.toml`:

- base directory: `apps/web`;
- build command: `npm run build`;
- publish directory: `.next`; and
- Node.js: `20.19.0`.

Netlify automatically supplies its current Next.js adapter. Do not pin the legacy plugin unless a verified compatibility issue requires it.

One-time Netlify setup:

1. In Netlify, import `minthukyawdev-droid/QueuePilot` from GitHub.
2. Select `main` as the production branch.
3. Keep the build settings from the committed `netlify.toml`.
4. Add `NEXT_PUBLIC_API_BASE_URL=http://13.212.155.222` in Netlify's production environment variables.
5. Trigger the initial deploy.

After setup, every merge to `main` starts a Netlify production build automatically. No Netlify access token is stored in GitHub Actions.

## AWS API

The API deploys to the Ubuntu host over SSH. The first successful deployment:

1. installs nginx if needed;
2. creates `/opt/queuepilot`;
3. checks out the exact validated Git commit into a release directory;
4. creates an isolated Python virtual environment;
5. installs `services/api/requirements.txt`;
6. atomically updates `/opt/queuepilot/current`;
7. installs and restarts the `queuepilot-api` systemd service;
8. configures nginx on port 80; and
9. verifies `GET /api/v1/health`.

Only the five newest API releases are retained. A failed dependency installation does not replace the current release. If the post-deploy health check fails, the workflow fails and includes recent service logs.

Server-side environment variables live at:

```text
/etc/queuepilot/api.env
```

The deployment preserves this file. Update `CORS_ORIGINS` there when the final Netlify production domain is known, then restart the service:

```bash
sudo systemctl restart queuepilot-api
```

Useful server checks:

```bash
sudo systemctl status queuepilot-api
sudo journalctl -u queuepilot-api -n 100 --no-pager
curl http://127.0.0.1/api/v1/health
```

## TLS limitation

The initial AWS endpoint uses the public IP over HTTP. Before browser product features call the API from Netlify, assign an API domain and configure HTTPS. An HTTPS Netlify page cannot safely call an HTTP API because browsers block mixed content.

## Rollback

- Netlify: restore a previous production deploy from the Netlify deploy history.
- AWS: point `/opt/queuepilot/current` to a previous release and restart `queuepilot-api`. Perform rollback only after identifying the desired known-good commit.
