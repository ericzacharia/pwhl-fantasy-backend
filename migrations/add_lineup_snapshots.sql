-- Daily lineup snapshots table
CREATE TABLE IF NOT EXISTS lineup_snapshots (
    id SERIAL PRIMARY KEY,
    fantasy_team_id INTEGER NOT NULL REFERENCES fantasy_teams(id),
    snapshot_date DATE NOT NULL,
    slot_label VARCHAR(10) NOT NULL,
    slot_type VARCHAR(6) NOT NULL,
    player_id INTEGER REFERENCES players(id),
    fantasy_points_earned FLOAT DEFAULT 0.0,
    locked_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT uq_lineup_snapshot_team_date_slot
        UNIQUE (fantasy_team_id, snapshot_date, slot_label)
);

CREATE INDEX IF NOT EXISTS idx_lineup_snapshots_team_date
    ON lineup_snapshots(fantasy_team_id, snapshot_date);
