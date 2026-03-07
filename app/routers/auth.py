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
