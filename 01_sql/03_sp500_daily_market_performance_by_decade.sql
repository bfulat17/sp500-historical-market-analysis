-- ==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Daily Market Performance by Decade
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
-- ==========================================================
-- Objective:
-- Analyse market performance + appreciation against decades
-- Method:
-- Daily changes were recalculated to amend imported datasets limitations (1950-62 misrepresentation), utilising LAG to address the inaccuracy, providing calculations across the full time series.
-- Decade joined utilised a join to combine pct appreciation from cleaned excel workbook import to embed calculation for daily changes and appreciation in the same table
-- Outerquery contains calculations to calculate the % of negative/positive/unchanged days within each decade
-- Countif to calculate tottal of negative/positive/unchanged days within each decade for overarching decade market sentiment
-- Sentiment Balance created to calculate difference in market sentiment balance between decades 
-- Key Analytical Insight:
-- Decades with exceptional appreciation generally experienced a higher proportion of positive trading days 
-- However, positive trading days alone do not determine market-performance
-- 2000s demonstrate that a decade can contain more positive than negative days whilst still producing a negative return
-- Magnitude of gains/losses is as important as the frequency of positive/negative trading days when exploring long-term market performance
-- Long-term wealth creation comes from a relatively small edge in positive trading days in conjunction with compounding over thousands of trading sessions. 
-- Potential Applications:
-- Compare historical market sentiment across decades 
-- Assess how long term market sentiment has evolved
-- Identify decades characterised by anomalous trading behaviour
-- Historical contextualisation for major market events (Black Monday, DotCom Bubble, GFC)
-- Support financial research into the relationship between daily market sentiment and long-term market performance

WITH daily_changes AS (
  SELECT 
  date, 
  decade,
  open,
  close, 
  LAG(close) OVER (ORDER BY date) AS prev_close
  FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily`
), 
decade_joined AS ( 
  SELECT
  d.decade,
  p.pct_appreciation,
  d.open,
  d.close,
  d.prev_close
FROM daily_changes AS d
JOIN `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_decade_performance` AS p
ON d.decade = p.decade
WHERE prev_close IS NOT NULL
)
SELECT 
 decade,
 ROUND(pct_appreciation * 100, 2) AS pct_appreciation,
 ROUND(COUNTIF(close < prev_close) / COUNT(*) * 100, 2) AS negative_trading_days_pct,
 ROUND(COUNTIF(close > prev_close) / COUNT(*) * 100, 2) AS positive_trading_days_pct,
 ROUND(COUNTIF(close = prev_close) / COUNT(*) * 100, 2) AS unchanged_trading_days_pct,
 ROUND((COUNTIF(close > prev_close) - COUNTIF(close < prev_close)) / COUNT(*) * 100, 2) AS sentiment_balance_pct,
 COUNTIF(close < prev_close) AS negative_trading_days,
 COUNTIF(close > prev_close) AS positive_trading_days,
 COUNTIF(close = prev_close) AS unchanged_trading_days
FROM 
 decade_joined
GROUP BY decade, pct_appreciation
ORDER BY decade;