-- ==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Top 100 Most Volatile Trading Days by Decade
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
-- ==========================================================
-- Objective: 
-- Identify which decades have the highest concentration of the top 100 most volatile days in S&P500 history.
-- Method: 
-- Used a CTE to identify the top 100 trading days ranked by daily price volatility
-- Aggregated the results by decade using COUNT() to determine which decades experienced the highest concentration of extreme market movements
-- Key Findings:
-- 2000s contained 48 of the top 100 most volatile days, the highest of any decade - largely reflecting the DotCom crash and the GFC. 
-- 2020s ranked second with 16 days, driven primarily by the COVID19 market shock
-- 1980s ranked third with 15 days, influenced heavily by the Black Monday Crash of 1987 
-- Extreme market volatility was concentrated by periods of major financial crises rather than being evenly distributed across decades.

WITH top_100_volatile_days AS (
  SELECT 
  date, 
  decade,
  ROUND(volatility_pct * 100, 2) AS volatility_pct
FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily` 
ORDER BY volatility_pct DESC
LIMIT 100
)
SELECT 
  decade, 
  COUNT(*) AS volatile_day_count
FROM top_100_volatile_days 
GROUP BY decade
ORDER BY volatile_day_count DESC, decade;
