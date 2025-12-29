"""Netflix dataset cleaning & feature engineering.

Run:
    python -m src.clean_transform --input data/raw/netflix_titles.csv --output data/processed/netflix_clean.csv
"""

from __future__ import annotations
import argparse
import re
import numpy as np
import pandas as pd

def parse_duration(duration: str):
    """Return (minutes, seasons) as ints or (nan, nan)."""
    if pd.isna(duration):
        return (np.nan, np.nan)
    m = re.match(r"(\d+)\s*(min|Season|Seasons)", str(duration))
    if not m:
        return (np.nan, np.nan)
    val = int(m.group(1))
    unit = m.group(2)
    if unit == "min":
        return (val, np.nan)
    return (np.nan, val)

def transform(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    # standardize missing values
    for col in ["director", "cast", "country", "rating"]:
        df[col] = df[col].fillna("Unknown")

    # parse date_added
    df["date_added"] = pd.to_datetime(df["date_added"], errors="coerce")
    df["added_year"] = df["date_added"].dt.year
    df["added_month"] = df["date_added"].dt.month

    # duration features
    minutes, seasons = [], []
    for d in df["duration"]:
        mi, se = parse_duration(d)
        minutes.append(mi)
        seasons.append(se)
    df["duration_minutes"] = minutes
    df["duration_seasons"] = seasons

    # genre + country lists (kept as text for easy BI usage; explode in analysis as needed)
    df["genres"] = df["listed_in"].fillna("Unknown")
    df["primary_genre"] = df["genres"].str.split(",").str[0].str.strip()
    df["countries_list"] = df["country"].fillna("Unknown").str.split(",").apply(lambda xs: ",".join([x.strip() for x in xs]) if isinstance(xs, list) else "Unknown")
    df["genres_list"] = df["genres"].str.split(",").apply(lambda xs: ",".join([x.strip() for x in xs]) if isinstance(xs, list) else "Unknown")

    # convenience flags
    df["is_movie"] = (df["type"] == "Movie").astype(int)

    return df

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input", required=True)
    ap.add_argument("--output", required=True)
    args = ap.parse_args()

    df = pd.read_csv(args.input)
    out = transform(df)
    out.to_csv(args.output, index=False)
    print(f"Saved cleaned dataset -> {args.output} (rows={len(out):,}, cols={out.shape[1]})")

if __name__ == "__main__":
    main()
