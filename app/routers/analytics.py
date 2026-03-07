from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from typing import Optional
import json

from app.database import get_db
from app.models.analytics import AnalyticsEvent, DeviceProfile
from app.routers.deps import get_current_user_optional
from app.models.user import User

router = APIRouter(prefix="/analytics", tags=["analytics"])

@router.post("/event")
async def track_event(
    request: Request,
    db: Session = Depends(get_db),
    current_user: Optional[User] = Depends(get_current_user_optional),
):
    """Receive analytics events from the iOS app."""
    body = await request.json()

    event = AnalyticsEvent(
        user_id      = current_user.id if current_user else None,
        event_type   = body.get("event_type", "unknown"),
        screen       = body.get("screen"),
        endpoint     = body.get("endpoint"),
        properties   = json.dumps(body.get("properties", {})),
        ip_address   = request.client.host if request.client else None,
        user_agent   = request.headers.get("user-agent"),
        app_version  = body.get("app_version"),
        os_version   = body.get("os_version"),
        device_model = body.get("device_model"),
        device_id    = body.get("device_id"),
        locale       = body.get("locale"),
        timezone     = body.get("timezone"),
        network_type = body.get("network_type"),
        session_id   = body.get("session_id"),
    )
    db.add(event)
    db.commit()
    return {"ok": True}

@router.post("/device")
async def upsert_device(
    request: Request,
    db: Session = Depends(get_db),
    current_user: Optional[User] = Depends(get_current_user_optional),
):
    """Register/update device profile."""
    body = await request.json()
    device_id = body.get("device_id")
    if not device_id:
        return {"ok": False, "error": "device_id required"}

    existing = db.query(DeviceProfile).filter_by(device_id=device_id).first()
    if existing:
        for field in ["device_model","os_version","app_version","locale","timezone",
                      "carrier","screen_width","screen_height","push_token"]:
            if body.get(field) is not None:
                setattr(existing, field, body[field])
        if current_user:
            existing.user_id = current_user.id
        db.commit()
    else:
        db.add(DeviceProfile(
            user_id      = current_user.id if current_user else None,
            device_id    = device_id,
            device_model = body.get("device_model"),
            os_version   = body.get("os_version"),
            app_version  = body.get("app_version"),
            locale       = body.get("locale"),
            timezone     = body.get("timezone"),
            carrier      = body.get("carrier"),
            screen_width = body.get("screen_width"),
            screen_height= body.get("screen_height"),
            push_token   = body.get("push_token"),
        ))
        db.commit()
    return {"ok": True}
