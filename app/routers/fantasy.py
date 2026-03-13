"""
Fantasy-specific endpoints providing a clean API surface for the iOS app.
"""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from typing import List, Optional
from pydantic import BaseModel

from app.database import get_db
from app.models.user import User
from app.models.league import League, LeagueMember
from app.models.fantasy import FantasyTeam, FantasyRoster, Trade, TradeItem, Waiver
from app.models.player import Player, PlayerStats
from app.routers.deps import get_current_user

router = APIRouter(prefix="/fantasy", tags=["fantasy"])

CURRENT_SEASON = "2024-2025"


def _season_stat(player):
    return next(
        (s for s in player.stats if s.season == CURRENT_SEASON and s.is_season_total), None
    )


def _roster_entry_dict(entry):
    stat = _season_stat(entry.player)
    team_abbr = None
    if entry.player.pwhl_team:
        team_abbr = entry.player.pwhl_team.abbreviation
    return {
        "roster_id": entry.id,
        "player_id": entry.player_id,
        "player_name": entry.player.full_name,
        "position": entry.player.position or "F",
        "slot": entry.slot,
        "position_slot": entry.position_slot,
        "acquired_via": entry.acquired_via,
        "fantasy_points": stat.fantasy_points if stat else 0.0,
        "headshot_url": entry.player.headshot_url,
        "jersey_number": entry.player.jersey_number,
        "team_abbreviation": team_abbr,
        "goals": stat.goals if stat else 0,
        "assists": stat.assists if stat else 0,
        "games_played": stat.games_played if stat else 0,
        "plus_minus": stat.plus_minus if stat else 0,
        "shots": stat.shots if stat else 0,
        "penalty_minutes": stat.penalty_minutes if stat else 0,
    }


# ── My Teams ────────────────────────────────────────────────────────────────────

