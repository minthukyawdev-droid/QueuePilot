# Architecture Decision Log

## ADR-001 — Monorepo

**Decision:** Keep web, API, and documentation in one repository.

**Reason:** Simplifies collaboration and GitHub setup.

**Tradeoff:** Owners must coordinate to avoid cross-area conflicts.

## ADR-002 — Next.js web frontend

**Decision:** Use Next.js App Router, TypeScript, and Tailwind CSS.

**Reason:** Enables fast hackathon development and Netlify deployment.

**Tradeoff:** The team accepts framework conventions and Node.js tooling.

## ADR-003 — FastAPI backend

**Decision:** Use FastAPI with Pydantic.

**Reason:** Supports simple Python API development and future AI integration.

**Tradeoff:** The project uses separate JavaScript and Python toolchains.

## ADR-004 — REST contract between web and API

**Decision:** Communicate through a versioned HTTPS REST API.

**Reason:** Creates clear frontend/backend ownership.

**Tradeoff:** Contract changes require synchronized documentation and code.

## ADR-005 — No database in initial foundation

**Decision:** Do not add persistence yet.

**Reason:** No business feature requires it yet.

**Tradeoff:** Future stateful features will require a deliberate storage decision.

## ADR-006 — FastAPI is future AI gateway

**Decision:** Route future AI requests through FastAPI.

**Reason:** Secrets must not be exposed to browser code.

**Tradeoff:** AI requests add backend responsibility and latency.

## ADR-007 — FastAPI integrates with future n8n automation

**Decision:** Route future n8n communication through FastAPI.

**Reason:** Keep automation outside the frontend.

**Tradeoff:** The backend must later define webhook security, errors, and retries.

## ADR-008 — GitHub Actions gates production

**Decision:** Run web and API checks in GitHub Actions and deploy the API from `main` only after its CI workflow succeeds.

**Reason:** Keeps production aligned with validated merged code.

**Tradeoff:** GitHub Actions or credential outages can delay deployment.

## ADR-009 — Atomic API releases on AWS

**Decision:** Deploy FastAPI into commit-specific release directories and atomically update a systemd-managed current release behind nginx.

**Reason:** A failed install must not replace the running API.

**Tradeoff:** The host keeps several release copies and requires basic server maintenance.

## ADR-010 — Netlify Git integration

**Decision:** Connect Netlify directly to the GitHub repository and use `main` as its production branch.

**Reason:** Netlify can build and publish the Next.js app without storing a personal Netlify token in GitHub Actions.

**Tradeoff:** Netlify uses its own build result rather than waiting for the separate GitHub CI workflow.

## ADR-011 — Let's Encrypt IP certificate

**Decision:** Use an automatically renewed, short-lived Let's Encrypt certificate for the AWS public IP.

**Reason:** Provides browser-trusted HTTPS before an API domain is available.

**Tradeoff:** Six-day certificates require reliable twice-daily renewal checks and port 80 access.
