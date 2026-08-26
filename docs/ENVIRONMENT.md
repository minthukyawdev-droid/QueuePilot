# Environment Configuration

Commit `.env.example` files, never real `.env` files. Copy the relevant example locally and supply values outside Git.

## Web

Location: `apps/web/.env.local`

```text
NEXT_PUBLIC_API_BASE_URL=http://localhost:8000
```

`NEXT_PUBLIC_` values are exposed to browser code and must never contain secrets. The API base URL is documented for future API consumption; the foundation web page does not call the API.

## Backend

Location: `services/api/.env`

```text
APP_ENV=development
CORS_ORIGINS=http://localhost:3000
```

The foundation reads these settings. CORS must list allowed web origins explicitly.

## Future backend-only variables

These variables are planned but unused:

```text
OPENAI_API_KEY=
OPENAI_MODEL=
N8N_WEBHOOK_URL=
```

Do not add real values to Git. AI credentials and sensitive automation URLs belong only in backend host environment settings.

## Deployment

- Configure `NEXT_PUBLIC_API_BASE_URL` in the Netlify production environment.
- Configure backend variables in `/etc/queuepilot/api.env` on the AWS host.
- Keep deployment configuration free of secrets.
- Update this document whenever a required variable is introduced, renamed, or removed.

GitHub Actions deployment credentials are documented in `docs/DEPLOYMENT.md`. They belong in GitHub repository secrets or variables, never in application `.env` files.
