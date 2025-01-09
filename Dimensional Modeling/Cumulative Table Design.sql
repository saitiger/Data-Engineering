-- SELECT * FROM player_seasons

-- DROP TYPE IF EXISTS season_stats;

CREATE TYPE season_stats AS (
                         season Integer,
                         pts REAL,
                         ast REAL,
                         reb REAL,
                         weight INTEGER
                       );
CREATE TYPE scoring_class AS
     ENUM ('bad', 'average', 'good', 'star');


 CREATE TABLE players (
     player_name TEXT,
     height TEXT,
     college TEXT,
     country TEXT,
     draft_year TEXT,
     draft_round TEXT,
     draft_number TEXT,
     seasons season_stats[],
     scoring_class scoring_class,
     years_since_last_active INTEGER,
     is_active BOOLEAN,
     current_season INTEGER,
     PRIMARY KEY (player_name, current_season)
 );

 -- SELECT * FROM player_seasons LIMIT 1

-- SELECT min(season) FROM player_seasons # 1996

WITH last_season AS (
    SELECT * FROM players
    WHERE current_season = 1999

), this_season AS (
     SELECT * FROM player_seasons
    WHERE season = 2000
)
INSERT INTO players
SELECT
        COALESCE(ls.player_name, ts.player_name) as player_name,
        COALESCE(ls.height, ts.height) as height,
        COALESCE(ls.college, ts.college) as college,
        COALESCE(ls.country, ts.country) as country,
        COALESCE(ls.draft_year, ts.draft_year) as draft_year,
        COALESCE(ls.draft_round, ts.draft_round) as draft_round,
        COALESCE(ls.draft_number, ts.draft_number)
            as draft_number,
        COALESCE(ls.season,
            ARRAY[]::season_stats[]
            ) || CASE WHEN ts.season IS NOT NULL THEN
                ARRAY[ROW(
                ts.season,
                ts.pts,
                ts.ast,
                ts.reb, ts.weight)::season_stats]
                ELSE ARRAY[]::season_stats[] END
            as season_stats,
         CASE
             WHEN ts.season IS NOT NULL THEN
                 (CASE WHEN ts.pts > 20 THEN 'star'
                    WHEN ts.pts > 15 THEN 'good'
                    WHEN ts.pts > 10 THEN 'average'
                    ELSE 'bad' END)::scoring_class
             ELSE ls.scoring_class
         END as scoring_class,
		 CASE WHEN 
		 		  ts.season is NOT NULL THEN 0 
				  ELSE ls.years_since_last_active + 1 
				  END years_since_last_active,
         ts.season IS NOT NULL as is_active,
         2000 AS current_season
    FROM last_season ls
    FULL OUTER JOIN this_season ts
    ON ls.player_name = ts.player_name

 -- SELECT * FROM players LIMIT 10

-- SELECT player_name,
--         (seasons[cardinality(seasons)]::season_stats).pts/
--          CASE WHEN (seasons[1]::season_stats).pts = 0 THEN 1
--              ELSE  (seasons[1]::season_stats).pts END
--             AS ratio_most_recent_to_first
--  FROM players
--  WHERE current_season = 1998;

-- SELECT player_name,
--        ROUND(
--            ((seasons[cardinality(seasons)]::season_stats).pts / 
--            NULLIF((seasons[1]::season_stats).pts, 0))::NUMERIC, 
--            2
--        ) AS ratio_most_recent_to_first
-- FROM players
-- WHERE ROUND(
--            ((seasons[cardinality(seasons)]::season_stats).pts / 
--            NULLIF((seasons[1]::season_stats).pts, 0))::NUMERIC, 
--            2
--        ) IS NOT NULL
-- ORDER BY 2 DESC 
-- LIMIT 10

