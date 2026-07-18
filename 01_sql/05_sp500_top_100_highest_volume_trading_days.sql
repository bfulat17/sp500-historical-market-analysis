-- ==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Top 100 highest volume trading days 
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
-- ==========================================================
-- Objective:
-- Analyse the top-100 highest volume trading days in S&P500 history to identify relationships between activity, returns and volatility
-- Method:
-- The data set was ordered by trading volume in descending order and limited to the top 100 observations. daily volatility and returns were expressed as percentages to improve interpretability 
-- Key Analytical Insight
-- The highest trading-volume days frequently coincide with periods of elevated market volaility
-- High trading volume occurs during periods of significant gain and decline
-- Major market events i.e GFC and Covid frequently appear within the highest volume observations
-- Elevated trading volume may indicate periods of heightened investor participation and market uncertainty 
-- Potential Applications
-- Compare trading activity during historical market events.
-- Investigate the relationship between volume and volatility
-- Provide historical context for corrections, financial crises, and major market events
-- Support research into market behaviour during periods of elevated trading activity
-- Why This Matters:
-- Trading volume provides insight into market participations, analysing periods of exceptionally high volume alongside returns and volatility helps to explore how investors act during periods of heightened uncertainty and significant market movements. 

WITH top_100_highest_volume_days AS (
  SELECT 
  date, 
  decade, 
  volume, 
  volatility_pct AS daily_volatility_pct, 
  daily_return_pct
FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily` 
ORDER BY volume DESC
LIMIT 100)
SELECT 
  date, 
  volume,
  ROUND(daily_volatility_pct * 100, 2) AS daily_volatility_pct, 
  ROUND(daily_return_pct*100, 2) AS daily_return_pct, 
FROM top_100_highest_volume_days
ORDER BY volume DESC;