# 📈 S&P 500 Historical Market Analysis

![Executive Overview](04_images/executive_overview.png)

An end-to-end analytics project analysing **75 years of S&P 500 market history (1950–2026)** using **Google BigQuery, SQL and Power BI**.

---

## Project Overview

This project explores long-term market behaviour by analysing historical S&P 500 trading data.

The analysis covers:

- Long-term market appreciation
- Annual and decade performance
- Market volatility
- Trading sentiment
- Extreme market movements
- Data validation and quality assurance

---

## Dashboard

### Executive Overview

![Executive Overview](04_images/executive_overview.png)

Provides a high-level summary of market performance including KPIs, closing price history and executive insights.

---

### Performance Analysis

![Performance Analysis](04_images/performance_analysis.png)

Analyses annual returns and decade performance, highlighting long-term appreciation and market downturns.

---

### Volatility Analysis

![Volatility Analysis](04_images/volatility_analysis.png)

Investigates historical volatility, identifies the most volatile years and highlights clustering around historical market events.

---

### Extreme Market Movements

![Extreme Market Movements](04_images/extreme_market_movements.png)

Analyses the top 100 most volatile trading days and classifies them by positive & negative market movement and their total appearances in decades across the dataset.  

---

### Data Validation

![Data Validation](04_images/data_validation.png)

Documents the validation process used to verify dataset completeness, integrity and known historical limitations before analysis.

---

## Project Objectives

- Validate historical financial data
- Measure long-term market appreciation
- Analyse decade and annual performance
- Investigate market volatility
- Examine extreme market events
- Produce reproducible SQL suitable for business reporting

---

## Dataset

**Source**

Kaggle – Historical S&P 500 Daily Prices

**Coverage**

1950-01-03 → 2026-05-21

**Observations**

19,217 trading days

**Fields**

- Date
- Open
- High
- Low
- Close
- Volume
- Daily Return
- Daily Volatility
- Market Sentiment
- Year
- Month
- Decade

---

## Data Validation

The dataset passed all validation checks prior to analysis.

Validation included:

- Duplicate trading days
- Missing values
- Invalid OHLC relationships
- Negative prices and trading volumes
- Historical OHLC consistency

### Known Limitation

3,013 observations prior to 1962 contain identical Open, High, Low and Close prices. These observations were excluded from volatility analysis.

---

## SQL Analysis

### 01 Data Validation

- Dataset completeness
- Integrity checks
- Historical OHLC validation

### 02 Decade Performance

- Decade appreciation
- Opening & closing prices
- Trading day counts

### 03 Daily Market Performance

- Positive
- Negative
- Flat trading days
- Trading sentiment

### 04 Rolling Returns & Volatility

- Rolling returns
- Rolling volatility

### 05 Trading Volume

- Top 100 trading volume days

### 06 Extreme Market Movements

- Top 100 volatile days
- Positive vs negative market movements
- Decade comparison

### 07 Annual Performance

- Annual returns
- Annual volatility
- Trading sentiment

---

## Key Findings

- The S&P 500 delivered strong long-term appreciation despite major market crises.
- The 2000s experienced the highest concentration of extreme volatility.
- 2008 recorded the highest annual volatility.
- Major crises produced sustained periods of elevated volatility rather than isolated spikes.
- Long-term growth resulted from a slightly higher proportion of positive trading days over time.

---

## Technologies

- Google BigQuery
- SQL
- Power BI
- DAX
- Git
- GitHub

---

## Repository Structure

```text
sp500-historical-market-analysis/
│
├── 01_sql/
├── 02_powerbi/
│   └── sp500_historical_market_analysis.pbix
├── 03_images/
└── README.md
```

---

## Skills Demonstrated

### SQL

- Common Table Expressions (CTEs)
- Window Functions
- ARRAY_AGG
- CASE Statements
- Ranking Functions
- Conditional Aggregation

### Analytics

- Time Series Analysis
- Financial Data Analysis
- Data Validation
- Dashboard Design
- Data Storytelling

### Tools

- Google BigQuery
- Power BI
- DAX
- Git
- GitHub

---

## Author

**Bilal Fulat**
