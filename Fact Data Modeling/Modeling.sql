SELECT * FROM actor_films;

CREATE TYPE film_metadata AS (
film_name TEXT,
votes TEXT,
rating REAL,
filmid TEXT
);

WITH most_recent_year AS (
SELECT actorid,max(year) year_of_interest 
FROM 
actor_films 
GROUP BY actorid
)
SELECT 
a.actorid,AVG(a.rating) avg_votes
FROM 
most_recent_year m
JOIN 
actor_films a
ON a.actorid = m.actorid AND a.year = m.year_of_interest
GROUP BY 1;

CREATE TYPE quality_class AS 
ENUM('Star','Good','Average','Bad');

SELECT 
    actorid,
    CASE 
        WHEN AVG(rating) > 8 THEN 'Star'
        WHEN AVG(rating) > 7 AND AVG(rating) <= 8 THEN 'Good'
        WHEN AVG(rating) > 6 AND AVG(rating) <= 7 THEN 'Average'
        ELSE 'Bad'
    END AS rating_category
FROM
    actor_films
WHERE (actorid, year) IN (
    SELECT actorid, MAX(year)
    FROM actor_films
    GROUP BY actorid
)
GROUP BY actorid;

CREATE TABLE actors 
(actorid TEXT,
films film_metadata[],
quality_class quality_class,
is_active boolean,
current_year INTEGER
PRIMARY KEY(actorid)
);

-- SELECT * FROM actors;

-- SELECT min(year) FROM actor_films; #1970 (First year for pipeline generation);

-- Backfilling Pipeline 

WITH last_year AS (
    SELECT * FROM actor_films
    WHERE year = 1979
), this_year AS (
    SELECT * FROM actor_films
    WHERE year = 1980
), actor_ratings AS (
    SELECT 
        actorid,
        CASE 
            WHEN AVG(rating) > 8 THEN 'Star'
            WHEN AVG(rating) > 7 AND AVG(rating) <= 8 THEN 'Good'
            WHEN AVG(rating) > 6 AND AVG(rating) <= 7 THEN 'Average'
            ELSE 'Bad'
        END::quality_class AS quality_class
    FROM this_year
    GROUP BY actorid
)
INSERT INTO actors (actorid, films, quality_class, is_active)
SELECT
    COALESCE(ly.actorid, ty.actorid) AS actorid,
    COALESCE(
        ARRAY[ROW(
            ty.film,
            ty.votes,
            ty.rating,
            ty.filmid
        )::film_metadata],
        ARRAY[]::film_metadata[]
    ) AS films,
    ar.quality_class,
    CASE 
        WHEN ty.actorid IS NOT NULL THEN True 
        ELSE False 
    END AS is_active,
	1980 AS current_year 
FROM last_year ly
FULL OUTER JOIN this_year ty
    ON ly.actorid = ty.actorid
LEFT JOIN actor_ratings ar
    ON COALESCE(ly.actorid, ty.actorid) = ar.actorid
ON CONFLICT (actorid)
DO NOTHING; -- Skip if conflict occurs

SELECT * FROM actors LIMIT 10;

-- SELECT * FROM actors WHERE quality_class IS NULL;
-- SELECT COUNT(*) FROM actors WHERE is_active='False';
-- SELECT COUNT(*) FROM actors WHERE quality_class IS NULL;
-- # The counts are equal for the two queries above which aligns with the logic that 
-- if the actor did not have a movie released that year 

-- TRUNCATE actors;

WITH last_year AS (
    SELECT 
        actorid,
        ARRAY_AGG(film) AS films, 
        AVG(rating) AS avg_rating,
        ARRAY_AGG(votes) AS votes,
        ARRAY_AGG(filmid) AS filmids
    FROM actor_films
    WHERE year = 1979
    GROUP BY actorid
), this_year AS (
    SELECT 
        actorid,
        ARRAY_AGG(film) AS films, 
        AVG(rating) AS avg_rating,
        ARRAY_AGG(votes) AS votes,
        ARRAY_AGG(filmid) AS filmids
    FROM actor_films
    WHERE year = 1980
    GROUP BY actorid
), merged_ratings AS (
    SELECT 
        COALESCE(ty.actorid, ly.actorid) AS actorid,
        COALESCE(ty.avg_rating, ly.avg_rating) AS avg_rating,
        CASE 
            WHEN ty.avg_rating IS NOT NULL THEN 'this_year'
            ELSE 'last_year'
        END AS source_year,
        COALESCE(ty.films, ly.films) AS films,
        COALESCE(ty.votes, ly.votes) AS votes,
        COALESCE(ty.filmids, ly.filmids) AS filmids
    FROM last_year ly
    FULL OUTER JOIN this_year ty
        ON ly.actorid = ty.actorid
), actor_quality AS (
    SELECT 
        actorid,
        CASE 
            WHEN avg_rating > 8 THEN 'Star'
            WHEN avg_rating > 7 AND avg_rating <= 8 THEN 'Good'
            WHEN avg_rating > 6 AND avg_rating <= 7 THEN 'Average'
            ELSE 'Bad'
        END::quality_class AS quality_class
    FROM merged_ratings
)
INSERT INTO actors (actorid, films, quality_class, is_active)
SELECT
    merged.actorid,
    ARRAY(
        SELECT ROW(film, vote, NULL, filmid)::film_metadata
        FROM UNNEST(merged.films, merged.votes, merged.filmids) 
             AS t(film, vote, filmid)
    ) AS films,
    aq.quality_class,
    CASE 
        WHEN merged.source_year = 'this_year' THEN True 
        ELSE False 
    END AS is_active,
	1980 AS current_year
FROM merged_ratings merged
LEFT JOIN actor_quality aq
    ON merged.actorid = aq.actorid
ON CONFLICT (actorid) DO UPDATE
SET 
    films = EXCLUDED.films,
    quality_class = EXCLUDED.quality_class,
    is_active = EXCLUDED.is_active;

SELECT * FROM actors;

SELECT * FROM actor_films WHERE film = 'The Formula' AND YEAR = '1980';

-- Rating = 5.6 Votes = 2381 actorid = "nm0000008" filmid = "tt0080754"

-- SELECT unnest(films)::film_metadata FROM actors;

SELECT (film_data).rating FROM actors, unnest(films) AS film_data WHERE (film_data).rating IS NOT NULL;
