
-- 1. Top 5 funds by AUM
SELECT
    fm.scheme_name,
    fm.fund_house,
    sp.aum_crore
FROM scheme_performance AS sp
JOIN fund_master AS fm
    ON sp.amfi_code = fm.amfi_code
ORDER BY sp.aum_crore DESC
LIMIT 5;


-- 2. Average NAV per month
SELECT
    strftime('%Y-%m', date) AS year_month,
    ROUND(AVG(nav), 4) AS average_nav
FROM nav_history
GROUP BY strftime('%Y-%m', date)
ORDER BY year_month;


-- 3. SIP year-over-year (YoY) growth by amount
WITH yearly_sip AS (
    SELECT
        strftime('%Y', transaction_date) AS year,
        SUM(amount_inr) AS sip_amount
    FROM investor_transactions
    WHERE UPPER(transaction_type) = 'SIP'
    GROUP BY strftime('%Y', transaction_date)
),
sip_growth AS (
    SELECT
        year,
        sip_amount,
        LAG(sip_amount) OVER (ORDER BY year) AS previous_year_amount
    FROM yearly_sip
)
SELECT
    year,
    ROUND(sip_amount, 2) AS sip_amount,
    ROUND(previous_year_amount, 2) AS previous_year_amount,
    ROUND(
        (sip_amount - previous_year_amount)
        * 100.0 / NULLIF(previous_year_amount, 0),
        2
    ) AS yoy_growth_pct
FROM sip_growth
ORDER BY year;


-- 4. Number of transactions and transaction amount by state
SELECT
    state,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount_inr), 2) AS total_amount_inr
FROM investor_transactions
GROUP BY state
ORDER BY total_amount_inr DESC;


-- 5. Funds with expense ratio below 1%
SELECT
    scheme_name,
    fund_house,
    category,
    expense_ratio_pct
FROM fund_master
WHERE expense_ratio_pct < 1
ORDER BY expense_ratio_pct ASC;


-- 6. Total amount and count by transaction type
SELECT
    transaction_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount_inr), 2) AS total_amount_inr,
    ROUND(AVG(amount_inr), 2) AS average_amount_inr
FROM investor_transactions
GROUP BY transaction_type
ORDER BY total_amount_inr DESC;


-- 7. Top 10 funds by 3-year return
SELECT
    fm.scheme_name,
    fm.category,
    sp.return_3yr_pct
FROM scheme_performance AS sp
JOIN fund_master AS fm
    ON sp.amfi_code = fm.amfi_code
WHERE sp.return_3yr_pct IS NOT NULL
ORDER BY sp.return_3yr_pct DESC
LIMIT 10;


-- 8. Number of funds in each category
SELECT
    category,
    COUNT(*) AS fund_count
FROM fund_master
GROUP BY category
ORDER BY fund_count DESC;


-- 9. Average expense ratio by fund house
SELECT
    fund_house,
    COUNT(*) AS fund_count,
    ROUND(AVG(expense_ratio_pct), 2) AS average_expense_ratio_pct
FROM fund_master
GROUP BY fund_house
ORDER BY average_expense_ratio_pct ASC;


-- 10. Latest available NAV for each fund
WITH ranked_nav AS (
    SELECT
        amfi_code,
        date,
        nav,
        ROW_NUMBER() OVER (
            PARTITION BY amfi_code
            ORDER BY date DESC
        ) AS row_num
    FROM nav_history
)
SELECT
    fm.scheme_name,
    rn.date AS latest_date,
    rn.nav AS latest_nav
FROM ranked_nav AS rn
JOIN fund_master AS fm
    ON rn.amfi_code = fm.amfi_code
WHERE rn.row_num = 1
ORDER BY rn.nav DESC;
