#!/usr/bin/env python3
"""
seed_fantasy_sim.py — PWHL Fantasy multi-league simulation seed script

Creates simulated leagues for sizes 5–21, runs real snake drafts using 2025-2026
player FP rankings, simulates weekly matchups using real stats, and prints a
competitive-balance analysis table.

Also creates a special "Eric's Test League" (4 teams) with full W-L history.
"""

import sys
import os
import random
import math
import statistics
from datetime import datetime, timedelta
from collections import defaultdict

# ── Path setup ────────────────────────────────────────────────────────────────
sys.path.insert(0, os.path.dirname(__file__))
from app.database import SessionLocal
from app.models.user import User
from app.models.league import League, LeagueMember, ScoringSettings
from app.models.fantasy import FantasyTeam, FantasyRoster, DraftPick, DraftSession
from app.models.player import Player, PlayerStats
from app.models.game import Game  # games table

db = SessionLocal()

SEASON = "2025-2026"
SCORING = {
    "goal": 3.0,
    "assist": 2.0,
    "plus_minus": 1.0,
    "pim": -0.5,
    "shot": 0.3,
    "goalie_win": 5.0,
    "save": 0.2,
    "goal_against": -1.0,
    "shutout": 3.0,
}

# ── Helpers ───────────────────────────────────────────────────────────────────

def get_season_stat(player: Player) -> PlayerStats | None:
    return next(
        (s for s in player.stats if s.season == SEASON and s.is_season_total), None
    )

def calc_fp(player: Player, stat: PlayerStats | None = None) -> float:
    if stat is None:
        stat = get_season_stat(player)
    if stat is None:
        return 0.0
    if player.position == "G":
        return (
            (stat.wins or 0) * SCORING["goalie_win"] +
            (stat.saves or 0) * SCORING["save"] +
            (stat.goals_against or 0) * SCORING["goal_against"] +
            (stat.shutouts or 0) * SCORING["shutout"]
        )
    else:
        return (
            (stat.goals or 0) * SCORING["goal"] +
            (stat.assists or 0) * SCORING["assist"] +
            (stat.plus_minus or 0) * SCORING["plus_minus"] +
            (stat.penalty_minutes or 0) * SCORING["pim"] +
            (stat.shots or 0) * SCORING["shot"]
        )

def purge_league(db, league_id: int):
    """Delete all data for a given league (for re-runs)."""
    from sqlalchemy import text
    db.execute(text(f"DELETE FROM draft_picks WHERE league_id = {league_id}"))
    db.execute(text(f"DELETE FROM draft_sessions WHERE league_id = {league_id}"))
    db.execute(text("""
        DELETE FROM fantasy_rosters
        WHERE fantasy_team_id IN (SELECT id FROM fantasy_teams WHERE league_id = {lid})
    """.format(lid=league_id)))
    db.execute(text(f"DELETE FROM fantasy_teams WHERE league_id = {league_id}"))
    db.execute(text(f"DELETE FROM league_members WHERE league_id = {league_id}"))
    db.execute(text(f"DELETE FROM scoring_settings WHERE league_id = {league_id}"))
    db.execute(text(f"DELETE FROM leagues WHERE id = {league_id}"))
    db.commit()

# ── Load all players ranked by FP ─────────────────────────────────────────────

print("Loading players…")
all_players = (
    db.query(Player)
    .filter(Player.is_active == True, Player.first_name != None, Player.first_name != "")
    .all()
)

# Attach season stats (preload)
for p in all_players:
    _ = p.stats  # trigger lazy load

players_ranked = sorted(
    [p for p in all_players if get_season_stat(p) is not None],
    key=lambda p: calc_fp(p),
    reverse=True
)

print(f"  {len(players_ranked)} players with 2025-2026 stats (ranked by FP)")

skaters_ranked = [p for p in players_ranked if p.position in ("F", "D")]
goalies_ranked = [p for p in players_ranked if p.position == "G"]
print(f"  {len(skaters_ranked)} skaters, {len(goalies_ranked)} goalies")

# ── Load weekly game schedule ─────────────────────────────────────────────────

