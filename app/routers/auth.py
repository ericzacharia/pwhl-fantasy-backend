from passlib.context import CryptContext
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
import json

from app.database import get_db
from app.models.user import User, TwoFactorSetup
from app.schemas.user import (
    UserCreate, UserLogin, TokenResponse, UserResponse,
    TwoFactorSetupResponse, TwoFactorVerify, RefreshTokenRequest, PasswordChange
)
from app.services.auth import (
    hash_password, verify_password, create_access_token, create_refresh_token,
    decode_token, generate_totp_secret, get_totp_uri, verify_totp,
    generate_qr_code_base64, generate_backup_codes
)
from app.routers.deps import get_current_user

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/register", response_model=UserResponse, status_code=201)
def register(user_in: UserCreate, db: Session = Depends(get_db)):
    if db.query(User).filter(User.email == user_in.email).first():
        raise HTTPException(status_code=400, detail="Email already registered")
    if db.query(User).filter(User.username == user_in.username).first():
        raise HTTPException(status_code=400, detail="Username already taken")

    user = User(
        email=user_in.email,
        username=user_in.username,
        hashed_password=hash_password(user_in.password),
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return user


@router.post("/login", response_model=TokenResponse)
def login(credentials: UserLogin, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == credentials.email).first()
    if not user or not verify_password(credentials.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid email or password")
    if not user.is_active:
        raise HTTPException(status_code=403, detail="Account is disabled")

    # 2FA check
    if user.two_factor_enabled:
        if not credentials.totp_code:
            return TokenResponse(
                access_token="",
                refresh_token="",
                requires_2fa=True,
            )
        two_fa = db.query(TwoFactorSetup).filter_by(user_id=user.id, is_confirmed=True).first()
        if not two_fa or not verify_totp(two_fa.secret, credentials.totp_code):
            raise HTTPException(status_code=401, detail="Invalid 2FA code")

    access_token = create_access_token({"sub": str(user.id)})
    refresh_token = create_refresh_token({"sub": str(user.id)})

    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        user=UserResponse.model_validate(user),
    )


@router.post("/refresh", response_model=TokenResponse)
def refresh(req: RefreshTokenRequest, db: Session = Depends(get_db)):
    payload = decode_token(req.refresh_token)
    if not payload or payload.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Invalid refresh token")

    user = db.query(User).filter(User.id == int(payload["sub"])).first()
    if not user or not user.is_active:
        raise HTTPException(status_code=401, detail="User not found")

    access_token = create_access_token({"sub": str(user.id)})
    new_refresh = create_refresh_token({"sub": str(user.id)})
    return TokenResponse(access_token=access_token, refresh_token=new_refresh, user=UserResponse.model_validate(user))


@router.get("/me", response_model=UserResponse)
def get_me(current_user: User = Depends(get_current_user)):
    return current_user


@router.post("/2fa/setup", response_model=TwoFactorSetupResponse)
def setup_2fa(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    secret = generate_totp_secret()
    uri = get_totp_uri(secret, current_user.email)
    qr = generate_qr_code_base64(uri)

    existing = db.query(TwoFactorSetup).filter_by(user_id=current_user.id).first()
    if existing:
        existing.secret = secret
        existing.is_confirmed = False
    else:
        setup = TwoFactorSetup(user_id=current_user.id, secret=secret)
        db.add(setup)
    db.commit()

    return TwoFactorSetupResponse(secret=secret, qr_code_url=qr, provisioning_uri=uri)


@router.post("/2fa/verify")
def verify_2fa(verify: TwoFactorVerify, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    setup = db.query(TwoFactorSetup).filter_by(user_id=current_user.id).first()
    if not setup:
        raise HTTPException(status_code=404, detail="2FA not set up")
    if not verify_totp(setup.secret, verify.code):
        raise HTTPException(status_code=400, detail="Invalid code")

    backup_codes = generate_backup_codes()
    setup.is_confirmed = True
    setup.backup_codes = json.dumps(backup_codes)
    current_user.two_factor_enabled = True
    db.commit()

    return {"message": "2FA enabled", "backup_codes": backup_codes}


@router.post("/2fa/disable")
def disable_2fa(verify: TwoFactorVerify, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    setup = db.query(TwoFactorSetup).filter_by(user_id=current_user.id, is_confirmed=True).first()
    if not setup or not verify_totp(setup.secret, verify.code):
        raise HTTPException(status_code=400, detail="Invalid code")

    current_user.two_factor_enabled = False
    setup.is_confirmed = False
    db.commit()
    return {"message": "2FA disabled"}


@router.post("/change-password")
def change_password(req: PasswordChange, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if not verify_password(req.current_password, current_user.hashed_password):
        raise HTTPException(status_code=400, detail="Current password is incorrect")
    current_user.hashed_password = hash_password(req.new_password)
    db.commit()
    return {"message": "Password updated"}


# ── Password Reset via Email ─────────────────────────────────────────────────

import smtplib, random, string
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime, timedelta, timezone
from pydantic import BaseModel as PydanticBase

# In-memory store: {email: {"code": "123456", "expires": datetime}}
_reset_codes: dict = {}

class PasswordResetRequest(PydanticBase):
    email: str

class PasswordResetConfirm(PydanticBase):
    email: str
    code: str
    new_password: str

def _send_reset_email(to_email: str, code: str):
    import os
    host = os.getenv("SMTP_HOST", "smtp.gmail.com")
    port = int(os.getenv("SMTP_PORT", 587))
    user = os.getenv("SMTP_USER", "")
    password = os.getenv("SMTP_PASS", "")
    from_email = os.getenv("FROM_EMAIL", user)

    msg = MIMEMultipart("alternative")
    msg["Subject"] = "PWHL Fantasy — Password Reset Code"
    msg["From"] = f"PWHL Fantasy <{from_email}>"
    msg["To"] = to_email

    html = f"""
    <div style="font-family:-apple-system,sans-serif;max-width:480px;margin:0 auto;padding:32px">
      <h2 style="color:#6b21a8">PWHL Fantasy 🏒</h2>
      <p>Your password reset code is:</p>
      <div style="font-size:40px;font-weight:bold;letter-spacing:8px;color:#6b21a8;padding:24px 0">{code}</div>
      <p style="color:#666">This code expires in 15 minutes. If you didn't request this, ignore this email.</p>
    </div>
    """
    msg.attach(MIMEText(html, "html"))

    with smtplib.SMTP(host, port) as server:
        server.ehlo()
        server.starttls()
        server.login(user, password)
        server.sendmail(from_email, to_email, msg.as_string())

@router.post("/request-password-reset")
def request_password_reset(req: PasswordResetRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == req.email).first()
    # Always return success to prevent email enumeration
    if user:
        code = "".join(random.choices(string.digits, k=6))
        _reset_codes[req.email] = {
            "code": code,
            "expires": datetime.now(timezone.utc) + timedelta(minutes=15)
        }
        try:
            _send_reset_email(req.email, code)
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Failed to send email: {str(e)}")
    return {"message": "If that email is registered, a reset code has been sent."}

@router.post("/confirm-password-reset")
def confirm_password_reset(req: PasswordResetConfirm, db: Session = Depends(get_db)):
    entry = _reset_codes.get(req.email)
    if not entry:
        raise HTTPException(status_code=400, detail="No reset code found. Please request a new one.")
    if datetime.now(timezone.utc) > entry["expires"]:
        del _reset_codes[req.email]
        raise HTTPException(status_code=400, detail="Code expired. Please request a new one.")
    if entry["code"] != req.code:
        raise HTTPException(status_code=400, detail="Invalid code.")

    user = db.query(User).filter(User.email == req.email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found.")

    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    user.hashed_password = pwd_context.hash(req.new_password)
    db.commit()
    del _reset_codes[req.email]
    return {"message": "Password updated successfully."}
