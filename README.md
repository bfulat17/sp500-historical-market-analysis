## sp500-historical-market-analysis

An end-to-end SQL project analysing over 75 years of S&P 500 historical market data (1950-2026*), exploring long-term market performance, volatility, trading sentiment, extreme market movements and historical market behaviour using Google BigQuery

This repository documents the SQL component of a broader analytics project, with Power BI dashboards and a written analytical report currently in development.

-----------------------------------------------------------

## Skills Demonstrated: 

- Common Table Expressions (CTEs)
- Window Functions (LAG)
- ARRAY_AGG
- CASE Statements
- Aggregate Functions
- Conditional Aggregation
- Ranking Functions
- Data Validation
- Time Series Analysis
- Financial Data Analysis
- Analytical Query Design
- Google BigQuery
- Git
- GitHub

-----------------------------------------------------------

## Project Objectives

- Validate historical financial data prior to analysis
- Measure long-term market appreciation
- Analyse decade and year performance
- Identify bullish and bearish trading behaviour 
- Examine rolling market returns and volatility
- Investigate extreme periods of market volatility
- Produce reproducible SQL suitable for business reporting. 

-----------------------------------------------------------

## Dataset

## Source

S&P 500 historical daily price data. (Kaggle import)

## Coverage

1950-01-03 -> 2026-05-21

## Observations

19,217 trading days

Fields Include
- Date
- Open
- High
- Low
- Close
- Volume

## Additional engineered fields

- Daily Return
- Daily Volatility
- Market Sentiment
- Month
- Year
- Decade

## Known Limitations

- 1950-1962: High, Low, Open and Close prices are identical for many observations. Resulting in intraday volatility during this period being understated and volatility-based analyses should be interpreted from 1962 onwards. 

-----------------------------------------------------------

## Project Structure

01_sql/ 
SQL Queries

02_powerbi/
Dashboard (work in progress)

03_report/ 
Written analytical report (coming soon)

04_images/
Dashboard snapshots and visuals

-----------------------------------------------------------

## SQL Analysis

## 01 Data Validation

Validated

- Missing values
- Duplicate dates
- Invalid prices
- Dataset integrity

-----------------------------------------------------------

## 02 Decade Performance

Calculated

- Decade appreciation
- Opening and closing prices
- Trading day counts

-----------------------------------------------------------

## 03 Daily Market Performance

Analysed

- Positive
- Negative
- Flat trading days

Calculated sentiment balance by decade. 

-----------------------------------------------------------

## 04 Rolling Returns & Volatility

Calculated

- 30-day rolling returns
- Rolling volatility

-----------------------------------------------------------

## 05 Highest Trading Volume

Identified

- Top 100 trading volume days

-----------------------------------------------------------

## 06 Extreme Market Movements

Investigated

Highest volatility trading days across market history

-----------------------------------------------------------

## 07 Annual Performance

Calculated

- Annual returns
- Trading day sentiment
- Annual volatility

-----------------------------------------------------------

## Key Findings

- 2008 recorded highest sustained yearly volatility
- 1987 contained the single most volatile trading day
- Long periods of uncertainty produced higher average volatility rather than isolated spikes
- Bull markets were typically characterised by lower average volatility
- Market appreciation is driven by the combined effect of slightly more positive than negative days over long periods. 

-----------------------------------------------------------

## Technologies

- Google BigQuery
- SQL 
- Git
- GitHub


Power BI dashboards currently in development

-----------------------------------------------------------

## Author

Bilal Fulat