print("Loading weekly game schedule…")
games = db.query(Game).filter(
    Game.status == "final",
    Game.season == SEASON
).order_by(Game.game_date).all()

# Build week → {team_id: games_played} map
from collections import defaultdict
week_team_games: dict[datetime, dict[int, int]] = defaultdict(lambda: defaultdict(int))
for g in games:
    # Monday as start of week
    gd = g.game_date
    if hasattr(gd, 'date'):
        gd = gd.date() if hasattr(gd, 'date') else gd
    monday = gd - timedelta(days=gd.weekday())
    if g.home_team_id:
        week_team_games[monday][g.home_team_id] += 1
    if g.away_team_id:
        week_team_games[monday][g.away_team_id] += 1

weeks_sorted = sorted(week_team_games.keys())
print(f"  {len(weeks_sorted)} completed weeks in {SEASON}")

# ── Weekly FP calculation ─────────────────────────────────────────────────────

def weekly_fp_for_player(player: Player, week_monday) -> float:
    """Estimate FP for a player in a given week, based on season FP / GP * games_that_week."""
    stat = get_season_stat(player)
    if stat is None:
        return 0.0
    gp = stat.games_played or 1
    season_fp = calc_fp(player, stat)
    fp_per_game = season_fp / gp if gp > 0 else 0.0
    # Games their PWHL team played this week
    team_games_this_week = week_team_games[week_monday].get(player.pwhl_team_id or -1, 0)
    # Add ±15% noise for realism
    noise = random.uniform(0.85, 1.15)
    return fp_per_game * team_games_this_week * noise

def simulate_season_wl(team_players_map: dict[int, list[Player]]) -> tuple[dict, dict, dict]:
    """
    Simulate weekly head-to-head matchups for all teams.
    Returns wins, losses, weekly_fp_totals dicts keyed by fantasy_team_id.
    teams: list of fantasy_team_ids
    """
    team_ids = list(team_players_map.keys())
    n = len(team_ids)
    wins = defaultdict(int)
    losses = defaultdict(int)
    total_fp = defaultdict(float)

    for week in weeks_sorted:
        # Calculate each team's FP this week
        week_fp = {}
        for tid, players in team_players_map.items():
            wfp = sum(weekly_fp_for_player(p, week) for p in players)
            week_fp[tid] = wfp
            total_fp[tid] += wfp

        # Round-robin or random pairing for H2H
        if n == 2:
            pairs = [(team_ids[0], team_ids[1])]
        else:
            # Shuffle for semi-random scheduling each week
            shuffled = team_ids[:]
            random.shuffle(shuffled)
            if n % 2 == 1:
                shuffled.append(-1)  # bye
            pairs = [(shuffled[i], shuffled[i+1]) for i in range(0, len(shuffled)-1, 2)]

        for a, b in pairs:
            if a == -1 or b == -1:
                continue
            if week_fp[a] >= week_fp[b]:
                wins[a] += 1
                losses[b] += 1
            else:
                wins[b] += 1
                losses[a] += 1

    return wins, losses, total_fp

# ── Snake draft helper ─────────────────────────────────────────────────────────

def snake_draft(team_ids: list[int], skaters: list[Player], goalies: list[Player],
                skater_slots: int, goalie_slots: int) -> dict[int, list[Player]]:
    """
    Perform a snake draft.
    Returns {team_id: [players]}
    """
    n = len(team_ids)
    roster_map = {tid: [] for tid in team_ids}
    goalie_counts = {tid: 0 for tid in team_ids}
    skater_counts = {tid: 0 for tid in team_ids}

    total_rounds = skater_slots + goalie_slots
    skater_pool = list(skaters)
    goalie_pool = list(goalies)

    pick = 0
    for round_num in range(1, total_rounds + 1):
        order = team_ids if round_num % 2 == 1 else list(reversed(team_ids))
        for team_id in order:
            # Decide: goalie needed?
            need_goalie = goalie_counts[team_id] < goalie_slots
            # In last (goalie_slots) rounds, force goalie picks; otherwise pick skaters first
            remaining_rounds = total_rounds - round_num + 1
            force_goalie = goalie_counts[team_id] + remaining_rounds <= goalie_slots

            if force_goalie and goalie_pool:
                player = goalie_pool.pop(0)
                goalie_counts[team_id] += 1
            elif force_goalie and skater_pool:
                # No goalies left, fall back to skater
                player = skater_pool.pop(0)
                skater_counts[team_id] += 1
            elif need_goalie and not skater_pool and goalie_pool:
                player = goalie_pool.pop(0)
                goalie_counts[team_id] += 1
            elif skater_pool:
                player = skater_pool.pop(0)
                skater_counts[team_id] += 1
            elif goalie_pool:
                player = goalie_pool.pop(0)
                goalie_counts[team_id] += 1
            else:
                break  # ran out of players

            roster_map[team_id].append(player)
            pick += 1

    return roster_map

