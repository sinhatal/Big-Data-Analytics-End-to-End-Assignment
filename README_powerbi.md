# Power BI Dashboard (Build Guide)

> Note: Power BI Desktop is required to create the `.pbix`. This repository includes:
> - Cleaned dataset (`data/processed/netflix_clean.csv`)
> - A recommended star-schema + DAX measures
> - A dashboard layout spec + screenshots you can reproduce
>
> Once you build it, save as: `powerbi/Netflix_Dashboard.pbix`

## 1) Data model (recommended)
Load **netflix_clean.csv** and create these dimension tables:
- `DimDateAdded` from `date_added`
- `DimType` (Movie / TV Show)
- `DimRating`
- `BridgeGenres` by splitting `genres_list`
- `BridgeCountries` by splitting `countries_list`

Fact table: `FactTitles` = netflix_clean

Relationships:
- FactTitles[date_added] → DimDateAdded[Date]
- FactTitles[rating] → DimRating[rating]
- FactTitles[type] → DimType[type]
- FactTitles[show_id] → BridgeGenres[show_id]
- FactTitles[show_id] → BridgeCountries[show_id]

## 2) Core measures (DAX)
See `powerbi/measures.dax`.

## 3) Suggested pages
1. **Executive Overview**
   - KPIs: Total Titles, % Movies, % TV Shows, Unique Countries, Unique Genres
   - Line chart: Titles added by Year
   - Bar: Top Countries (Titles)
   - Bar: Top Genres (Titles)

2. **Content Portfolio**
   - Rating distribution
   - Movie duration stats (avg/median minutes)
   - Seasons distribution for TV shows

3. **Localization**
   - Map by country
   - Drill-through page: Country → Titles list

## 4) Export checklist
- Export the main dashboard page to `powerbi/exports/` as PNG/PDF for easy review.

