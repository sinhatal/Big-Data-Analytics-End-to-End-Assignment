# Netflix Movies & TV Shows — End-to-End Analytics (Python + SQL + Power BI)

This repository implements an end-to-end analytics workflow on the Kaggle Netflix titles dataset:
- **Python**: data cleaning + feature engineering + EDA
- **SQL**: structured analysis queries (KPIs, trends, portfolio cuts)
- **Power BI**: dashboard specification + DAX measures (build guide included)
- **Report & Slides**: business insights summary

## Repo structure
```
.
├── data/
│   ├── raw/               # original dataset
│   └── processed/         # cleaned dataset for SQL/BI
├── notebooks/             # analysis notebook
├── src/                   # reusable python scripts
├── sql/                   # SQL queries
├── powerbi/               # Power BI build guide + DAX measures + theme
├── report/                # brief report
├── slides/                # presentation deck
└── assets/                # charts exported from Python
```

## How to run (Python)
1) Create env (optional)
```bash
python -m venv .venv
source .venv/bin/activate  # (Windows: .venv\Scripts\activate)
pip install -r requirements.txt
```

2) Clean & export processed dataset
```bash
python -m src.clean_transform --input data/raw/netflix_titles.csv --output data/processed/netflix_clean.csv
```

3) Open notebook
```bash
jupyter notebook notebooks/netflix_end_to_end.ipynb
```

## SQL
- See `sql/queries.sql`
- Load `data/processed/netflix_clean.csv` into a table called `netflix_titles` and run the queries.

## Power BI
- See `powerbi/README_powerbi.md` for the data model + dashboard pages.
- Measures: `powerbi/measures.dax`
- Theme: `powerbi/theme.json`

> After building in Power BI Desktop, save as `powerbi/Netflix_Dashboard.pbix`

## Outputs
- Clean dataset: `data/processed/netflix_clean.csv`
- Charts: `assets/`
- Report: `report/project_report.md`
- Slides: `slides/Netflix_Analytics_Presentation.pptx`

