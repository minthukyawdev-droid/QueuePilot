# QueuePilot API Contract

This document is the shared agreement between web and API developers. Except for the health check, every endpoint below is a future contract and has no implementation in the initial foundation.

Base path: `/api/v1`

Content type: `application/json`

## Health Check

```http
GET /api/v1/health
```

**STATUS: IMPLEMENTED — FOUNDATION VALIDATION ONLY**

Expected `200 OK` response:

```json
{
  "status": "ok",
  "service": "queuepilot-api"
}
```

## Join Queue

```http
POST /api/v1/queue/join
```

**STATUS: PLANNED — NOT IMPLEMENTED**

Example request:

```json
{
  "service_type": "passport_renewal",
  "name": "Demo User",
  "email": "demo@example.com"
}
```

Example future response:

```json
{
  "queue_id": "queue-123",
  "ticket_number": "A105",
  "now_serving": "A087",
  "people_ahead": 17,
  "estimated_wait_minutes": 34,
  "counter": 3,
  "status": "waiting"
}
```

## Queue Status

```http
GET /api/v1/queue/{queue_id}
```

**STATUS: PLANNED — NOT IMPLEMENTED**

The final request parameters and response schema must be agreed before implementation. They must not be inferred from product mockups.

## AI Preparation

```http
POST /api/v1/assistant/prepare
```

**STATUS: PLANNED — NOT IMPLEMENTED**

The final preparation context, response schema, and failure behavior require team agreement before implementation.

## AI Chat

```http
POST /api/v1/assistant/chat
```

**STATUS: PLANNED — NOT IMPLEMENTED**

The final conversation identifiers, message schema, response schema, and retention behavior require team agreement before implementation.

## Automation

Future n8n integration will be called by FastAPI, not by browser code. Its webhook payloads, authentication method, retries, and notification semantics will be documented when the integration is designed. No public automation endpoint or n8n implementation exists in this foundation.

## Standard error shape

Future API errors should use:

```json
{
  "detail": {
    "code": "ERROR_CODE",
    "message": "Human-readable message"
  }
}
```

Endpoint-specific error codes and HTTP statuses must be added to this contract when those endpoints are designed.

## API contract governance

No developer may independently change:

- endpoint paths;
- HTTP methods;
- field names;
- field types;
- enum values; or
- response structures.

Required procedure:

```text
1. Discuss with Integration Lead.
2. Update API_CONTRACT.md.
3. Update backend.
4. Update frontend.
5. Verify integration.
6. Commit contract change clearly.
```

Planned examples are not permission to implement endpoints without an assigned feature task.
