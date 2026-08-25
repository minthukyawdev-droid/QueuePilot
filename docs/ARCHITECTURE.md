# QueuePilot Architecture

## Current foundation

The repository currently contains:

- an empty Next.js App Router web application;
- a FastAPI application with only `GET /api/v1/health`;
- environment examples and team documentation; and
- no product business logic, persistence, authentication, AI, or automation integration.

## Planned architecture

```text
                         User

                          |
                          v

                  Next.js Web App
                     + Tailwind

                          |
                       HTTPS

                          v

                       FastAPI
                          |
              +-----------+-----------+
              |           |           |
              v           v           v
           Queue       Future AI    Future n8n
           Logic       Integration  Integration
```

The web application will consume a versioned REST API. FastAPI will own business logic and will act as the future server-side gateway to AI and automation services. Browser code must not call OpenAI or n8n directly.

## Planned deployments

```text
Next.js -> Netlify
FastAPI -> Render / Railway / another Python host
n8n     -> n8n Cloud or provided environment
```

These are deployment targets, not infrastructure currently provisioned by this repository.

## Boundaries

- `apps/web/**` owns presentation and API consumption.
- `services/api/**` owns public schemas, validation, and future business logic.
- `docs/API_CONTRACT.md` defines the shared boundary.
- New infrastructure requires an explicit need; this foundation intentionally has no database, message broker, worker, Docker setup, or authentication.

## Architecture changes

Read the root and nested `AGENTS.md` files first. Coordinate cross-boundary changes with the Integration Lead and record material decisions in `docs/DECISIONS.md`.
