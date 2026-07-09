-- ==========================================================
-- Project: S&P 500 Historical Market Analysis
-- Query: Data Validation
-- Author: Bilal Fulat
-- SQL Dialect: BigQuery
-- ==========================================================
-- Objective: 
-- Validate the imported cleaned dataset before analysis.
-- Method:
-- Used 3x CTEs to perform data validation pertaining to completeness, duplicates and integrity then used 2x CROSS JOINs to join each CTE within one summary table 
-- Key Findings:
-- Dataset contains 19217 trading-day observations. 
-- Covers the period between 1950-01-03 to 2026-05-21
-- No missing values identified across key variables
-- No duplicate trading dates were recorded
-- No invalid pricing relationships were found 
-- No negative prices or trading volumes were found. 
-- Dataset deemed suitable for downstream  analysis. 

WITH completeness_check AS (
SELECT
  COUNT(*) AS total_rows,
  MIN(date) AS earliest_date,
  MAX(date) AS latest_date,
  COUNTIF(date IS NULL) AS missing_dates,
  COUNTIF(open IS NULL) AS missing_open,
  COUNTIF(high IS NULL) AS missing_high,
  COUNTIF(low IS NULL) AS missing_low,
  COUNTIF(close IS NULL) AS missing_close,
  COUNTIF(volume IS NULL) AS missing_volume
FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily` 
),
duplicate_check AS (
  SELECT
    COUNT(*) AS duplicate_dates
  FROM (
    SELECT date
    FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily`
    GROUP BY date
    HAVING COUNT(*) > 1
  )
), integrity_check AS (
  SELECT
    COUNTIF(high < low) AS invalid_high_low,
    COUNTIF(open < 0) AS negative_open,
    COUNTIF(high < 0) AS negative_high,
    COUNTIF(low < 0) AS negative_low,
    COUNTIF(close < 0) AS negative_close,
    COUNTIF(volume < 0) AS negative_volume
FROM `project-00afef68-2dfe-48de-8dd.sp500_analysis.sp500_daily`
)
SELECT
*
FROM completeness_check
CROSS JOIN duplicate_check
CROSS JOIN integrity_check;
