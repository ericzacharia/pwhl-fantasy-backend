from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session, joinedload
from typing import List
import random

from app.database import get_db
from app.models.user import User
from app.models.league import League, LeagueMember, ScoringSettings, LeagueInvite
from app.models.fantasy import FantasyTeam, DraftPick, DraftSession
from app.models.player import Player
from app.schemas.league import (
    LeagueCreate, LeagueJoin, LeagueResponse, FantasyTeamCreate,
    FantasyTeamResponse, ScoringSettingsUpdate, ScoringSettingsResponse,
    DraftStateResponse, DraftPickResponse, MakeDraftPick,
    TradeCreate, TradeResponse, WaiverRequest, RosterSlotUpdate
)
from app.routers.deps import get_current_user

router = APIRouter(prefix="/leagues", tags=["leagues"])


def league_to_response(league: League) -> LeagueResponse:
    return LeagueResponse(
        id=league.id,
        name=league.name,
        commissioner_id=league.commissioner_id,
        invite_code=league.invite_code,
        max_teams=league.max_teams,
        is_public=league.is_public,
        draft_type=league.draft_type,
        draft_status=league.draft_status,
        season=league.season,
        roster_size=league.roster_size,
        active_roster_size=league.active_roster_size,
        ir_slots=league.ir_slots,
        is_active=league.is_active,
        member_count=len(league.members),
        created_at=league.created_at,
    )


