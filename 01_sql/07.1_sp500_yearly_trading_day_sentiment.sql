--==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Yearly Bull, Bear and Flat Trading Day Analysis
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
--==========================================================
-- Objectives
-- Analyse the proportion and frequency of bullish, bearish and flat trading days within each calendar year. 
-- Method:
-- Daily percentage changes were derived using LAG() to reference the previous trading days closing price.
-- Trading day sentiment was classified as Bull = positive, Bear = negative, flat = unchanged. 
-- COUNTIF was used to calculate both the number and percentage of bull, bear and flat days within each year.  
-- Key Insights: 
-- Bullish years do not always contain a larger proportion of bullish trading days.
-- The balance between bull / bear varies considerably between years.
-- Flat trading days are consistently representative of a very small portion of annual trading activity. 
-- Why This Matters:
-- Annual trading sentiment provides a more granular perspective than annual market performance alone.
-- Comparing the composition of trading days within annual returns contextualises how different market conditions produce bullish or bearish years. 
WITH daily_changes AS (
  SELECT 
  year,
  open,
  close, 
  LAG(close) OVER (ORDER BY date) AS prev_close,
  FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily` 
),
daily_returns AS (
  SELECT
  year,
  open,
  close,
  prev_close,
  ROUND(((close - prev_close) / prev_close) * 100, 2) AS daily_pct_return
  FROM daily_changes
  WHERE prev_close IS NOT NULL
),
yearly_sentiment AS (
SELECT 
 year,
 COUNT(*) AS total_days,
 ROUND(COUNTIF(daily_pct_return < 0) / COUNT(*) * 100, 2) AS bear_pct,
 ROUND(COUNTIF(daily_pct_return > 0) / COUNT(*) * 100, 2) AS bull_pct,
 ROUND(COUNTIF(daily_pct_return= 0) / COUNT(*) * 100, 2) AS flat_pct,
 COUNTIF(daily_pct_return < 0) AS bear_days,
 COUNTIF(daily_pct_return > 0) AS bull_days,
 COUNTIF(daily_pct_return = 0) AS flat_days
FROM daily_returns
GROUP BY year
)
SELECT
*
FROM yearly_sentiment
ORDER BY year