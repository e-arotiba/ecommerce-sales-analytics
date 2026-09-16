# Phase 2 — Exploratory Data Analysis (EDA)

**Part of: E-Commerce Sales Analytics (a self-directed, end-to-end analytics project)**
**Author:** Emmanuel Oluwadabira Arotiba

---

## Overview

This phase applies exploratory data analysis to the cleaned e-commerce
orders dataset (1,200 records, output of Phase 1) to uncover patterns,
trends, and outliers before any deeper querying or visualization is
attempted. The goal isn't to list numbers — it's to translate them into
business-relevant observations.

## Objective

- Calculate core descriptive statistics (mean, median, count, quartiles)
- Identify trends over time and across categories (product, payment
  method, referral source)
- Detect outliers using the IQR method and assess whether each is noise
  (data error) or signal (a genuine, worth-investigating case)
- Examine the relationship between order quantity and order value
- Summarize findings in plain business language, not just raw statistics

## Dataset

| Field | Description |
|---|---|
| `OrderID` | Unique order identifier |
| `Date` | Order date |
| `CustomerID` | Unique customer identifier |
| `Product` | Product purchased |
| `Quantity` | Units ordered |
| `UnitPrice` | Price per unit |
| `ShippingAddress` | Delivery address |
| `PaymentMethod` | Payment channel used |
| `OrderStatus` | Order state (Shipped, Cancelled, Pending, etc.) |
| `TrackingNumber` | Shipment tracking reference |
| `ItemsInCart` | Number of distinct items in the cart |
| `CouponCode` | Coupon applied, if any |
| `ReferralSource` | Channel that drove the order |
| `TotalPrice` | Final order value |

## Tools Used

- **MySQL** — primary analysis engine (window functions for median/quartiles,
  IQR-based outlier detection, aggregate queries)
- **Excel** — quick visual cross-checks during Phase 1 cleaning

## Methodology

1. Loaded the cleaned dataset into a MySQL table (`orders`) with primary
   key and supporting indexes.
2. Computed descriptive statistics (count, mean, median, min, max) across
   `Quantity`, `UnitPrice`, and `TotalPrice`.
3. Derived Q1/Q3 via `NTILE(4)` and flagged outliers using the standard IQR
   rule: values below `Q1 − 1.5×IQR` or above `Q3 + 1.5×IQR`.
4. Aggregated revenue and order volume by month, product, payment method,
   and referral source to surface trends.
5. Calculated Pearson's correlation coefficient between `Quantity` and
   `TotalPrice` manually (MySQL has no built-in `CORR()` function).
6. Cross-checked `OrderStatus` against `PaymentMethod` to look for
   concentration of cancellations.

Full queries: [`sql/eda_queries.sql`](sql/eda_queries.sql)

## Key Findings

- **Central tendency:** Mean order value was NGN 1,053.97 vs. a median of
  NGN 823.62 — the gap indicates a right-skewed distribution, with a
  smaller number of large orders pulling the average up above the typical
  order.
- **Outliers:** 8 orders fell outside the IQR bounds (above NGN 3,330.41).
  All 8 share one property: `Quantity = 5`, the maximum quantity observed
  anywhere in the dataset, spread across five different products and four
  different order statuses (Delivered, Returned, Cancelled, Shipped).
  This pattern — a hard cap at 5 units rather than random extreme values —
  reads as **signal, not noise**: these look like genuine bulk/max-cart
  orders rather than data entry errors, since a data error would more
  plausibly produce an isolated, unexplainable spike rather than a
  consistent cap shared across all 8 outliers.
- **Trend over time:** Revenue fluctuated between NGN 27,752 (April 2023,
  the lowest month) and NGN 68,069 (June 2024, the highest month) with no
  sustained upward or downward trend across the 30-month period — the
  series is essentially noisy/flat rather than growing or declining.
  This is a meaningful finding in itself: it suggests revenue is being
  driven by order-to-order variance rather than any seasonal or
  structural pattern worth targeting.
- **Correlation:** `UnitPrice` correlated with `TotalPrice` at r ≈ 0.72,
  and `Quantity` correlated with `TotalPrice` at r ≈ 0.62 — both moderate-
  to-strong positive relationships, as expected since `TotalPrice` is
  derived from both. `UnitPrice` mattering slightly more than `Quantity`
  suggests order value is driven somewhat more by *what* customers buy
  than *how many* units they buy.
- **Cancellations:** Cancellation rate was fairly consistent across
  payment methods (19–23%), with **Credit Card** highest at 23.08% and
  **Debit Card** lowest at 18.97% — a real but modest 4-point spread, not
  a dramatic concentration in any single channel.

## Folder Structure

```
02-exploratory-analysis/
├── README.md
├── sql/
│   └── eda_queries.sql
└── outputs/
    └── charts/
        ├── boxplot_totalprice.png
        ├── monthly_revenue_trend.png
        └── correlation_heatmap.png
```

---

*Previous: [Phase 1 — Data Cleaning](../01-data-cleaning/README.md)*
*Next: [Phase 3 — SQL Data Analysis](../03-sql-analysis/README.md)*
