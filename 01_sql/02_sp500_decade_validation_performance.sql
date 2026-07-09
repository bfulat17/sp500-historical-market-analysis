-- ==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Decade Performance
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
-- ==========================================================
-- Objective:
-- Recalculate and validate S&P500 decade appreciation using the first available opening price and last available close price within each deacde. 
-- Method:
-- Decade performance is recalculated from the first and last available closing prices within each decade using ARRAY AGG
-- This avoids relying on imported percentage fields and ensures that appreciation calculations are reproducible from the underlying dataset. 
-- 2020s represent a partial decade, ending on 2026-05-21 and are included for completeness over enabling direct comparison with completed decades. 
-- Key Insights: 
-- Decade returns vary substantially across the analysis period. 
-- Percentage Appreciation and absolute point differential provide different perspectives relating to market performance. 
-- High appreciation does not always infer thje largest absolute point movement. 
-- Trading day counts remain largely consistent across decades.
-- Why This Matters: 
-- Decade performance provides a top-down overview of approximately 75 years of market data
-- Comparing percentage appreciation with point differential helps to distinguish relative performance from absolute market performance. 
-- Supports long-term trend analysis and aids contextualisation of major periods of market stagnation / growth and decline. 

WITH decade_prices AS (
  SELECT
    decade,
    ARRAY_AGG(open ORDER BY date ASC LIMIT 1)[OFFSET(0)] AS decade_open,
    ARRAY_AGG(close ORDER BY date DESC LIMIT 1)[OFFSET(0)] AS decade_close,
    MIN(date) AS start_date,
    MAX(date) AS end_date,
    COUNT(*) AS trading_days
  FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily`
  GROUP BY decade
)

SELECT
  decade,
  start_date,
  end_date,
  trading_days,
  ROUND(decade_open, 2) AS decade_open,
  ROUND(decade_close, 2) AS decade_close,
  ROUND(decade_close - decade_open, 2) AS decade_differential,
  ROUND(((decade_close - decade_open) / decade_open) * 100, 2) AS pct_appreciation
FROM decade_prices
ORDER BY decade;