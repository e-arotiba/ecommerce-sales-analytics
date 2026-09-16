# E-Commerce Sales Analytics

**A self-directed, end-to-end analytics project**
**Author:** Emmanuel Oluwadabira Arotiba
**Tools:** MySQL · Excel · Git/GitHub

---

## Overview

A full analytics pass covering cleaning, exploration, SQL-driven business
analysis, and visualization, run on a 1,200-record e-commerce orders
dataset spanning January 2023 to June 2025. The project is built as four
independent but connected phases, each with its own README, queries, and
outputs, so the work can be followed and verified step by step rather
than taken on faith.

The dataset covers 7 products, 5 payment methods, 5 referral channels, and
4 coupon states across 1,200 orders: enough variety to ask real business
questions without needing a live production system.

## The Story

Most of what this dataset says is "there is no dominant anything," and
that itself is the finding worth reporting honestly rather than dressing up:

- **No hero product.** Revenue is spread almost evenly across all 7 SKUs
  (NGN 151,722–195,620). Chair and Printer are effectively tied at the top,
  separated by about NGN 7 on a base of ~NGN 195,000.
- **No dominant channel.** Instagram edges out as the top referral source
  (NGN 275,285), but all five channels sit within a fairly tight band.
- **No dominant payment method.** Revenue share across the 5 payment
  methods ranges only 18.4%–20.9%. Customers don't gravitate to one option.
- **Coupons don't move basket size.** Average order value is nearly
  identical with or without a coupon (~1.4% difference), suggesting
  coupons drive order *volume* rather than order *value*.
- **Order value is driven more by what customers buy than how many units.**
  `UnitPrice` correlates with `TotalPrice` at r ≈ 0.72, vs. r ≈ 0.62 for
  `Quantity`.
- **Revenue is flat over time, not trending.** Monthly revenue swings
  between NGN 27,752 and NGN 68,069 with no sustained upward or downward
  direction across the 30-month window. Variance, not trend, is the story.
- **The 8 outliers are signal, not noise.** Every outlier order shares
  `Quantity = 5`, the dataset's hard cap, consistent with genuine
  max-cart orders rather than data entry errors.

## Setup

Both Phase 2 and Phase 3 query the same MySQL `orders` table. Run
[`schema.sql`](schema.sql) once to create it and load
`01-data-cleaning/data/cleaned_dataset.xlsx` before running either phase's
queries. It's kept at the project root rather than inside a single phase
folder, since neither phase owns it exclusively.

## Project Structure

```
ecommerce-sales-analytics/
├── README.md
├── LICENSE
├── schema.sql                      (creates the `orders` table; run before Phase 2 or 3)
├── 01-data-cleaning/
│   ├── README.md
│   └── data/
│       ├── raw_dataset.csv        (uncleaned original export)
│       └── cleaned_dataset.xlsx   (final output, feeds into Phase 2)
├── 02-exploratory-analysis/
│   ├── README.md
│   ├── sql/
│   │   └── eda_queries.sql
│   └── outputs/
│       └── charts/
│           ├── boxplot_totalprice.png
│           ├── monthly_revenue_trend.png
│           └── correlation_heatmap.png
├── 03-sql-analysis/
│   ├── README.md
│   └── sql/
│       └── business_queries.sql
└── 04-visualization/
    ├── README.md
    └── outputs/
        └── charts/
            ├── revenue_by_product_bar.png
            ├── monthly_revenue_trend_line.png
            ├── payment_method_share_bar.png
            └── quantity_vs_totalprice_scatter.png
```

| Phase | Focus | Tools |
|---|---|---|
| [01 — Data Cleaning](01-data-cleaning/README.md) | Audit, impute, verify: get from raw to trustworthy | Excel |
| [02 — Exploratory Analysis](02-exploratory-analysis/README.md) | Descriptive stats, outlier detection, correlation | MySQL, Excel |
| [03 — SQL Analysis](03-sql-analysis/README.md) | Seven business questions answered in pure SQL | MySQL |
| [04 — Visualization](04-visualization/README.md) | Explanatory charts, one insight per visual | Excel |

## Tools & Technologies

- **SQL (MySQL):** Table creation ([`schema.sql`](schema.sql)), IQR-based
  outlier detection, correlation calculation, and all seven business
  queries in Phase 3.
- **Microsoft Excel:** Data cleaning and imputation (Phase 1), boxplot and
  trend chart visualization (Phase 2), and all four explanatory charts
  (Phase 4).
- **Git/GitHub:** Version control, project documentation, and portfolio
  hosting.

## Dataset

| Field | Description |
|---|---|
| `OrderID` | Unique order identifier |
| `Date` | Order date (2023-01-01 to 2025-06-30) |
| `CustomerID` | Unique customer identifier |
| `Product` | One of 7 products |
| `Quantity` | Units ordered (1–5) |
| `UnitPrice` | Price per unit |
| `ShippingAddress` | Delivery address |
| `PaymentMethod` | One of 5 payment channels |
| `OrderStatus` | Shipped, Delivered, Pending, Cancelled, Returned |
| `TrackingNumber` | Shipment tracking reference |
| `ItemsInCart` | Number of distinct items in the cart |
| `CouponCode` | Coupon applied, or "No Coupon Used" |
| `ReferralSource` | Channel that drove the order |
| `TotalPrice` | Final order value |

## Skills Demonstrated

- Data auditing and deliberate (non-blind) cleaning
- IQR-based outlier detection, with judgment on signal vs. noise
- SQL: filtering, grouping, aggregation, `HAVING`, window functions
- Correlation analysis and its correct interpretation
- Chart design for a decision-maker, not just an analyst
- Honest reporting: several findings here are "nothing dominates,"
  reported as such rather than forced into a more dramatic narrative

## Connect

- **GitHub:** [e-arotiba](https://github.com/e-arotiba)
- **LinkedIn:** [linkedin.com/in/emmanuelarotiba](https://www.linkedin.com/in/emmanuelarotiba/)
