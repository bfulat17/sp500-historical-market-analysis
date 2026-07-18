--==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Yearly Performance
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
--==========================================================
-- Objective:
-- Calculate annual market appreciation using the first available opening price and final closing price each calendar year
-- Method:
-- Yearly performance is calculated from the first available opening price and last available closing prices within each year using ARRAY AGG.
-- Annual percentage return was calculated from derived opening and closing values, alongside trading day counts and date coverage for validation. 
-- Yearly sentiment was calculated based on point differential pertaining to year using CASE WHEN to identify bullish/bearish market sentiment. 
-- Key Insights:
-- Annual returns vary substantially across cycles.
-- Some years generated significant negative returns in spite of long-term market appreciation.
-- Trading-day counts remain relatively consistent across calendar years.
-- Potential Applications:
-- Identify the strongest and weakest market years. 
-- Support visualisation of long-term market cycles.
-- Why This Matters:
-- Yearly performance provides a higher-level perspective of market behaviour than daily analysis
-- Enables analysts to identify major bull / bear years whilst providing context to significant historical market events. 

WITH yearly_prices AS (
  SELECT
    year,
    ARRAY_AGG(open ORDER BY date ASC LIMIT 1)[OFFSET(0)] AS year_open,
    ARRAY_AGG(close ORDER BY date DESC LIMIT 1)[OFFSET(0)] AS year_close,
    MIN(date) AS start_date,
    MAX(date) AS end_date,
    COUNT(*) AS trading_days
  FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily`
  GROUP BY year
),
yearly_performance AS (
SELECT
  year,
  start_date,
  end_date,
  trading_days,
  ROUND(year_open, 2) AS year_open,
  ROUND(year_close, 2) AS year_close,
  ROUND(year_close - year_open, 2) AS yearly_differential,
  ROUND(((year_close - year_open) / year_open) * 100, 2) AS pct_return,
FROM yearly_prices
),
yearly_sentiment AS (
  SELECT 
  *,
  CASE
  WHEN yearly_differential > 0 THEN 'Bullish'
  WHEN yearly_differential < 0 THEN 'Bearish'
  ELSE 'Flat' END AS annual_market_sentiment
  FROM yearly_performance
)
SELECT 
year, 
start_date,
end_date,
trading_days,
year_open,
year_close,
yearly_differential,
annual_market_sentiment,
pct_return
FROM yearly_sentiment
ORDER BY year;