@router.post("", response_model=LeagueResponse, status_code=201)
def create_league(
    league_in: LeagueCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    # One team per league — check if user is already commissioner of an active league with same name
    # (primary guard is in draft/team creation flows)
    league = League(
        name=league_in.name,
        commissioner_id=current_user.id,
        max_teams=league_in.max_teams,
        is_public=league_in.is_public,
        draft_type=league_in.draft_type,
        roster_size=league_in.roster_size,
        active_roster_size=league_in.active_roster_size,
        ir_slots=league_in.ir_slots,
    )
    db.add(league)
    db.flush()

    # Default scoring settings
    scoring = ScoringSettings(league_id=league.id)
    db.add(scoring)

    # Add commissioner as member
    member = LeagueMember(league_id=league.id, user_id=current_user.id, role="commissioner")
    db.add(member)

    db.commit()
    db.refresh(league)
    return league_to_response(league)


@router.get("", response_model=List[LeagueResponse])
def list_my_leagues(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    memberships = db.query(LeagueMember).filter_by(user_id=current_user.id).all()
    league_ids = [m.league_id for m in memberships]
    leagues = db.query(League).options(joinedload(League.members)).filter(League.id.in_(league_ids)).all()
    return [league_to_response(l) for l in leagues]


@router.get("/public", response_model=List[LeagueResponse])
def list_public_leagues(db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    leagues = db.query(League).options(joinedload(League.members)).filter(
        League.is_public == True, League.is_active == True
    ).limit(50).all()
    return [league_to_response(l) for l in leagues]


@router.get("/{league_id}", response_model=LeagueResponse)
def get_league(league_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    league = db.query(League).options(joinedload(League.members)).filter(League.id == league_id).first()
    if not league:
        raise HTTPException(status_code=404, detail="League not found")
    return league_to_response(league)


@router.post("/join", response_model=LeagueResponse)
def join_league(
    req: LeagueJoin,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    league = db.query(League).options(joinedload(League.members)).filter(
        League.invite_code == req.invite_code
    ).first()
    if not league:
        raise HTTPException(status_code=404, detail="Invalid invite code")
    if len(league.members) >= league.max_teams:
        raise HTTPException(status_code=400, detail="League is full")

    existing = db.query(LeagueMember).filter_by(league_id=league.id, user_id=current_user.id).first()
    if existing:
        raise HTTPException(status_code=400, detail="Already a member of this league")

    # One team per league per user
    existing_team = db.query(FantasyTeam).filter_by(league_id=league.id, owner_id=current_user.id).first()
    if existing_team:
        raise HTTPException(status_code=400, detail="You already have a team in this league")

    member = LeagueMember(league_id=league.id, user_id=current_user.id)
    db.add(member)
    db.commit()
    db.refresh(league)
    return league_to_response(league)


@router.get("/{league_id}/scoring", response_model=ScoringSettingsResponse)
def get_scoring(league_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    scoring = db.query(ScoringSettings).filter_by(league_id=league_id).first()
    if not scoring:
        raise HTTPException(status_code=404, detail="Scoring settings not found")
    return scoring


@router.put("/{league_id}/scoring", response_model=ScoringSettingsResponse)
def update_scoring(
    league_id: int,
    settings_in: ScoringSettingsUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    league = db.query(League).filter_by(id=league_id, commissioner_id=current_user.id).first()
    if not league:
        raise HTTPException(status_code=403, detail="Only the commissioner can update scoring")

    scoring = db.query(ScoringSettings).filter_by(league_id=league_id).first()
    for k, v in settings_in.model_dump().items():
        setattr(scoring, k, v)
    db.commit()
    db.refresh(scoring)
    return scoring


# --- Fantasy Teams ---

@router.post("/{league_id}/teams", response_model=FantasyTeamResponse, status_code=201)
def create_fantasy_team(
    league_id: int,
    team_in: FantasyTeamCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    # Verify membership
    member = db.query(LeagueMember).filter_by(league_id=league_id, user_id=current_user.id).first()
    if not member:
        raise HTTPException(status_code=403, detail="Not a member of this league")

    existing = db.query(FantasyTeam).filter_by(league_id=league_id, owner_id=current_user.id).first()
    if existing:
        raise HTTPException(status_code=400, detail="Already have a team in this league")

    team = FantasyTeam(name=team_in.name, owner_id=current_user.id, league_id=league_id)
    db.add(team)
    db.commit()
    db.refresh(team)
    return team


@router.get("/{league_id}/teams", response_model=List[FantasyTeamResponse])
def list_fantasy_teams(league_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    return db.query(FantasyTeam).filter_by(league_id=league_id).all()


@router.get("/{league_id}/teams/{team_id}", response_model=FantasyTeamResponse)
def get_fantasy_team(league_id: int, team_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    team = db.query(FantasyTeam).filter_by(id=team_id, league_id=league_id).first()
    if not team:
        raise HTTPException(status_code=404, detail="Team not found")
    return team


@router.get("/{league_id}/standings", response_model=List[FantasyTeamResponse])
def get_standings(league_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    teams = db.query(FantasyTeam).filter_by(league_id=league_id).order_by(
        FantasyTeam.total_points.desc()
    ).all()
    return teams


# --- Draft ---

@router.post("/{league_id}/draft/start")
def start_draft(
    league_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    league = db.query(League).filter_by(id=league_id, commissioner_id=current_user.id).first()
    if not league:
        raise HTTPException(status_code=403, detail="Only commissioner can start the draft")
    if league.draft_status != "pending":
        raise HTTPException(status_code=400, detail="Draft already started or completed")

    teams = db.query(FantasyTeam).filter_by(league_id=league_id).all()
    if len(teams) < 2:
        raise HTTPException(status_code=400, detail="Need at least 2 teams to start draft")

    # Set snake draft order
    team_ids = [t.id for t in teams]
    random.shuffle(team_ids)
    league.draft_order = team_ids
    league.draft_status = "in_progress"

    # Generate picks (snake draft, 20 rounds)
    rounds = league.roster_size
    picks = []
    pick_num = 1
    for round_num in range(1, rounds + 1):
        order = team_ids if round_num % 2 == 1 else list(reversed(team_ids))
        for pick_in_round, team_id in enumerate(order, 1):
            pick = DraftPick(
                league_id=league_id,
                fantasy_team_id=team_id,
                pick_number=pick_num,
                round_number=round_num,
                pick_in_round=pick_in_round,
            )
            picks.append(pick)
            pick_num += 1

    db.add_all(picks)

    session = DraftSession(
        league_id=league_id,
        status="in_progress",
        total_picks=len(picks),
        current_pick_number=1,
    )
    db.add(session)
    db.commit()

    return {"message": "Draft started", "draft_order": team_ids, "total_picks": len(picks)}


@router.get("/{league_id}/draft", response_model=DraftStateResponse)
def get_draft_state(league_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    league = db.query(League).filter_by(id=league_id).first()
    if not league:
        raise HTTPException(status_code=404, detail="League not found")

    session = db.query(DraftSession).filter_by(league_id=league_id).first()
    picks = db.query(DraftPick).filter_by(league_id=league_id).order_by(DraftPick.pick_number).all()

    current_team_id = None
    if league.draft_status == "in_progress" and picks:
        current_pick = next((p for p in picks if not p.is_made), None)
        if current_pick:
            current_team_id = current_pick.fantasy_team_id

    return DraftStateResponse(
        league_id=league_id,
        status=league.draft_status,
        current_pick_number=session.current_pick_number if session else 1,
        total_picks=session.total_picks if session else 0,
        draft_order=league.draft_order,
        picks=[DraftPickResponse.model_validate(p) for p in picks],
        current_team_id=current_team_id,
    )


@router.post("/{league_id}/draft/pick")
def make_draft_pick(
    league_id: int,
    pick_in: MakeDraftPick,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    league = db.query(League).filter_by(id=league_id).first()
    if not league or league.draft_status != "in_progress":
        raise HTTPException(status_code=400, detail="Draft is not in progress")

    my_team = db.query(FantasyTeam).filter_by(league_id=league_id, owner_id=current_user.id).first()
    if not my_team:
        raise HTTPException(status_code=403, detail="You don't have a team in this league")

    session = db.query(DraftSession).filter_by(league_id=league_id).first()
    current_pick = db.query(DraftPick).filter_by(
        league_id=league_id,
        pick_number=session.current_pick_number,
    ).first()

    if not current_pick or current_pick.is_made:
        raise HTTPException(status_code=400, detail="No pending pick")
    if current_pick.fantasy_team_id != my_team.id:
        raise HTTPException(status_code=403, detail="Not your turn to pick")

    # Check player not already drafted
    already_picked = db.query(DraftPick).filter_by(
        league_id=league_id, player_id=pick_in.player_id, is_made=True
    ).first()
    if already_picked:
        raise HTTPException(status_code=400, detail="Player already drafted")

    # Make the pick
    from datetime import datetime, timezone
    from app.models.fantasy import FantasyRoster
    from app.models.player import Player

    player = db.query(Player).filter_by(id=pick_in.player_id).first()
    if not player:
        raise HTTPException(status_code=404, detail="Player not found")

    current_pick.player_id = pick_in.player_id
    current_pick.is_made = True
    current_pick.made_at = datetime.now(timezone.utc)

    roster_entry = FantasyRoster(
        fantasy_team_id=my_team.id,
        player_id=pick_in.player_id,
        slot="bench",
        acquired_via="draft",
    )
    db.add(roster_entry)

    session.current_pick_number += 1

    # Check if draft complete
    remaining = db.query(DraftPick).filter_by(league_id=league_id, is_made=False).count()
    if remaining == 0:
        league.draft_status = "completed"
        session.status = "completed"

    db.commit()
    return {"message": "Pick made", "player_id": pick_in.player_id, "pick_number": current_pick.pick_number}


# --- Roster Management ---

@router.get("/{league_id}/teams/{team_id}/roster")
def get_roster(league_id: int, team_id: int, db: Session = Depends(get_db), _: User = Depends(get_current_user)):
    from app.models.fantasy import FantasyRoster
    from app.models.player import Player
    from sqlalchemy.orm import joinedload

    entries = (
        db.query(FantasyRoster)
        .options(joinedload(FantasyRoster.player).joinedload(Player.stats))
        .filter_by(fantasy_team_id=team_id, is_active=True)
        .all()
    )

    result = []
    for entry in entries:
        season_stat = next(
            (s for s in entry.player.stats if s.season == "2024-2025" and s.is_season_total), None
        )
        result.append({
            "roster_id": entry.id,
            "player_id": entry.player_id,
            "player_name": entry.player.full_name,
            "position": entry.player.position,
            "slot": entry.slot,
            "position_slot": entry.position_slot,
            "acquired_via": entry.acquired_via,
            "fantasy_points": season_stat.fantasy_points if season_stat else 0.0,
        })
    return result


@router.put("/{league_id}/teams/{team_id}/roster/slot")
def update_roster_slot(
    league_id: int,
    team_id: int,
    req: RosterSlotUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    from app.models.fantasy import FantasyRoster

    team = db.query(FantasyTeam).filter_by(id=team_id, league_id=league_id, owner_id=current_user.id).first()
    if not team:
        raise HTTPException(status_code=403, detail="Not your team")

    entry = db.query(FantasyRoster).filter_by(fantasy_team_id=team_id, player_id=req.player_id, is_active=True).first()
    if not entry:
        raise HTTPException(status_code=404, detail="Player not on roster")

    entry.slot = req.slot
    if req.position_slot:
        entry.position_slot = req.position_slot
    db.commit()
    return {"message": "Roster updated"}


@router.post("/{league_id}/teams/{team_id}/drop")
def drop_player(
    league_id: int,
    team_id: int,
    player_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    from app.models.fantasy import FantasyRoster

    team = db.query(FantasyTeam).filter_by(id=team_id, league_id=league_id, owner_id=current_user.id).first()
    if not team:
        raise HTTPException(status_code=403, detail="Not your team")

    entry = db.query(FantasyRoster).filter_by(fantasy_team_id=team_id, player_id=player_id, is_active=True).first()
    if not entry:
        raise HTTPException(status_code=404, detail="Player not on roster")

    entry.is_active = False
    db.commit()
    return {"message": "Player dropped"}


# --- Waivers ---

@router.post("/{league_id}/waivers")
def submit_waiver(
    league_id: int,
    req: WaiverRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    from app.models.fantasy import Waiver, FantasyRoster

    my_team = db.query(FantasyTeam).filter_by(league_id=league_id, owner_id=current_user.id).first()
    if not my_team:
        raise HTTPException(status_code=403, detail="You don't have a team in this league")

    # Check player is a free agent (not on any roster in this league)
    existing = (
        db.query(FantasyRoster)
        .join(FantasyTeam)
        .filter(FantasyTeam.league_id == league_id, FantasyRoster.player_id == req.player_add_id, FantasyRoster.is_active == True)
        .first()
    )
    if existing:
        raise HTTPException(status_code=400, detail="Player is already on a roster")

    waiver = Waiver(
        league_id=league_id,
        fantasy_team_id=my_team.id,
        player_add_id=req.player_add_id,
        player_drop_id=req.player_drop_id,
        bid_amount=req.bid_amount,
        priority=my_team.waiver_priority,
    )
    db.add(waiver)
    db.commit()
    return {"message": "Waiver claim submitted"}


# --- Trades ---

@router.post("/{league_id}/trades", response_model=TradeResponse, status_code=201)
def propose_trade(
    league_id: int,
    trade_in: TradeCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    from app.models.fantasy import Trade, TradeItem

    my_team = db.query(FantasyTeam).filter_by(league_id=league_id, owner_id=current_user.id).first()
    if not my_team:
        raise HTTPException(status_code=403, detail="Not a member of this league")

    receiving_team = db.query(FantasyTeam).filter_by(id=trade_in.receiving_team_id, league_id=league_id).first()
    if not receiving_team:
        raise HTTPException(status_code=404, detail="Receiving team not found")

    trade = Trade(
        league_id=league_id,
        proposing_team_id=my_team.id,
        receiving_team_id=receiving_team.id,
        message=trade_in.message,
    )
    db.add(trade)
    db.flush()

    for player_id in trade_in.proposing_player_ids:
        db.add(TradeItem(trade_id=trade.id, player_id=player_id, from_team_id=my_team.id, to_team_id=receiving_team.id))
    for player_id in trade_in.receiving_player_ids:
        db.add(TradeItem(trade_id=trade.id, player_id=player_id, from_team_id=receiving_team.id, to_team_id=my_team.id))

    db.commit()
    db.refresh(trade)
    return trade


@router.get("/{league_id}/trades", response_model=List[TradeResponse])
def list_trades(league_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    from app.models.fantasy import Trade

    my_team = db.query(FantasyTeam).filter_by(league_id=league_id, owner_id=current_user.id).first()
    if not my_team:
        return []

    trades = db.query(Trade).filter(
        Trade.league_id == league_id,
        (Trade.proposing_team_id == my_team.id) | (Trade.receiving_team_id == my_team.id)
    ).all()
    return trades


@router.post("/{league_id}/trades/{trade_id}/respond")
def respond_to_trade(
    league_id: int,
    trade_id: int,
    action: str,  # accept, reject
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    from app.models.fantasy import Trade, TradeItem, FantasyRoster
    from datetime import datetime, timezone

    trade = db.query(Trade).filter_by(id=trade_id, league_id=league_id).first()
    if not trade:
        raise HTTPException(status_code=404, detail="Trade not found")

    my_team = db.query(FantasyTeam).filter_by(league_id=league_id, owner_id=current_user.id).first()
    if not my_team or my_team.id != trade.receiving_team_id:
        raise HTTPException(status_code=403, detail="Not authorized")

    if action not in ("accept", "reject"):
        raise HTTPException(status_code=400, detail="Action must be 'accept' or 'reject'")

    trade.status = "accepted" if action == "accept" else "rejected"
    trade.responded_at = datetime.now(timezone.utc)

    if action == "accept":
        # Execute trade - swap players
        for item in trade.items:
            roster_entry = db.query(FantasyRoster).filter_by(
                player_id=item.player_id, fantasy_team_id=item.from_team_id, is_active=True
            ).first()
            if roster_entry:
                roster_entry.fantasy_team_id = item.to_team_id
                roster_entry.acquired_via = "trade"

    db.commit()
    return {"message": f"Trade {action}ed"}
