# Phase 3 — SQL Data Analysis

**Part of: E-Commerce Sales Analytics (a self-directed, end-to-end analytics project)**
**Author:** Emmanuel Oluwadabira Arotiba

---

## Overview

This phase extracts targeted business intelligence from the cleaned
e-commerce orders dataset using pure SQL — filtering, grouping, and
aggregating raw rows into answers a stakeholder could act on. Same
dataset as Phase 2, different lens: instead of exploring shape and
outliers, this phase answers specific business questions directly.

## Objective

- Write filtered `SELECT` queries against real conditions (not just
  `SELECT *`)
- Use `WHERE`, `ORDER BY`, and `GROUP BY` to segment and rank results
- Perform aggregations (`COUNT`, `SUM`, `AVG`) that translate into business
  metrics
- Use `HAVING` to filter on aggregated results, not just raw rows
- Translate each query's output into a plain-English business takeaway

## Tools Used

- **MySQL** — all seven queries run directly against the `orders` table
  built in Phase 1/2.

## Methodology

Each query targets one specific business question rather than a generic
"explore the data" pass:

1. **High-value shipped orders** — which large orders actually completed?
2. **Revenue and volume by product** — which products carry the business?
3. **Referral source performance** — which channel is worth investing in?
4. **`HAVING`-filtered products** — which products clear a meaningful
   revenue bar, filtering out long-tail noise?
5. **Payment method revenue share** — percentage contribution of each
   channel to total revenue.
6. **Coupon usage impact** — does a coupon change average order value?
7. **Cancellation rate by payment method** — is cancellation risk
   concentrated anywhere?

Full queries: [`sql/business_queries.sql`](sql/business_queries.sql)

## Key Findings

- **High-value shipped orders:** 161 orders exceeded NGN 500 and
  successfully shipped, together worth NGN 225,456.10.
- **Top product by revenue:** Revenue is remarkably even across the
  catalog — **Chair** narrowly leads at NGN 195,620.11 across 178 orders,
  with **Printer** essentially tied at NGN 195,612.61 (181 orders).
  The full spread (Chair, Printer, Laptop, Tablet, Monitor, Desk, Phone)
  ranges only from NGN 151,722 to NGN 195,620 — no single product
  dominates the business.
- **Best-performing referral source:** **Instagram** drove the most
  revenue at NGN 275,285.45 across 259 orders, narrowly ahead of Email
  (NGN 261,808.55) and Google (NGN 250,441.48). Referral (word-of-mouth)
  was the weakest channel at NGN 226,815.58 — worth noting since it's
  typically a low-cost channel, so its underperformance here isn't
  necessarily bad news.
- **Key Revenue Drivers (HAVING > NGN 180,000):** Applying a diagnostic 
  threshold of NGN 180,000 isolated the top 4 revenue-generating products
  (Chair, Printer, Laptop, and Tablet). Together, these 4 SKUs generated
  NGN 769,928.23 (60.88% of total revenue), separating core revenue drivers
  from mid-tier items like Desk, Monitor, and Phone.
- **Payment method share:** Revenue share across payment methods is
  tightly clustered — **Credit Card** leads narrowly at 20.86% (NGN
  263,847.63), followed by Online (20.75%), Cash (20.54%), Gift Card
  (19.48%), and Debit Card (18.37%). No channel dominates; customers
  appear to distribute fairly evenly across available payment options.
- **Coupon impact:** Average order value was nearly identical with or
  without a coupon — NGN 1,057.64 (891 orders with a coupon) vs. NGN
  1,043.37 (309 orders without). The ~1.4% difference is small enough
  that coupons don't appear to meaningfully change basket size in this
  dataset — they may be driving order *volume* rather than order *value*,
  though testing that would need a controlled comparison this dataset
  alone can't provide.
- **Cancellation risk:** Cancellation rate is fairly flat across payment
  methods (see Phase 2) — **Credit Card** highest at 23.08%, **Debit
  Card** lowest at 18.97%. No single channel stands out as a clear
  cancellation risk driver.

## Folder Structure

```
03-sql-analysis/
├── README.md
└── sql/
    └── business_queries.sql
```

---

*Previous: [Phase 2 — Exploratory Data Analysis](../02-exploratory-analysis/README.md)*
*Next: [Phase 4 — Data Visualization](../04-visualization/README.md)*
