# Developer Ownership

Ownership reduces merge conflicts; it does not remove the need to communicate. Cross-area changes require coordination with the owner and Integration Lead.

## Developer 1 — Web Frontend

Owns:

```text
apps/web/**
```

Future responsibilities:

- Next.js and Tailwind development;
- queue dashboard;
- preparation interface;
- AI-result presentation;
- API consumption; and
- loading and error states.

Must not modify `services/api/**` without coordination.

## Developer 2 — Backend / Queue Logic

Owns most of:

```text
services/api/**
```

Future responsibilities:

- FastAPI;
- queue endpoints;
- queue status;
- queue calculations; and
- backend validation.

Public schemas and endpoints must remain aligned with `docs/API_CONTRACT.md`.

## Developer 3 — AI + Automation

Works primarily in backend integration and service files that will be created only when those features are assigned.

Future responsibilities:

- AI service;
- prompt engineering;
- OpenAI integration;
- n8n webhook integration; and
- automation workflow.

Developer 2 and Developer 3 have potential overlap inside `services/api/**` and must coordinate before modifying shared backend files. Prefer separate future directories:

```text
services/api/app/services/queue/
services/api/app/services/ai/
services/api/app/services/automation/
```

These directories are recommendations for future work and are intentionally not created by the foundation.

## Developer 4 — Integration / Product / Deployment

Responsibilities:

- Git integration;
- API coordination;
- merge review;
- environment variables;
- deployment;
- end-to-end testing;
- demo preparation; and
- scope management.

Developer 4 protects `main` and may edit multiple areas only when integration requires it. Product feature work should remain with the appropriate owner.

## Coordination rules

- Announce cross-owner edits before starting.
- Keep pull requests narrow.
- Resolve API contract questions before coding incompatible assumptions.
- Near the demo, favor integration fixes over ownership purity, but retain review by affected owners.
