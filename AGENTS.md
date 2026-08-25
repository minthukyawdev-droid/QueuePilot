# QueuePilot Agent Instructions

## Project

QueuePilot is an AI-powered waiting assistant with the tagline **"Don't just wait. Get ready."**

The future product will help users understand their queue status, use waiting time productively, prepare for an upcoming service, and receive automated alerts as their turn approaches. These are future requirements only. Do not implement them as part of the project foundation.

## Architecture

The planned architecture is:

```text
Next.js Web
      |
      | HTTPS REST API
      v
FastAPI
      |
      +-- future queue logic
      +-- future AI integration
      +-- future n8n integration
```

The current repository contains only runnable web and API foundations, documentation, and a health endpoint.

## Agent workflow

Before modifying code:

1. Read this root `AGENTS.md`.
2. Determine which developer area owns the requested change.
3. Read the nearest nested `AGENTS.md`.
4. Read `docs/API_CONTRACT.md` if the change affects communication between frontend and backend.
5. Read `docs/ARCHITECTURE.md` before changing architecture.
6. Modify only the smallest necessary scope.
7. Do not refactor unrelated working code.
8. Do not modify another developer's ownership area without explicit coordination.
9. Never silently modify the API contract.
10. Run relevant checks after meaningful changes.

## Ownership boundaries

- Web: `apps/web/**`
- API: `services/api/**`
- AI and automation: future backend service directories, coordinated with the API owner
- Integration: cross-area compatibility, deployment, Git integration, and demo readiness

See `docs/DEVELOPER_OWNERSHIP.md` for details.

## Hackathon priorities

```text
1. Working demo
2. Stable integration
3. Core user value
4. Reliability
5. UX polish
6. Additional features
7. Architectural perfection
```

Keep changes small, explicit, and reviewable. Do not build speculative features or introduce infrastructure that has not been requested.
