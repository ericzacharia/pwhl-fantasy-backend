from pydantic import BaseModel
from typing import Optional, List, Any
from datetime import datetime


class LeagueCreate(BaseModel):
    name: str
    max_teams: int = 10
    is_public: bool = False
    draft_type: str = "snake"
    roster_size: int = 20
    active_roster_size: int = 13
    ir_slots: int = 2


class LeagueJoin(BaseModel):
    invite_code: str


class ScoringSettingsUpdate(BaseModel):
    goal_pts: float = 3.0
    assist_pts: float = 2.0
    plus_minus_pts: float = 1.0
    pim_pts: float = -0.5
    shot_pts: float = 0.3
    hit_pts: float = 0.0
    block_pts: float = 0.0
    goalie_win_pts: float = 5.0
    goalie_save_pts: float = 0.2
    goals_against_pts: float = -1.0
    shutout_pts: float = 3.0
    goalie_loss_pts: float = 0.0


class ScoringSettingsResponse(ScoringSettingsUpdate):
    id: int
    model_config = {"from_attributes": True}


class FantasyTeamCreate(BaseModel):
    name: str
    league_id: int


class FantasyTeamResponse(BaseModel):
    id: int
    name: str
    owner_id: int
    league_id: int
    total_points: float
    wins: int
    losses: int
    ties: int
    waiver_priority: int

    model_config = {"from_attributes": True}


class LeagueResponse(BaseModel):
    id: int
    name: str
    commissioner_id: int
    invite_code: str
    max_teams: int
    is_public: bool
    draft_type: str
    draft_status: str
    season: str
    roster_size: int
    active_roster_size: int
    ir_slots: int
    is_active: bool
    member_count: int = 0
    created_at: datetime

    model_config = {"from_attributes": True}


class DraftPickResponse(BaseModel):
    id: int
    pick_number: int
    round_number: int
    pick_in_round: int
    fantasy_team_id: int
    player_id: Optional[int]
    is_made: bool

    model_config = {"from_attributes": True}


class DraftStateResponse(BaseModel):
    league_id: int
    status: str
    current_pick_number: int
    total_picks: int
    draft_order: Optional[List[int]]
    picks: List[DraftPickResponse]
    current_team_id: Optional[int]


class MakeDraftPick(BaseModel):
    player_id: int


class TradeCreate(BaseModel):
    receiving_team_id: int
    proposing_player_ids: List[int]
    receiving_player_ids: List[int]
    message: Optional[str] = None


class TradeResponse(BaseModel):
    id: int
    league_id: int
    proposing_team_id: int
    receiving_team_id: int
    status: str
    message: Optional[str]
    proposed_at: datetime

    model_config = {"from_attributes": True}


class WaiverRequest(BaseModel):
    player_add_id: int
    player_drop_id: Optional[int] = None
    bid_amount: float = 0.0


class RosterSlotUpdate(BaseModel):
    player_id: int
    slot: str  # active, bench, ir
    position_slot: Optional[str] = None
