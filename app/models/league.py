from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, Float, JSON
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
import secrets
from app.database import Base


class League(Base):
    __tablename__ = "leagues"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    commissioner_id = Column(Integer, ForeignKey("users.id"))
    invite_code = Column(String(12), unique=True, default=lambda: secrets.token_urlsafe(8))
    max_teams = Column(Integer, default=10)
    is_public = Column(Boolean, default=False)
    draft_type = Column(String(20), default="snake")  # snake, auction
    draft_status = Column(String(20), default="pending")  # pending, in_progress, completed
    draft_order = Column(JSON)  # list of fantasy_team_ids in draft order
    current_draft_pick = Column(Integer, default=0)
    season = Column(String(9), default="2024-2025")
    roster_size = Column(Integer, default=20)
    active_roster_size = Column(Integer, default=13)
    ir_slots = Column(Integer, default=2)
    waiver_type = Column(String(20), default="rolling")  # rolling, faab
    trade_deadline = Column(DateTime(timezone=True))
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    commissioner = relationship("User", foreign_keys=[commissioner_id])
    members = relationship("LeagueMember", back_populates="league")
    teams = relationship("FantasyTeam", back_populates="league")
    scoring_settings = relationship("ScoringSettings", back_populates="league", uselist=False)
    invites = relationship("LeagueInvite", back_populates="league")
    draft_picks = relationship("DraftPick", back_populates="league")


class LeagueMember(Base):
    __tablename__ = "league_members"

    id = Column(Integer, primary_key=True, index=True)
    league_id = Column(Integer, ForeignKey("leagues.id"))
    user_id = Column(Integer, ForeignKey("users.id"))
    role = Column(String(20), default="member")  # commissioner, member
    joined_at = Column(DateTime(timezone=True), server_default=func.now())

    league = relationship("League", back_populates="members")
    user = relationship("User", back_populates="league_memberships")


class LeagueInvite(Base):
    __tablename__ = "league_invites"

    id = Column(Integer, primary_key=True, index=True)
    league_id = Column(Integer, ForeignKey("leagues.id"))
    email = Column(String)
    invite_code = Column(String(20), unique=True, default=lambda: secrets.token_urlsafe(12))
    is_used = Column(Boolean, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    expires_at = Column(DateTime(timezone=True))

    league = relationship("League", back_populates="invites")


class ScoringSettings(Base):
    __tablename__ = "scoring_settings"

    id = Column(Integer, primary_key=True, index=True)
    league_id = Column(Integer, ForeignKey("leagues.id"), unique=True)

    # Skater scoring
    goal_pts = Column(Float, default=3.0)
    assist_pts = Column(Float, default=2.0)
    plus_minus_pts = Column(Float, default=1.0)
    pim_pts = Column(Float, default=-0.5)
    shot_pts = Column(Float, default=0.3)
    hit_pts = Column(Float, default=0.0)
    block_pts = Column(Float, default=0.0)

    # Goalie scoring
    goalie_win_pts = Column(Float, default=5.0)
    goalie_save_pts = Column(Float, default=0.2)
    goals_against_pts = Column(Float, default=-1.0)
    shutout_pts = Column(Float, default=3.0)
    goalie_loss_pts = Column(Float, default=0.0)

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    league = relationship("League", back_populates="scoring_settings")
