-- Re-seed roster slots for all existing teams to new F/D/G/UTIL/BN structure
-- Assigns position_slot labels based on position, ordered by fantasy_points desc

DO $$
DECLARE
    team RECORD;
    entry RECORD;
    f_count INT;
    d_count INT;
    g_count INT;
    util_count INT;
    bn_count INT;
    slot_label TEXT;
BEGIN
    FOR team IN SELECT DISTINCT fantasy_team_id FROM fantasy_rosters WHERE is_active = TRUE LOOP
        f_count := 0; d_count := 0; g_count := 0; util_count := 0; bn_count := 0;

        FOR entry IN
            SELECT fr.id, p.position, COALESCE(ps.fantasy_points, 0) as fp
            FROM fantasy_rosters fr
            JOIN players p ON p.id = fr.player_id
            LEFT JOIN player_stats ps ON ps.player_id = fr.player_id
                AND ps.season = '2025-2026' AND ps.is_season_total = TRUE
            WHERE fr.fantasy_team_id = team.fantasy_team_id AND fr.is_active = TRUE
            ORDER BY p.position, COALESCE(ps.fantasy_points, 0) DESC
        LOOP
            -- Assign slot based on position and remaining open slots
            IF entry.position = 'G' AND g_count < 1 THEN
                slot_label := 'G_0'; g_count := g_count + 1;
            ELSIF entry.position = 'D' AND d_count < 2 THEN
                slot_label := 'D_' || d_count; d_count := d_count + 1;
            ELSIF entry.position = 'F' AND f_count < 3 THEN
                slot_label := 'F_' || f_count; f_count := f_count + 1;
            ELSIF entry.position IN ('F','D') AND util_count < 1 THEN
                slot_label := 'UTIL_0'; util_count := util_count + 1;
            ELSE
                slot_label := 'BN_' || bn_count; bn_count := bn_count + 1;
            END IF;

            UPDATE fantasy_rosters
            SET position_slot = slot_label,
                slot = CASE WHEN slot_label LIKE 'BN%' THEN 'bench' ELSE 'active' END
            WHERE id = entry.id;
        END LOOP;
    END LOOP;
END $$;

SELECT fantasy_team_id, slot, position_slot, player_id
FROM fantasy_rosters WHERE is_active = TRUE
ORDER BY fantasy_team_id, slot DESC, position_slot;
