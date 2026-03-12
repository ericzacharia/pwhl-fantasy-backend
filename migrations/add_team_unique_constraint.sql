-- Prevent duplicate team names
ALTER TABLE teams ADD CONSTRAINT teams_name_unique UNIQUE (name);
ALTER TABLE teams ADD CONSTRAINT teams_abbreviation_unique UNIQUE (abbreviation);
