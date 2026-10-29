from pathlib import Path
import pandas as pd
from sqlalchemy import create_engine, text

# Project paths
project_dir = Path(__file__).parent.parent
processed_dir = project_dir / "data" / "processed"
db_path = project_dir / "mutual_fund.db"

# Create SQLite engine
engine = create_engine(f"sqlite:///{db_path}")

# Get all cleaned CSV files
csv_files = sorted(processed_dir.glob("*.csv"))

if not csv_files:
    print("No CSV files found in data/processed/")
else:
    print("Loading datasets into SQLite...\n")

    with engine.connect() as conn:
        for file in csv_files:
            # Read CSV
            df = pd.read_csv(file)

            # Table name = filename without .csv
            table_name = file.stem

            # Load into SQLite
            df.to_sql(table_name, con=engine, if_exists="replace", index=False)

            # Verify row count
            sqlite_rows = conn.execute(
                text(f'SELECT COUNT(*) FROM "{table_name}"')
            ).scalar()

            csv_rows = len(df)

            status = "PASS" if csv_rows == sqlite_rows else "FAIL"

            print(f"{table_name}")
            print(f"CSV Rows    : {csv_rows}")
            print(f"SQLite Rows : {sqlite_rows}")
            print(f"Status      : {status}")
            print("-" * 40)

print("All datasets processed.")