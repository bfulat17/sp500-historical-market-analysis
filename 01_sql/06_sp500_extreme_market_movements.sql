-- ==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Top 100 Most Volatile Trading Days by Decade and Return Direction
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
-- ==========================================================
-- Objective:
-- Identify which decades contained the highest concentration of the 100 most volatile trading days in S&P 500 history, and determine whether those extreme sessions produced positive or negative returns.
-- Method:
-- Used a CTE to rank trading days by intraday price volatility and retain
-- the 100 highest-volatility observations.
-- Classified each extreme trading day by the direction of its daily return:
-- positive, negative, or unchanged.
-- Aggregated the results by decade using COUNT() and COUNTIF() to calculate:
-- Total number of extreme-volatility days
-- Positive-return extreme days
-- Negative-return extreme days
-- Unchanged extreme days
-- Positive and negative composition percentages
-- Key Findings:
-- The 2000s contained 48 of the top 100 most volatile trading days, largely reflecting the Dot-com crash and the Global Financial Crisis.
-- The 2020s ranked second with 16 extreme days, driven primarily by the COVID-19 market shock and subsequent periods of market instability.
-- The 1980s ranked third with 15 extreme days, influenced heavily by the Black Monday crash of 1987.
-- Extreme market movements were concentrated around major financial
-- crises rather than being evenly distributed across decades.
-- The positive-versus-negative return composition provides additional context on whether high-volatility sessions represented market sell-offs or sharp recovery movements

WITH top_100_volatile_days AS (
    SELECT
        date,
        decade,
        ROUND(volatility_pct * 100, 2) AS volatility_pct,
        daily_return_pct
    FROM
        `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily`
    ORDER BY
        volatility_pct DESC
    LIMIT 100
)

SELECT
    decade,
    COUNT(*) AS volatile_day_count,

    COUNTIF(daily_return_pct > 0) AS positive_extreme_days,
    COUNTIF(daily_return_pct < 0) AS negative_extreme_days,
    COUNTIF(daily_return_pct = 0) AS flat_extreme_days,

    ROUND(
        SAFE_DIVIDE(COUNTIF(daily_return_pct > 0), COUNT(*)) * 100,
        2
    ) AS positive_extreme_pct,

    ROUND(
        SAFE_DIVIDE(COUNTIF(daily_return_pct < 0), COUNT(*)) * 100,
        2
    ) AS negative_extreme_pct

FROM top_100_volatile_days
GROUP BY decade
ORDER BY volatile_day_count DESC;