# ── Create a league ────────────────────────────────────────────────────────────

def get_or_create_user(db, user_id: int) -> User | None:
    return db.query(User).filter_by(id=user_id).first()

def create_sim_league(
    db,
    name: str,
    num_teams: int,
    team_names: list[str],
    owner_ids: list[int],
    skater_slots: int,
    goalie_slots: int,
) -> tuple[League, list[FantasyTeam], dict[int, list[Player]], dict, dict, dict]:
    """Create a full simulated league. Returns (league, teams, roster_map, wins, losses, total_fp)."""
    import secrets as sec

    # Create league
    league = League(
        name=name,
        commissioner_id=owner_ids[0],
        invite_code=sec.token_urlsafe(8),
        max_teams=num_teams,
        is_public=False,
        draft_type="snake",
        draft_status="completed",
        season=SEASON,
        roster_size=skater_slots + goalie_slots,
        active_roster_size=min(13, skater_slots + goalie_slots),
        ir_slots=2,
        is_active=True,
    )
    db.add(league)
    db.flush()

    # Scoring settings
    db.add(ScoringSettings(league_id=league.id))

    # League members + fantasy teams
    teams = []
    for i, (tname, uid) in enumerate(zip(team_names, owner_ids)):
        # Add member (ignore duplicates — use merge-style)
        existing_member = db.query(LeagueMember).filter_by(
            league_id=league.id, user_id=uid
        ).first()
        if not existing_member:
            db.add(LeagueMember(
                league_id=league.id,
                user_id=uid,
                role="commissioner" if i == 0 else "member",
            ))

        team = FantasyTeam(
            name=tname,
            owner_id=uid,
            league_id=league.id,
            total_points=0.0,
            wins=0,
            losses=0,
            ties=0,
            waiver_priority=i + 1,
        )
        db.add(team)
        db.flush()
        teams.append(team)

    db.flush()

    # Snake draft
    team_ids = [t.id for t in teams]
    roster_map = snake_draft(
        team_ids,
        list(skaters_ranked),   # copy so we don't deplete global pool
        list(goalies_ranked),
        skater_slots,
        goalie_slots,
    )

    # Persist rosters
    for tid, players in roster_map.items():
        for i, player in enumerate(players):
            db.add(FantasyRoster(
                fantasy_team_id=tid,
                player_id=player.id,
                slot="active" if i < (skater_slots + goalie_slots - 2) else "bench",
                acquired_via="draft",
                is_active=True,
            ))

    db.flush()

    # Simulate season W-L
    wins, losses, total_fp = simulate_season_wl(roster_map)

    # Update fantasy teams
    for team in teams:
        team.wins = wins[team.id]
        team.losses = losses[team.id]
        fp_val = total_fp[team.id]
        team.total_points = round(fp_val, 1)

    db.commit()

    return league, teams, roster_map, wins, losses, total_fp

# ── Roster rules per league size ──────────────────────────────────────────────

