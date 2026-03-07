from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime


class UserCreate(BaseModel):
    email: EmailStr
    username: str
    password: str


class UserLogin(BaseModel):
    email: EmailStr
    password: str
    totp_code: Optional[str] = None


class UserResponse(BaseModel):
    id: int
    email: str
    username: str
    is_active: bool
    two_factor_enabled: bool
    created_at: datetime

    model_config = {"from_attributes": True}


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    requires_2fa: bool = False
    user: Optional[UserResponse] = None


class TwoFactorSetupResponse(BaseModel):
    secret: str
    qr_code_url: str
    provisioning_uri: str


class TwoFactorVerify(BaseModel):
    code: str


class RefreshTokenRequest(BaseModel):
    refresh_token: str


class PasswordChange(BaseModel):
    current_password: str
    new_password: str
