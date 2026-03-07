from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime, date


class PlayerStatsResponse(BaseModel):
    id: int
    season: str
    games_played: int
    goals: int
    assists: int
    points: int
    plus_minus: int
    penalty_minutes: int
    shots: int
    wins: int
    losses: int
    saves: int
    goals_against: int
    shutouts: int
    save_percentage: float
    goals_against_average: float
    fantasy_points: float
    is_season_total: bool

    model_config = {"from_attributes": True}


class PlayerResponse(BaseModel):
    id: int
    pwhl_player_id: Optional[str]
    first_name: str
    last_name: str
    position: str
    jersey_number: Optional[int]
    pwhl_team_id: Optional[int]
    team_abbreviation: Optional[str] = None
    team_logo_url: Optional[str] = None
    nationality: Optional[str]
    birthdate: Optional[str] = None
    height_cm: Optional[float] = None
    weight_kg: Optional[float] = None
    shoots: Optional[str] = None
    headshot_url: Optional[str]
    is_active: bool
    season_stats: Optional[PlayerStatsResponse] = None
    fantasy_value: Optional[float] = None

    model_config = {"from_attributes": True}


class PlayerListResponse(BaseModel):
    players: List[PlayerResponse]
    total: int
    page: int
    page_size: int


class PWHLTeamResponse(BaseModel):
    id: int
    name: str
    city: str
    abbreviation: str
    logo_url: Optional[str]
    primary_color: Optional[str]
    secondary_color: Optional[str]

    model_config = {"from_attributes": True}
