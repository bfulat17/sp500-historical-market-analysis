--==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Yearly Volatility.
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
--==========================================================
-- Objective: 
-- Calculate yearly S&P500 volatility, by summarising the average, maximum and minimum daily volatility within each calendar year. 
-- Method:
-- Daily volatility prior to 1962 is understated as the source data contained identical Open, High, Low and Close prices for many observations, consequently volatility should be interpreted from 1962 onmwards, where complete intraday pricing is available.
-- Daily volatility was calculated within a CTE. A second CTE then aggregated the derived daily volatility values to calculate yearly average, maximum and minimum volatility. 
-- Values are standardised as percentages for ease of comparison. 
-- Key Insights:
-- 1987 recorded the highest single-day volatility within the dataset. 
-- Prolonged periods of uncertainty (1973-1975 oil crisis and 2007-09 GFC) show sustained increases in average daily volatility, whereas isolated market shocks (1987 Black Monday) demonstrated exceptionally high single-day volatility.
-- 2008 showed the highest average sustained daily volatility, highlighting prolonged market uncertainty following the GFC.
-- Elevated volatility also occurred during the dot-com collapse (2002), COVID-19 (2020), and other periods of economic uncertainty
-- Lower average volatility generally corresponds with prolonged bull markets and periods of stability. 
-- Why This Matters:
-- Understanding annual volatility helps analysts contextualise periods of market stability and instability. Annual volatility provides the numerical context of important historical market shifts. 
-- This enables analysts to better understand how market behaviour changed during periods of heightened uncertainty. 
-- When interpreting alongside annual returns and market sentiment, yearly volatility provides a more holisitc picture of market behaviour than any isolated individual metric. 

WITH daily_volatility AS (
  SELECT  
    year, 
    date,
    ROUND(((high-low)/ close) * 100, 2) AS daily_volatility_pct
FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily` 
),
yearly_volatility AS (
  SELECT
  year, 
  COUNT(*) AS trading_days,
  ROUND(AVG(daily_volatility_pct), 2) AS avg_daily_volatility_pct,
  ROUND(MAX(daily_volatility_pct), 2) AS max_daily_volatility_pct,
  ROUND(MIN(daily_volatility_pct), 2) AS min_daily_volatility_pct
FROM daily_volatility
GROUP BY year
)
SELECT *
FROM yearly_volatility
ORDER BY year; 




