-- Netflix Movies & TV Shows: SQL analysis
-- Assumes you loaded the cleaned CSV into a table named netflix_titles (or stage table).
-- Example load flow:
--   1) Create table (below)
--   2) Import CSV via your DB tool (Postgres COPY, SQL Server BULK INSERT, etc.)

-- 1) TABLE (generic)
CREATE TABLE IF NOT EXISTS netflix_titles (
  show_id TEXT PRIMARY KEY,
  type TEXT,
  title TEXT,
  director TEXT,
  cast TEXT,
  country TEXT,
  date_added DATE,
  release_year INT,
  rating TEXT,
  duration TEXT,
  listed_in TEXT,
  description TEXT,
  added_year INT,
  added_month INT,
  duration_minutes FLOAT,
  duration_seasons FLOAT,
  genres TEXT,
  primary_genre TEXT,
  countries_list TEXT,
  genres_list TEXT,
  is_movie INT
);

-- 2) KPI: content mix
SELECT type, COUNT(*) AS titles
FROM netflix_titles
GROUP BY type
ORDER BY titles DESC;

-- 3) Titles added over time (catalog expansion signal)
SELECT added_year, COUNT(*) AS titles_added
FROM netflix_titles
WHERE added_year IS NOT NULL
GROUP BY added_year
ORDER BY added_year;

-- 4) Top countries by titles (split countries_list in BI or using DB-specific string split)
-- Postgres example:
-- SELECT TRIM(country) AS country, COUNT(*) AS titles
-- FROM netflix_titles, LATERAL unnest(string_to_array(countries_list, ',')) AS country
-- GROUP BY 1 ORDER BY titles DESC LIMIT 10;

-- 5) Top genres by titles (split genres_list)
-- Postgres example:
-- SELECT TRIM(genre) AS genre, COUNT(*) AS titles
-- FROM netflix_titles, LATERAL unnest(string_to_array(genres_list, ',')) AS genre
-- GROUP BY 1 ORDER BY titles DESC LIMIT 10;

-- 6) Ratings distribution (content positioning & family-safe mix)
SELECT rating, COUNT(*) AS titles
FROM netflix_titles
GROUP BY rating
ORDER BY titles DESC;

-- 7) Movie duration stats (content quality/format consistency)
SELECT
  ROUND(AVG(duration_minutes), 1) AS avg_minutes,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY duration_minutes) AS median_minutes,
  MIN(duration_minutes) AS min_minutes,
  MAX(duration_minutes) AS max_minutes
FROM netflix_titles
WHERE type = 'Movie' AND duration_minutes IS NOT NULL;

-- 8) TV seasons distribution (bingeability proxy)
SELECT
  duration_seasons AS seasons,
  COUNT(*) AS titles
FROM netflix_titles
WHERE type = 'TV Show' AND duration_seasons IS NOT NULL
GROUP BY duration_seasons
ORDER BY seasons;

-- 9) Freshness lag: years between release and Netflix add date
SELECT
  CASE
    WHEN added_year IS NULL THEN 'Unknown'
    WHEN (added_year - release_year) < 1 THEN '0 years'
    WHEN (added_year - release_year) BETWEEN 1 AND 2 THEN '1-2 years'
    WHEN (added_year - release_year) BETWEEN 3 AND 5 THEN '3-5 years'
    WHEN (added_year - release_year) BETWEEN 6 AND 10 THEN '6-10 years'
    ELSE '10+ years'
  END AS release_to_added_bucket,
  COUNT(*) AS titles
FROM netflix_titles
GROUP BY 1
ORDER BY titles DESC;

-- 10) Directors with most titles (supply concentration / partnerships)
SELECT director, COUNT(*) AS titles
FROM netflix_titles
WHERE director <> 'Unknown'
GROUP BY director
HAVING COUNT(*) >= 10
ORDER BY titles DESC;

