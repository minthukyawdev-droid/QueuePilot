# Security Guidelines

QueuePilot is a hackathon project. Apply practical safeguards without claiming enterprise-grade security.

## Required practices

- Keep secrets server-side.
- Keep `.env` files ignored and commit only `.env.example` placeholders.
- Validate all external input at the API boundary.
- Configure CORS with explicit trusted origins.
- Do not log secrets, credentials, sensitive webhook URLs, or unnecessary personal information.
- Keep future OpenAI credentials in the backend only.
- Treat the future n8n webhook URL as sensitive when it can trigger workflows.
- Prefer demo data during the hackathon.
- Avoid storing personal information unless a feature clearly requires it.
- Review generated code and dependencies before merging.
- Store deployment credentials only in GitHub secrets and restrict the AWS SSH key to deployment use.
- Verify the AWS SSH host key; never disable strict host-key checking in automation.

## Browser boundary

Any `NEXT_PUBLIC_` environment variable is visible to users. Browser code must not contain API secrets and must not call future OpenAI or n8n integrations directly.

## Data handling

Use fictional names and email addresses for demos. Define retention and deletion behavior before introducing persistence. Never use real government or customer data for the hackathon.

## Limitations

The initial foundation does not include authentication, authorization, rate limiting, persistent storage, abuse prevention, or production monitoring. HTTPS protects transport but does not replace these controls. These omissions must be reassessed before product endpoints or sensitive data are exposed. Document known limitations honestly in demo and deployment notes.
