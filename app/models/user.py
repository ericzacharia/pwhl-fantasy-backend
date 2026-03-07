from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    username = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    is_verified = Column(Boolean, default=False)
    two_factor_enabled = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    two_factor = relationship("TwoFactorSetup", back_populates="user", uselist=False)
    fantasy_teams = relationship("FantasyTeam", back_populates="owner")
    league_memberships = relationship("LeagueMember", back_populates="user")


class TwoFactorSetup(Base):
    __tablename__ = "two_factor_setups"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True)
    secret = Column(String, nullable=False)
    is_confirmed = Column(Boolean, default=False)
    backup_codes = Column(String)  # JSON array stored as string
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("User", back_populates="two_factor")
