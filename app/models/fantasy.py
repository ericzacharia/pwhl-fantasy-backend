from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, Float, JSON
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base


class FantasyTeam(Base):
    __tablename__ = "fantasy_teams"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    owner_id = Column(Integer, ForeignKey("users.id"))
    league_id = Column(Integer, ForeignKey("leagues.id"))
    total_points = Column(Float, default=0.0)
    wins = Column(Integer, default=0)
    losses = Column(Integer, default=0)
    ties = Column(Integer, default=0)
    waiver_priority = Column(Integer, default=1)
    faab_budget = Column(Float, default=100.0)
    logo_url = Column(String)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    owner = relationship("User", back_populates="fantasy_teams")
    league = relationship("League", back_populates="teams")
    roster = relationship("FantasyRoster", back_populates="fantasy_team")
    draft_picks = relationship("DraftPick", back_populates="fantasy_team")
    trades_offered = relationship("Trade", foreign_keys="Trade.proposing_team_id", back_populates="proposing_team")
    trades_received = relationship("Trade", foreign_keys="Trade.receiving_team_id", back_populates="receiving_team")


class FantasyRoster(Base):
    __tablename__ = "fantasy_rosters"

    id = Column(Integer, primary_key=True, index=True)
    fantasy_team_id = Column(Integer, ForeignKey("fantasy_teams.id"), index=True)
    player_id = Column(Integer, ForeignKey("players.id"), index=True)
    slot = Column(String(20), default="bench")  # active, bench, ir
    position_slot = Column(String(5))  # C, LW, RW, D, G, F, UTIL, BN, IR
    acquired_via = Column(String(20), default="draft")  # draft, waiver, trade, free_agent
    acquired_at = Column(DateTime(timezone=True), server_default=func.now())
    is_active = Column(Boolean, default=True)

    fantasy_team = relationship("FantasyTeam", back_populates="roster")
    player = relationship("Player", back_populates="roster_entries")


class DraftSession(Base):
    __tablename__ = "draft_sessions"

    id = Column(Integer, primary_key=True, index=True)
    league_id = Column(Integer, ForeignKey("leagues.id"), unique=True)
    status = Column(String(20), default="pending")  # pending, in_progress, completed, paused
    current_pick_number = Column(Integer, default=1)
    total_picks = Column(Integer, default=0)
    pick_time_limit = Column(Integer, default=90)  # seconds
    current_pick_started_at = Column(DateTime(timezone=True))
    started_at = Column(DateTime(timezone=True))
    completed_at = Column(DateTime(timezone=True))
    created_at = Column(DateTime(timezone=True), server_default=func.now())


class DraftPick(Base):
    __tablename__ = "draft_picks"

    id = Column(Integer, primary_key=True, index=True)
    league_id = Column(Integer, ForeignKey("leagues.id"), index=True)
    fantasy_team_id = Column(Integer, ForeignKey("fantasy_teams.id"))
    player_id = Column(Integer, ForeignKey("players.id"), nullable=True)
    pick_number = Column(Integer, nullable=False)
    round_number = Column(Integer, nullable=False)
    pick_in_round = Column(Integer, nullable=False)
    is_made = Column(Boolean, default=False)
    made_at = Column(DateTime(timezone=True))
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    league = relationship("League", back_populates="draft_picks")
    fantasy_team = relationship("FantasyTeam", back_populates="draft_picks")
    player = relationship("Player")


class Trade(Base):
    __tablename__ = "trades"

    id = Column(Integer, primary_key=True, index=True)
    league_id = Column(Integer, ForeignKey("leagues.id"), index=True)
    proposing_team_id = Column(Integer, ForeignKey("fantasy_teams.id"))
    receiving_team_id = Column(Integer, ForeignKey("fantasy_teams.id"))
    status = Column(String(20), default="pending")  # pending, accepted, rejected, cancelled, vetoed
    message = Column(String)
    proposed_at = Column(DateTime(timezone=True), server_default=func.now())
    responded_at = Column(DateTime(timezone=True))

    proposing_team = relationship("FantasyTeam", foreign_keys=[proposing_team_id], back_populates="trades_offered")
    receiving_team = relationship("FantasyTeam", foreign_keys=[receiving_team_id], back_populates="trades_received")
    items = relationship("TradeItem", back_populates="trade")


class TradeItem(Base):
    __tablename__ = "trade_items"

    id = Column(Integer, primary_key=True, index=True)
    trade_id = Column(Integer, ForeignKey("trades.id"))
    player_id = Column(Integer, ForeignKey("players.id"))
    from_team_id = Column(Integer, ForeignKey("fantasy_teams.id"))
    to_team_id = Column(Integer, ForeignKey("fantasy_teams.id"))

    trade = relationship("Trade", back_populates="items")
    player = relationship("Player")


class Waiver(Base):
    __tablename__ = "waivers"

    id = Column(Integer, primary_key=True, index=True)
    league_id = Column(Integer, ForeignKey("leagues.id"), index=True)
    fantasy_team_id = Column(Integer, ForeignKey("fantasy_teams.id"))
    player_add_id = Column(Integer, ForeignKey("players.id"))
    player_drop_id = Column(Integer, ForeignKey("players.id"), nullable=True)
    status = Column(String(20), default="pending")  # pending, processed, failed
    priority = Column(Integer, default=0)
    bid_amount = Column(Float, default=0.0)
    requested_at = Column(DateTime(timezone=True), server_default=func.now())
    processed_at = Column(DateTime(timezone=True))

    player_add = relationship("Player", foreign_keys=[player_add_id])
    player_drop = relationship("Player", foreign_keys=[player_drop_id])


class LineupSnapshot(Base):
    """Daily lineup record — captures which players were in which slots on a given date.
    Created when lineup is submitted or auto-carried forward at game time."""
    __tablename__ = "lineup_snapshots"

    id = Column(Integer, primary_key=True, index=True)
    fantasy_team_id = Column(Integer, ForeignKey("fantasy_teams.id"), index=True)
    snapshot_date = Column(Date, nullable=False, index=True)
    slot_label = Column(String(10), nullable=False)   # "F_0", "D_1", "UTIL_0", etc.
    slot_type = Column(String(6), nullable=False)     # "F", "D", "G", "UTIL", "BN"
    player_id = Column(Integer, ForeignKey("players.id"), nullable=True)
    fantasy_points_earned = Column(Float, default=0.0)  # points scored in this slot this day
    locked_at = Column(DateTime(timezone=True))         # when lineup was locked for this date
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    __table_args__ = (
        UniqueConstraint("fantasy_team_id", "snapshot_date", "slot_label",
                         name="uq_lineup_snapshot_team_date_slot"),
    )
