# QueuePilot API Agent Instructions

## Ownership

The Backend developer owns most of `services/api/**`. The AI/Automation developer will later own assigned integration service files and must coordinate with the Backend developer when shared files are affected.

## Framework and conventions

- Use FastAPI and Python 3.11+.
- Keep public endpoints under `/api/v1`.
- Use Pydantic models for public request and response schemas.
- Keep route handlers small and move business logic into focused services only when that logic exists.
- Validate external input at the API boundary.
- Add tests for endpoint behavior.

## Allowed modifications

- API routes, configuration, schemas, and tests required by an assigned backend task.
- Future queue service files assigned to the Backend developer.
- Future AI and automation service files when coordinated with their owner.

## Forbidden modifications

- Do not modify `apps/web/**` to solve backend issues.
- Do not implement unassigned planned endpoints.
- Do not add a database, background worker, message broker, authentication, AI library, or automation client without an explicit task.
- Do not hard-code secrets.
- Do not change the public API contract independently.

## API contract

Read `docs/API_CONTRACT.md` before changing any public path, method, field, type, enum, status, or response. Coordinate contract changes with the Integration Lead, then update documentation, backend, frontend, and integration checks together.

## Commands

From `services/api` with the virtual environment active:

```bash
pip install -r requirements.txt
uvicorn app.main:app --reload
pytest
```

## Environment

Copy `.env.example` to `.env` for local-only values. Keep `.env` out of Git. Configure CORS origins explicitly. Future OpenAI credentials and n8n settings are backend-only and are not used by the foundation.

## Future responsibilities

FastAPI will eventually own queue business logic, OpenAI communication, and n8n communication. These are planned responsibilities, not current implementations.
