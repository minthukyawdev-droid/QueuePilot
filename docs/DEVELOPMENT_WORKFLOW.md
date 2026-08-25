# Development Workflow

## Branches

```text
main
feature/web-*
feature/api-*
feature/ai-*
feature/integration-*
```

Create feature branches from an up-to-date `main`. Do not do direct feature development on `main`.

## Daily hackathon workflow

1. Pull before beginning work.
2. Confirm the ownership area and read its `AGENTS.md`.
3. Make the smallest working change.
4. Run relevant checks.
5. Commit small, coherent increments.
6. Push regularly.
7. Open small pull requests.
8. Merge working increments frequently so `main` remains runnable.

Avoid modifying another developer's ownership area. Coordinate API changes before implementation and update `docs/API_CONTRACT.md` in the same coordinated change.

## Commit convention

```text
chore: initialize QueuePilot foundation
feat(web): ...
feat(api): ...
feat(ai): ...
fix(web): ...
fix(api): ...
docs: ...
```

Use imperative, scoped messages that describe one coherent change.

## Pull requests

- State the ownership area.
- Identify API contract impact.
- Include relevant validation.
- Exclude unrelated formatting or refactoring.
- Do not commit secrets or local environment files.
- Note any effect on the working demo.

## Integration

The Integration Lead reviews cross-area compatibility and protects `main`. When a conflict occurs, preserve the latest working behavior and coordinate with both owners rather than guessing intent.
