# QueuePilot

**Don't just wait. Get ready.**

QueuePilot is a planned AI-powered waiting assistant that will help people understand their wait, prepare for an upcoming service, and know when their turn is approaching.

## Current Status

> Initial project foundation only. Product features are intentionally not implemented yet.

This repository currently provides runnable Next.js and FastAPI foundations, team collaboration rules, and planning documentation.

## Architecture

```text
apps/web     -> Next.js frontend
services/api -> FastAPI backend
docs/        -> team contracts and project documentation
```

## Requirements

- Node.js
- npm
- Python 3.11+
- Git

## Run Web

```bash
cd apps/web
npm install
npm run dev
```

Open `http://localhost:3000`.

Additional checks:

```bash
npm run lint
npm run typecheck
npm run build
```

## Run API

### Windows

```bash
cd services/api
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

If `python` is not on `PATH`, use the Windows launcher (`py`) for the environment creation command.

### macOS/Linux

```bash
cd services/api
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

API: `http://localhost:8000`

Swagger: `http://localhost:8000/docs`

Health: `http://localhost:8000/api/v1/health`

Run tests:

```bash
pytest
```

## Team Contract

`docs/API_CONTRACT.md` is the team agreement between frontend and backend. Contract changes require coordination and synchronized documentation, backend, and frontend updates.

Start with `AGENTS.md`, then read the nested instructions for your ownership area and `docs/DEVELOPMENT_WORKFLOW.md`.

## CI/CD

Pull requests and `main` are checked with GitHub Actions. After CI passes for a commit on `main`, production deployment updates the web app on Netlify and the API on AWS.

See `docs/DEPLOYMENT.md` for required GitHub configuration, server operations, and the current API TLS limitation.
