from typing import Literal

from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()


class HealthResponse(BaseModel):
    status: Literal["ok"]
    service: Literal["queuepilot-api"]


@router.get("/health", response_model=HealthResponse)
def health_check() -> HealthResponse:
    """Confirm that the API foundation is running."""

    return HealthResponse(status="ok", service="queuepilot-api")