def roster_rules(n: int) -> tuple[int, int]:
    """Returns (skater_slots, goalie_slots) for a given league size."""
    total_skaters = len(skaters_ranked)
    total_goalies = len(goalies_ranked)

    raw_skater = total_skaters // n
    raw_goalie = max(1, total_goalies // n)

    # Cap: max 20 skaters + 3 goalies
    skater_slots = min(raw_skater, 20)
    goalie_slots = min(raw_goalie, 3)

    # Ensure at least a playable roster
    skater_slots = max(skater_slots, 8)
    goalie_slots = max(goalie_slots, 1)

    return skater_slots, goalie_slots

# ── Build team names pool ──────────────────────────────────────────────────────

TEAM_NAME_POOL = [
    "Arctic Aces", "Blizzard Queens", "Frozen Fire", "Ice Wolves",
    "Puck Legends", "Slapshot Six", "Snow Leopards", "Storm Chasers",
    "Frozen Fury", "Net Breakers", "Hat Trick Heroes", "Blue Line Babes",
    "Power Play Pros", "Penalty Box Rebels", "Crease Crushers", "Wrist Shot Wizards",
    "Dekes & Dangles", "Five Hole Legends", "Top Shelf Elite", "One-Timer Queens",
    "Glove Side Glory", "Butterfly Blockers",
]

def get_team_names(n: int, league_idx: int = 0) -> list[str]:
    pool = TEAM_NAME_POOL[:]
    random.shuffle(pool)
    return pool[:n]

# ── Get users for owners ──────────────────────────────────────────────────────

users = db.query(User).limit(3).all()
if not users:
    print("ERROR: No users in database. Create at least one user first.")
    sys.exit(1)

user_ids = [u.id for u in users]
eric_id = next((u.id for u in users if "eric" in u.username.lower()), user_ids[0])
print(f"Using users: {[u.username for u in users]} | Eric = user {eric_id}")

def owner_ids_for(n: int) -> list[int]:
    """Cycle through available user IDs to fill n teams."""
    return [user_ids[i % len(user_ids)] for i in range(n)]

# ═════════════════════════════════════════════════════════════════════════════
# PART 1: Eric's Test League (4 teams, detailed)
# ═════════════════════════════════════════════════════════════════════════════

print("\n" + "="*60)
print("PART 1: Creating Eric's Test League (4 teams)")
print("="*60)

# Remove existing test league if present
existing = db.query(League).filter(League.name == "Eric's Test League").first()
if existing:
    print(f"  Removing existing test league id={existing.id}")
    purge_league(db, existing.id)

sk, gl = roster_rules(4)
eric_team_names = ["Eric's Aces", "Frozen Pucks", "Ice Queens", "Slapshot Sisters"]
eric_owner_ids = [eric_id, user_ids[0 if len(user_ids) == 1 else 1 % len(user_ids)],
                  user_ids[0 if len(user_ids) <= 2 else 2 % len(user_ids)],
                  user_ids[0]]

league_eric, teams_eric, roster_eric, wins_eric, losses_eric, fp_eric = create_sim_league(
    db,
    name="Eric's Test League",
    num_teams=4,
    team_names=eric_team_names,
    owner_ids=eric_owner_ids,
    skater_slots=sk,
    goalie_slots=gl,
)

print(f"\n  League: {league_eric.name}  (id={league_eric.id})")
print(f"  Roster: {sk} skaters + {gl} goalies = {sk+gl} rounds")
print(f"\n  {'Team':<28} {'W-L':<8} {'Total FP':>10}")
print(f"  {'-'*50}")
for t in sorted(teams_eric, key=lambda x: x.total_points, reverse=True):
    print(f"  {t.name:<28} {t.wins}-{t.losses:<5} {t.total_points:>10.1f}")

    # Print roster
    players_on_team = roster_eric.get(t.id, [])
    for p in sorted(players_on_team, key=lambda x: calc_fp(x), reverse=True)[:5]:
        fp = calc_fp(p)
        print(f"    └ {p.full_name:<22} {p.position}  {fp:.1f} FP")

# ═════════════════════════════════════════════════════════════════════════════
# PART 2: Multi-size simulation (5–21 teams)
# ═════════════════════════════════════════════════════════════════════════════

print("\n" + "="*60)
print("PART 2: Multi-size league simulation (5–21 teams)")
print("="*60)

results = []
SIZES = list(range(5, 22))  # 5 through 21

for n in SIZES:
    sk, gl = roster_rules(n)
    league_name = f"Sim League ({n} teams)"

    # Remove existing
    existing = db.query(League).filter(League.name == league_name).first()
    if existing:
        purge_league(db, existing.id)

    tnames = get_team_names(n, n)
    oids = owner_ids_for(n)

    league_n, teams_n, roster_n, wins_n, losses_n, fp_n = create_sim_league(
        db,
        name=league_name,
        num_teams=n,
        team_names=tnames,
        owner_ids=oids,
        skater_slots=sk,
        goalie_slots=gl,
    )

    fps = [fp_n[t.id] for t in teams_n]
    std_dev = statistics.stdev(fps) if len(fps) > 1 else 0.0
    top_fp = max(fps)
    rounds = sk + gl

    # Available players (not drafted)
    total_players_used = n * rounds
    available_skaters = max(0, len(skaters_ranked) - n * sk)
    available_goalies = max(0, len(goalies_ranked) - n * gl)
    available_total = available_skaters + available_goalies

    results.append({
        "size": n,
        "skater_slots": sk,
        "goalie_slots": gl,
        "rounds": rounds,
        "top_fp": top_fp,
        "std_dev": std_dev,
        "available": available_total,
        "league_id": league_n.id,
    })

    print(f"  [{n:>2} teams] roster={sk}S+{gl}G rounds={rounds} "
          f"top_fp={top_fp:.0f} std={std_dev:.1f} avail={available_total}")

# ═════════════════════════════════════════════════════════════════════════════
# PART 3: Analysis table
# ═════════════════════════════════════════════════════════════════════════════

print("\n" + "="*80)
print("COMPETITIVE BALANCE ANALYSIS")
print("="*80)
print(f"\n{'Size':>5} {'S+G slots':>10} {'Rounds':>7} {'Top FP':>8} {'Std Dev':>8} {'Avail':>6}  Notes")
print("-"*80)

thin_wire_sizes = []
long_draft_sizes = []
sweet_spots = []

for r in results:
    notes = []
    if r["available"] < 10:
        notes.append("⚠ thin waiver wire")
        thin_wire_sizes.append(r["size"])
    if r["rounds"] > 15:
        notes.append("⚠ long draft")
        long_draft_sizes.append(r["size"])
    # Sweet spot: decent balance (std < median_std * 1.1) AND reasonable draft (<=15 rounds) AND waiver wire ok
    stds = [x["std_dev"] for x in results]
    median_std = sorted(stds)[len(stds)//2]
    if r["std_dev"] <= median_std * 1.15 and r["rounds"] <= 15 and r["available"] >= 10:
        notes.append("★ sweet spot")
        sweet_spots.append(r["size"])

    slots_str = f"{r['skater_slots']}S+{r['goalie_slots']}G"
    print(f"{r['size']:>5} {slots_str:>10} {r['rounds']:>7} {r['top_fp']:>8.0f} {r['std_dev']:>8.1f} {r['available']:>6}  {', '.join(notes)}")

print("\n" + "-"*80)
print(f"Thin waiver wire (<10 available): {thin_wire_sizes if thin_wire_sizes else 'none'}")
print(f"Long drafts (>15 rounds):         {long_draft_sizes if long_draft_sizes else 'none'}")
print(f"Recommended sweet spots:          {sweet_spots if sweet_spots else 'see table'}")

# Compute best sweet spot size
if sweet_spots:
    # Prefer the size closest to 10 teams (common standard)
    best = min(sweet_spots, key=lambda x: abs(x - 10))
    best_r = next(r for r in results if r["size"] == best)
    print(f"\n★ Top recommendation: {best} teams")
    print(f"  Roster: {best_r['skater_slots']} skaters + {best_r['goalie_slots']} goalies ({best_r['rounds']} rounds)")
    print(f"  Competitive balance std dev: {best_r['std_dev']:.1f} FP")
    print(f"  Waiver wire depth: {best_r['available']} available players")

print("\n" + "="*80)
print("SEED COMPLETE")
print(f"  Eric's Test League id: {league_eric.id}")
print(f"  Sim leagues created: {len(SIZES)} (sizes 5–21)")
print(f"  Total leagues in DB: {db.query(League).count()}")
print("="*80)

db.close()
