--==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Rolling 30-Day Returns & Volatility
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
-- ==========================================================
-- Objective:
-- measure the short-term behaviour of the S&P500 by calculating the 30-day-rolling-avg volatility and daily returns. Providing insight into the shifting market momentum and risk over time. 
-- Method:
-- daily returns calculated in a CTE with a lag clause to amend the imported data-sets misrepresented 1950-62 values. (using previous trading days close price obtained via LAG)
-- 30 trading window was applied using window functions to calculate AVG daily return pct & STDDEV for volatility
-- Key Analytical Insights:
-- A higher rolling average return infers positive market momentum
-- a lower / negative average return infers weakening performance or market declines
-- increased volatility pertains to  market uncertainty and larger day-to-day pricing
-- decline in rolling volatility indicates more stability within the market
-- Potential Applications:
-- can calculate changes in market risk over time 
-- compare market stability against decades
-- identify periods of unusually high uncertainty (Black Monday, Financial Crisis, Tariff-related market shocks)
-- contextualises interpretations of major market events alongside price fluctuations. 
-- Why This Matters:
-- Price does not directly infer market conditions, two periods can have similar returns but different risk levels. Rolling volatility captures how consistently the market is moving, aiding analysts in identifying periods of stability, instability and changing market behaviour. 

WITH daily_returns AS (
  SELECT
    date,
    close,
    ((close - LAG(close) OVER (ORDER BY date))) / LAG(close) OVER (ORDER BY date) AS daily_return_pct
    FROM `project-00afef68-2dfe-48de-8dd`.sp500_analysis.sp500_daily
), 
rolling_30_day_avg AS ( 
  SELECT
    date,
    close,
    daily_return_pct,
    AVG(daily_return_pct) OVER (ORDER BY date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS rolling_30_day_avg_return,
    STDDEV(daily_return_pct) OVER (ORDER BY date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS rolling_30_day_volatility
FROM daily_returns
)
SELECT
date, 
close, 
ROUND(daily_return_pct * 100, 2) AS daily_return_pct, 
ROUND(rolling_30_day_avg_return * 100, 2) AS rolling_30_day_avg_daily_return_pct,
ROUND(rolling_30_day_volatility * 100, 2) AS rolling_30_day_volatility_pct 
FROM rolling_30_day_avg
WHERE daily_return_pct IS NOT NULL
ORDER BY date DESC;
