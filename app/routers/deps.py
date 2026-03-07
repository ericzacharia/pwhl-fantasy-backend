from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.orm import Session
from app.database import get_db
from app.models.user import User
from app.services.auth import decode_token

security = HTTPBearer()


def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security),
    db: Session = Depends(get_db),
) -> User:
    payload = decode_token(credentials.credentials)
    if not payload or payload.get("type") != "access":
        raise HTTPException(status_code=401, detail="Invalid or expired token")

    user = db.query(User).filter(User.id == int(payload["sub"])).first()
    if not user or not user.is_active:
        raise HTTPException(status_code=401, detail="User not found or inactive")
    return user


security_optional = HTTPBearer(auto_error=False)

def get_current_user_optional(
    credentials: HTTPAuthorizationCredentials = Depends(security_optional),
    db: Session = Depends(get_db),
):
    """Like get_current_user but returns None instead of raising 401."""
    if not credentials:
        return None
    try:
        payload = decode_token(credentials.credentials)
        if not payload or payload.get("type") != "access":
            return None
        user = db.query(User).filter(User.id == int(payload["sub"])).first()
        return user if user and user.is_active else None
    except:
        return None
