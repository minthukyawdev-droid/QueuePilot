# QueuePilot Web Agent Instructions

## Ownership

The Web developer owns `apps/web/**`.

## Framework

- Next.js App Router.
- TypeScript in strict mode.
- Tailwind CSS.
- Responsive web UX.

## Allowed modifications

- Pages, layouts, components, styles, and frontend tests required by an assigned web task.
- Browser-side API consumption that follows `docs/API_CONTRACT.md`.
- Web configuration and public environment examples needed by the frontend.

## Forbidden modifications

- Do not modify `services/api/**` to solve frontend problems.
- Do not duplicate backend business logic.
- Do not call OpenAI or n8n from browser code.
- Do not expose secrets in code or `NEXT_PUBLIC_` variables.
- Do not add unassigned product UI or unnecessary UI libraries.
- Do not change the API contract independently.

## Commands

From `apps/web`:

```bash
npm install
npm run dev
npm run lint
npm run typecheck
npm run build
```

## API contract

Read `docs/API_CONTRACT.md` before adding or changing API consumption. The frontend may communicate with the backend only through documented REST endpoints. Coordinate any contract change with the API owner and Integration Lead.

## Environment

Copy `.env.example` to `.env.local` for local values. The future API base URL comes from `NEXT_PUBLIC_API_BASE_URL`. Values with the `NEXT_PUBLIC_` prefix are visible in browser code and must not contain secrets.

## Future responsibilities

This area will eventually contain the queue dashboard, preparation interface, AI-result presentation, API consumption, and loading and error states. None of those product features are implemented in the foundation.
