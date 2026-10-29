
PRAGMA foreign_keys = ON;

-- 1. Fund Dimension
CREATE TABLE IF NOT EXISTS dim_fund (
    fund_key INTEGER PRIMARY KEY,
    amfi_code INTEGER NOT NULL UNIQUE,
    fund_house TEXT,
    scheme_name TEXT NOT NULL,
    category TEXT,
    sub_category TEXT,
    plan TEXT,
    launch_date TEXT,
    benchmark TEXT,
    expense_ratio_pct REAL,
    exit_load_pct REAL,
    min_sip_amount REAL,
    min_lumpsum_amount REAL,
    fund_manager TEXT,
    risk_category TEXT,
    sebi_category_code TEXT
);

-- 2. Date Dimension
CREATE TABLE IF NOT EXISTS dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date TEXT NOT NULL UNIQUE,
    day INTEGER,
    month INTEGER,
    quarter INTEGER,
    year INTEGER
);

-- 3. NAV Fact
CREATE TABLE IF NOT EXISTS fact_nav (
    nav_key INTEGER PRIMARY KEY,
    fund_key INTEGER NOT NULL,
    date_key INTEGER NOT NULL,
    nav REAL NOT NULL CHECK (nav > 0),

    FOREIGN KEY (fund_key)
        REFERENCES dim_fund(fund_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    UNIQUE (fund_key, date_key)
);

-- 4. Transactions Fact
CREATE TABLE IF NOT EXISTS fact_transactions (
    transaction_key INTEGER PRIMARY KEY,
    investor_id INTEGER NOT NULL,
    fund_key INTEGER NOT NULL,
    date_key INTEGER NOT NULL,
    transaction_type TEXT NOT NULL,
    amount_inr REAL NOT NULL CHECK (amount_inr > 0),
    state TEXT,
    city TEXT,
    city_tier TEXT,
    age_group TEXT,
    gender TEXT,
    annual_income_lakh REAL,
    payment_mode TEXT,
    kyc_status TEXT,

    FOREIGN KEY (fund_key)
        REFERENCES dim_fund(fund_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);

-- 5. Performance Fact
CREATE TABLE IF NOT EXISTS fact_performance (
    performance_key INTEGER PRIMARY KEY,
    fund_key INTEGER NOT NULL UNIQUE,
    return_1yr_pct REAL,
    return_3yr_pct REAL,
    return_5yr_pct REAL,
    benchmark_3yr_pct REAL,
    alpha REAL,
    beta REAL,
    sharpe_ratio REAL,
    sortino_ratio REAL,
    std_dev_ann_pct REAL,
    max_drawdown_pct REAL,
    aum_crore REAL,
    expense_ratio_pct REAL,
    morningstar_rating INTEGER,
    risk_grade TEXT,

    FOREIGN KEY (fund_key)
        REFERENCES dim_fund(fund_key)
);

-- 6. AUM Fact
CREATE TABLE IF NOT EXISTS fact_aum (
    aum_key INTEGER PRIMARY KEY,
    fund_key INTEGER NOT NULL,
    date_key INTEGER NOT NULL,
    aum_crore REAL NOT NULL CHECK (aum_crore >= 0),

    FOREIGN KEY (fund_key)
        REFERENCES dim_fund(fund_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    UNIQUE (fund_key, date_key)
);

SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;