@router.get("/my-teams")
def get_my_teams(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    teams = (
        db.query(FantasyTeam)
        .options(joinedload(FantasyTeam.league).joinedload(League.teams))
        .filter(FantasyTeam.owner_id == current_user.id)
        .all()
    )

    result = []
    for team in teams:
        league = team.league
        if not league:
            continue
        ranked = sorted(league.teams, key=lambda t: t.total_points or 0, reverse=True)
        rank = next((i + 1 for i, t in enumerate(ranked) if t.id == team.id), 1)
        result.append({
            "id": team.id,
            "name": team.name,
            "league_id": league.id,
            "league_name": league.name,
            "league_status": league.draft_status,
            "season": league.season or CURRENT_SEASON,
            "wins": team.wins or 0,
            "losses": team.losses or 0,
            "ties": team.ties or 0,
            "total_points": team.total_points or 0.0,
            "waiver_priority": team.waiver_priority or 1,
            "rank": rank,
            "team_count": len(league.teams),
            "invite_code": league.invite_code or "",
        })
    return result


# ── Team Roster ─────────────────────────────────────────────────────────────────

@router.get("/teams/{team_id}/roster")
def get_team_roster(
    team_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    entries = (
        db.query(FantasyRoster)
        .options(
            joinedload(FantasyRoster.player).joinedload(Player.stats),
            joinedload(FantasyRoster.player).joinedload(Player.pwhl_team),
        )
        .filter_by(fantasy_team_id=team_id, is_active=True)
        .all()
    )
    return [_roster_entry_dict(e) for e in entries]


# ── Lineup ───────────────────────────────────────────────────────────────────────

class SlotAssignment(BaseModel):
    """Maps slot label (e.g. "F_0", "D_1", "UTIL_0", "BN_0") to player_id or null."""
    slots: dict  # {slot_label: player_id | None}


@router.post("/teams/{team_id}/lineup")
def set_lineup(
    team_id: int,
    req: SlotAssignment,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """
    Set today's lineup. Rules:
    - Players only in eligible slots (D can't fill F slot unless UTIL)
    - Players with no game today score 0 regardless (enforced at scoring time)
    - Carries over automatically if not updated (last lineup persists)
    """
    from app.services.league_rules import validate_lineup, is_slot_eligible

    from app.services.daily_scoring import is_lineup_locked
    if is_lineup_locked(db):
        raise HTTPException(status_code=423, detail="Lineup is locked — games have already started today")

    team = db.query(FantasyTeam).filter_by(id=team_id, owner_id=current_user.id).first()
    if not team:
        raise HTTPException(status_code=403, detail="Not your team")

    entries = db.query(FantasyRoster).filter_by(fantasy_team_id=team_id, is_active=True).all()
    player_map = {e.player_id: e for e in entries}

    # Build position map for validation
    from app.models.pwhl import Player
    player_positions = {}
    for pid in player_map:
        p = db.query(Player).filter_by(id=pid).first()
        if p:
            player_positions[pid] = p.position or "F"

    # Validate slot eligibility
    errors = validate_lineup(req.slots, player_positions)
    if errors:
        raise HTTPException(status_code=400, detail="; ".join(errors))

    # Check no player assigned to multiple slots
    assigned_ids = [pid for pid in req.slots.values() if pid is not None]
    if len(assigned_ids) != len(set(assigned_ids)):
        raise HTTPException(status_code=400, detail="Player assigned to multiple slots")

    # Check all assigned players are on this roster
    for pid in assigned_ids:
        if pid not in player_map:
            raise HTTPException(status_code=400, detail=f"Player {pid} not on roster")

    # Apply slot assignments
    assigned_set = set(assigned_ids)
    for entry in entries:
        if entry.player_id in assigned_set:
            # Find which slot this player is in
            slot_label = next((k for k, v in req.slots.items() if v == entry.player_id), None)
            slot_type = slot_label.split("_")[0] if slot_label else "BN"
            entry.position_slot = slot_label
            entry.slot = "bench" if slot_type == "BN" else "active"
        else:
            # Not assigned — bench
            entry.slot = "bench"

    db.commit()
    return {"message": "Lineup updated", "active_count": len([p for p in assigned_ids if not next((k for k,v in req.slots.items() if v==p), "BN").startswith("BN")])}


@router.get("/teams/{team_id}/lineup/status")
def get_lineup_status(
    team_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Returns lock status and lock time for today's lineup."""
    import datetime, pytz
    from app.services.daily_scoring import get_lineup_lock_time, is_lineup_locked
    ET = pytz.timezone("America/New_York")
    date = datetime.datetime.now(ET).date()
    lock_time = get_lineup_lock_time(db, date)
    locked = is_lineup_locked(db, date)
    return {
        "locked": locked,
        "lock_time": lock_time.isoformat() if lock_time else None,
        "date": str(date),
    }


@router.get("/teams/{team_id}/lineup")
def get_lineup(
    team_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Get current lineup with slot assignments. Unassigned active slots are empty."""
    team = db.query(FantasyTeam).filter_by(id=team_id, owner_id=current_user.id).first()
    if not team:
        raise HTTPException(status_code=403, detail="Not your team")

    from app.services.league_rules import ACTIVE_SLOTS, BENCH_SLOTS, SLOT_ELIGIBILITY
    from app.models.pwhl import Player
    import datetime, pytz

    entries = db.query(FantasyRoster).filter_by(fantasy_team_id=team_id, is_active=True).all()

    # Check which players have games today (ET)
    today_et = datetime.datetime.now(pytz.timezone("America/New_York")).date()
    from app.models.pwhl import Game
    today_game_player_ids = set()
    today_games = db.query(Game).filter(
        Game.game_date == today_et,
        Game.status != "final"
    ).all()
    from app.models.pwhl import Player as P
    for game in today_games:
        # Get all players on home and away teams
        players = db.query(P).filter(P.team_id.in_([game.home_team_id, game.away_team_id])).all()
        for p in players:
            today_game_player_ids.add(p.id)

    # Build slot -> player mapping from current roster
    slot_map = {}
    for e in entries:
        if e.position_slot:
            slot_map[e.position_slot] = e

    # Build response
    result_slots = []
    slot_counters = {}
    for slot_type in ACTIVE_SLOTS + BENCH_SLOTS:
        idx = slot_counters.get(slot_type, 0)
        slot_counters[slot_type] = idx + 1
        label = f"{slot_type}_{idx}"
        entry = slot_map.get(label)
        player_data = None
        if entry:
            p = db.query(Player).filter_by(id=entry.player_id).first()
            if p:
                player_data = {
                    "id": p.id,
                    "full_name": p.full_name,
                    "position": p.position,
                    "has_game_today": p.id in today_game_player_ids,
                }
        result_slots.append({
            "slot_label": label,
            "slot_type": slot_type,
            "eligible_positions": list(SLOT_ELIGIBILITY.get(slot_type, set())),
            "is_active": slot_type != "BN",
            "player": player_data,
        })

    return {"slots": result_slots}


# ── League Standings ─────────────────────────────────────────────────────────────

@router.get("/leagues/{league_id}/standings")
def get_fantasy_standings(
    league_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    teams = (
        db.query(FantasyTeam)
        .options(joinedload(FantasyTeam.owner))
        .filter_by(league_id=league_id)
        .order_by(FantasyTeam.total_points.desc())
        .all()
    )
    return [
        {
            "team_id": t.id,
            "team_name": t.name,
            "owner_id": t.owner_id,
            "owner_username": t.owner.username if t.owner else "Unknown",
            "wins": t.wins or 0,
            "losses": t.losses or 0,
            "ties": t.ties or 0,
            "total_points": t.total_points or 0.0,
            "rank": i + 1,
        }
        for i, t in enumerate(teams)
    ]


# ── Waiver Wire ───────────────────────────────────────────────────────────────────

@router.get("/leagues/{league_id}/waivers")
def get_available_players(
    league_id: int,
    q: Optional[str] = None,
    position: Optional[str] = None,
    limit: int = 50,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    rostered_ids = (
        db.query(FantasyRoster.player_id)
        .join(FantasyTeam, FantasyTeam.id == FantasyRoster.fantasy_team_id)
        .filter(FantasyTeam.league_id == league_id, FantasyRoster.is_active == True)
        .subquery()
    )

    query = (
        db.query(Player)
        .options(joinedload(Player.stats), joinedload(Player.pwhl_team))
        .filter(Player.id.not_in(rostered_ids), Player.is_active == True)
    )

    if q:
        search = f"%{q}%"
        from sqlalchemy import func as sqlfunc
        query = query.filter(
            sqlfunc.concat(Player.first_name, ' ', Player.last_name).ilike(search)
        )
    if position:
        query = query.filter(Player.position == position)

    players = query.all()

    def fp(p):
        stat = _season_stat(p)
        return stat.fantasy_points if stat else 0.0

    players.sort(key=fp, reverse=True)
    players = players[:limit]

    result = []
    for p in players:
        stat = _season_stat(p)
        result.append({
            "id": p.id,
            "first_name": p.first_name,
            "last_name": p.last_name,
            "full_name": p.full_name,
            "position": p.position,
            "team_abbreviation": p.pwhl_team.abbreviation if p.pwhl_team else None,
            "headshot_url": p.headshot_url,
            "fantasy_points": stat.fantasy_points if stat else 0.0,
            "goals": stat.goals if stat else 0,
            "assists": stat.assists if stat else 0,
            "games_played": stat.games_played if stat else 0,
            "wins": stat.wins if stat else 0,
            "save_percentage": stat.save_percentage if stat else 0.0,
        })
    return result


# ── Waiver Claim ─────────────────────────────────────────────────────────────────

class WaiverClaimRequest(BaseModel):
    team_id: int
    add_player_id: int
    drop_player_id: Optional[int] = None


@router.post("/waivers/claim")
def claim_waiver(
    req: WaiverClaimRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    team = db.query(FantasyTeam).filter_by(id=req.team_id, owner_id=current_user.id).first()
    if not team:
        raise HTTPException(status_code=403, detail="Not your team")

    already_rostered = (
        db.query(FantasyRoster)
        .join(FantasyTeam, FantasyTeam.id == FantasyRoster.fantasy_team_id)
        .filter(
            FantasyTeam.league_id == team.league_id,
            FantasyRoster.player_id == req.add_player_id,
            FantasyRoster.is_active == True,
        )
        .first()
    )
    if already_rostered:
        raise HTTPException(status_code=400, detail="Player already rostered in this league")

    if req.drop_player_id:
        drop_entry = db.query(FantasyRoster).filter_by(
            fantasy_team_id=req.team_id, player_id=req.drop_player_id, is_active=True
        ).first()
        if drop_entry:
            drop_entry.is_active = False

    new_entry = FantasyRoster(
        fantasy_team_id=req.team_id,
        player_id=req.add_player_id,
        slot="bench",
        acquired_via="waiver",
        is_active=True,
    )
    db.add(new_entry)

    waiver = Waiver(
        league_id=team.league_id,
        fantasy_team_id=req.team_id,
        player_add_id=req.add_player_id,
        player_drop_id=req.drop_player_id,
        status="processed",
    )
    db.add(waiver)
    db.commit()
    return {"message": "Player added to roster"}


# ── Trades ───────────────────────────────────────────────────────────────────────

@router.get("/trades")
def get_my_trades(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    my_team_ids = [t.id for t in db.query(FantasyTeam).filter_by(owner_id=current_user.id).all()]
    if not my_team_ids:
        return []

    trades = (
        db.query(Trade)
        .options(
            joinedload(Trade.proposing_team),
            joinedload(Trade.receiving_team),
            joinedload(Trade.items).joinedload(TradeItem.player),
        )
        .filter(
            (Trade.proposing_team_id.in_(my_team_ids)) | (Trade.receiving_team_id.in_(my_team_ids))
        )
        .order_by(Trade.proposed_at.desc())
        .all()
    )

    result = []
    for trade in trades:
        league = db.query(League).filter_by(id=trade.league_id).first()
        offering = [
            {"player_id": item.player_id, "player_name": item.player.full_name, "position": item.player.position}
            for item in trade.items
            if item.from_team_id == trade.proposing_team_id
        ]
        requesting = [
            {"player_id": item.player_id, "player_name": item.player.full_name, "position": item.player.position}
            for item in trade.items
            if item.from_team_id == trade.receiving_team_id
        ]
        result.append({
            "id": trade.id,
            "league_id": trade.league_id,
            "league_name": league.name if league else "Unknown",
            "proposing_team_id": trade.proposing_team_id,
            "proposing_team_name": trade.proposing_team.name if trade.proposing_team else "Unknown",
            "receiving_team_id": trade.receiving_team_id,
            "receiving_team_name": trade.receiving_team.name if trade.receiving_team else "Unknown",
            "status": trade.status,
            "message": trade.message,
            "proposed_at": trade.proposed_at.isoformat() if trade.proposed_at else "",
            "offering_players": offering,
            "requesting_players": requesting,
        })
    return result


class ProposeTradeRequest(BaseModel):
    league_id: int
    proposing_team_id: int
    receiving_team_id: int
    offering_player_ids: List[int]
    requesting_player_ids: List[int]
    message: Optional[str] = None


@router.post("/trades")
def propose_trade(
    req: ProposeTradeRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    team = db.query(FantasyTeam).filter_by(id=req.proposing_team_id, owner_id=current_user.id).first()
    if not team:
        raise HTTPException(status_code=403, detail="Not your team")

    trade = Trade(
        league_id=req.league_id,
        proposing_team_id=req.proposing_team_id,
        receiving_team_id=req.receiving_team_id,
        status="pending",
        message=req.message,
    )
    db.add(trade)
    db.flush()

    for pid in req.offering_player_ids:
        db.add(TradeItem(trade_id=trade.id, player_id=pid,
                         from_team_id=req.proposing_team_id, to_team_id=req.receiving_team_id))
    for pid in req.requesting_player_ids:
        db.add(TradeItem(trade_id=trade.id, player_id=pid,
                         from_team_id=req.receiving_team_id, to_team_id=req.proposing_team_id))

    db.commit()
    return {"id": trade.id, "status": "pending"}


class TradeRespondRequest(BaseModel):
    accept: bool


@router.post("/trades/{trade_id}/respond")
def respond_trade(
    trade_id: int,
    req: TradeRespondRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    my_team_ids = [t.id for t in db.query(FantasyTeam).filter_by(owner_id=current_user.id).all()]
    trade = db.query(Trade).filter_by(id=trade_id).first()
    if not trade or trade.receiving_team_id not in my_team_ids:
        raise HTTPException(status_code=403, detail="Not authorized to respond to this trade")
    if trade.status != "pending":
        raise HTTPException(status_code=400, detail="Trade is not pending")

    if req.accept:
        trade.status = "accepted"
        items = db.query(TradeItem).filter_by(trade_id=trade_id).all()
        for item in items:
            entry = db.query(FantasyRoster).filter_by(
                fantasy_team_id=item.from_team_id, player_id=item.player_id, is_active=True
            ).first()
            if entry:
                entry.fantasy_team_id = item.to_team_id
                entry.acquired_via = "trade"
    else:
        trade.status = "rejected"

    db.commit()
    return {"status": trade.status}


# ── Invite Code ──────────────────────────────────────────────────────────────────

@router.get("/leagues/{league_id}/invite-code")
def get_invite_code(
    league_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    member = db.query(LeagueMember).filter_by(league_id=league_id, user_id=current_user.id).first()
    if not member:
        raise HTTPException(status_code=403, detail="Not a member of this league")
    league = db.query(League).filter_by(id=league_id).first()
    if not league:
        raise HTTPException(status_code=404, detail="League not found")
    return {"invite_code": league.invite_code}


# ── Draft passthrough endpoints (convenience aliases) ─────────────────────────
# The full logic lives in /leagues/{id}/draft; these are flat /fantasy/ aliases.

from app.models.fantasy import DraftPick, DraftSession
from app.models.player import PlayerStats

@router.post("/leagues/{league_id}/draft/start")
def fantasy_start_draft(
    league_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    import random
    from app.models.fantasy import DraftPick, DraftSession

    league = db.query(League).filter_by(id=league_id, commissioner_id=current_user.id).first()
    if not league:
        raise HTTPException(status_code=403, detail="Only commissioner can start the draft")
    if league.draft_status not in ("pending", None):
        raise HTTPException(status_code=400, detail="Draft already started or completed")

    teams = db.query(FantasyTeam).filter_by(league_id=league_id).all()
    if len(teams) < 2:
        raise HTTPException(status_code=400, detail="Need at least 2 teams to start draft")

    team_ids = [t.id for t in teams]
    random.shuffle(team_ids)
    league.draft_order = team_ids
    league.draft_status = "in_progress"

    rounds = league.roster_size or 20
    pick_num = 1
    picks = []
    for round_num in range(1, rounds + 1):
        order = team_ids if round_num % 2 == 1 else list(reversed(team_ids))
        for pick_in_round, team_id in enumerate(order, 1):
            picks.append(DraftPick(
                league_id=league_id,
                fantasy_team_id=team_id,
                pick_number=pick_num,
                round_number=round_num,
                pick_in_round=pick_in_round,
            ))
            pick_num += 1

    db.add_all(picks)

    existing_session = db.query(DraftSession).filter_by(league_id=league_id).first()
    if existing_session:
        existing_session.status = "in_progress"
        existing_session.total_picks = len(picks)
        existing_session.current_pick_number = 1
    else:
        db.add(DraftSession(
            league_id=league_id,
            status="in_progress",
            total_picks=len(picks),
            current_pick_number=1,
        ))
    db.commit()
    return {"message": "Draft started", "draft_order": team_ids, "total_picks": len(picks)}


@router.get("/leagues/{league_id}/draft")
def fantasy_get_draft(
    league_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    from app.models.fantasy import DraftPick, DraftSession

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

    # Enrich picks with player names
    picks_data = []
    for p in picks:
        player_name = None
        if p.player_id:
            player = db.query(Player).filter_by(id=p.player_id).first()
            if player:
                player_name = player.full_name
        picks_data.append({
            "id": p.id,
            "pick_number": p.pick_number,
            "round_number": p.round_number,
            "pick_in_round": p.pick_in_round,
            "fantasy_team_id": p.fantasy_team_id,
            "player_id": p.player_id,
            "player_name": player_name,
            "is_made": p.is_made,
        })

    return {
        "league_id": league_id,
        "status": league.draft_status,
        "current_pick_number": session.current_pick_number if session else 1,
        "total_picks": session.total_picks if session else len(picks),
        "draft_order": league.draft_order,
        "picks": picks_data,
        "current_team_id": current_team_id,
    }


@router.post("/leagues/{league_id}/draft/pick")
def fantasy_make_pick(
    league_id: int,
    player_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    from app.models.fantasy import DraftPick, DraftSession, FantasyRoster

    league = db.query(League).filter_by(id=league_id).first()
    if not league or league.draft_status != "in_progress":
        raise HTTPException(status_code=400, detail="Draft is not in progress")

    # Find current pick
    current_pick = (
        db.query(DraftPick)
        .filter_by(league_id=league_id, is_made=False)
        .order_by(DraftPick.pick_number)
        .first()
    )
    if not current_pick:
        raise HTTPException(status_code=400, detail="Draft is complete")

    # Verify it's this user's turn (unless commissioner / mock draft)
    my_team = db.query(FantasyTeam).filter_by(league_id=league_id, owner_id=current_user.id).first()
    if my_team and current_pick.fantasy_team_id != my_team.id:
        raise HTTPException(status_code=403, detail="Not your turn to pick")

    # Ensure player not already drafted
    already = db.query(DraftPick).filter_by(league_id=league_id, player_id=player_id, is_made=True).first()
    if already:
        raise HTTPException(status_code=400, detail="Player already drafted")

    current_pick.player_id = player_id
    current_pick.is_made = True

    # Add to roster
    db.add(FantasyRoster(
        fantasy_team_id=current_pick.fantasy_team_id,
        player_id=player_id,
        slot="bench",
        acquired_via="draft",
        is_active=True,
    ))

    # Advance session
    session = db.query(DraftSession).filter_by(league_id=league_id).first()
    if session:
        session.current_pick_number += 1

    # Check if draft complete
    remaining = db.query(DraftPick).filter_by(league_id=league_id, is_made=False).count()
    if remaining == 0:
        league.draft_status = "completed"
        if session:
            session.status = "completed"

    db.commit()
    return {"message": "Pick made", "player_id": player_id, "pick_number": current_pick.pick_number}


@router.get("/players/available/{league_id}")
def fantasy_available_players(
    league_id: int,
    q: Optional[str] = None,
    position: Optional[str] = None,
    db: Session = Depends(get_db),
    _: User = Depends(get_current_user),
):
    """Players not yet drafted in this league (for draft room)."""
    drafted_ids = (
        db.query(DraftPick.player_id)
        .filter_by(league_id=league_id, is_made=True)
        .subquery()
    )

    query = (
        db.query(Player)
        .options(joinedload(Player.stats), joinedload(Player.pwhl_team))
        .filter(Player.id.not_in(drafted_ids), Player.is_active == True)
    )
    if q:
        from sqlalchemy import func as sqlfunc
        query = query.filter(sqlfunc.concat(Player.first_name, ' ', Player.last_name).ilike(f"%{q}%"))
    if position:
        query = query.filter(Player.position == position)

    players = query.all()

    def fp(p):
        stat = _season_stat(p)
        return stat.fantasy_points if stat else 0.0

    players.sort(key=fp, reverse=True)

    result = []
    for p in players:
        stat = _season_stat(p)
        result.append({
            "id": p.id,
            "first_name": p.first_name,
            "last_name": p.last_name,
            "full_name": p.full_name,
            "position": p.position,
            "team_abbreviation": p.pwhl_team.abbreviation if p.pwhl_team else None,
            "headshot_url": p.headshot_url,
            "fantasy_points": stat.fantasy_points if stat else 0.0,
            "goals": stat.goals if stat else 0,
            "assists": stat.assists if stat else 0,
            "games_played": stat.games_played if stat else 0,
        })
    return result
