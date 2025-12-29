# Netflix Dataset — Business Insights Report

## Dataset & Objective
We analyze the **Netflix Movies & TV Shows** dataset (Kaggle) to build an end-to-end analytics workflow: Python cleaning → SQL analysis → Power BI dashboard → insights & storytelling.  
(Assignment requirements summarized from the provided brief.)

## Data cleaning (Python)
Key transformations implemented in `src/clean_transform.py` and `notebooks/netflix_end_to_end.ipynb`:
- Standardized missing values (director/cast/country/rating → `Unknown`)
- Parsed `date_added` into a real date, plus `added_year` and `added_month`
- Parsed `duration` into:
  - `duration_minutes` for Movies
  - `duration_seasons` for TV Shows
- Normalized multi-valued columns for BI use:
  - `countries_list` (comma-separated, trimmed)
  - `genres_list` (comma-separated, trimmed)
- Added `primary_genre` and `is_movie`

**Output:** `data/processed/netflix_clean.csv`

## What the catalog looks like (high-level)
### 1) Content mix
- Movies dominate the catalog; TV Shows are a sizeable minority.
- Implication: **Movies drive breadth**, TV series help **retention** and **binge behavior**.

### 2) Localization footprint
Top countries by titles include **United States** and **India**, followed by **UK/Canada/France/Japan**.
- Implication: Netflix’s library is strong in a few supply hubs; growth can come from **new language markets** and **regional originals**.

### 3) Genre concentration
A handful of genres (e.g., Dramas / International TV / Comedies / Documentaries) contribute a large share of titles.
- Implication: Portfolio concentration can be a strength (clear brand identity) but also a risk (limited novelty).

### 4) Catalog expansion trend
Titles added per year show a strong ramp around **2018–2020**, followed by a dip.
- Implication: could reflect content strategy shifts, production constraints, or catalog optimization.

## Recommended business actions (based on this dataset)
1. **Double down on localized originals** in high-growth countries (beyond US/India/UK) and measure lift in retention.
2. **Balance the portfolio** by investing in under-represented but high-demand genres (use watch-time data if available).
3. **Optimize series strategy**: more multi-season hits in targeted genres to improve subscriber lifetime value.
4. **Track freshness lag** (release year vs added year) to ensure a mix of new + evergreen content.

## Visuals
See `assets/`:
- `content_type_mix.png`
- `top_countries.png`
- `top_genres.png`
- `titles_added_by_year.png`

## Limitations
- This dataset is catalog metadata only (no watch-time, completion rate, or churn), so insights focus on **content supply** rather than **consumer demand**.

