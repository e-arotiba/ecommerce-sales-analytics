# Phase 4 — Data Visualization

**Part of: E-Commerce Sales Analytics (a self-directed, end-to-end analytics project)**
**Author:** Emmanuel Oluwadabira Arotiba

---

## Overview

This final phase turns the findings from Phases 2 and 3 into
executive-ready visuals. There's a sharp distinction between
**exploratory** charts (for the analyst — dense, granular, every variable
visible) and **explanatory** charts (for a decision-maker — one clean
visual, one clear takeaway). Every chart here is built explanatory-first.

## Objective

- Select the right chart type for each business question (comparison →
  bar, trend → line, composition → bar used instead of pie, relationship
  → scatter)
- Title every chart with the *insight*, not the metric
- Apply the "5-second rule": a viewer should grasp the core takeaway
  within 5 seconds of looking at the chart
- Place the most important number where the eye naturally lands first

## Tools Used

- **Excel** — all charts built directly from query outputs (Phases 2/3).

## Methodology

For each visual, the business question came first, then the chart type
was chosen to answer it — never the reverse.

| # | Business Question | Analytical Need | Chart Type |
|---|---|---|---|
| 1 | Which product drives the most revenue? | Comparing categories | Bar chart |
| 2 | Is revenue trending up or down over time? | Trend over time | Line chart |
| 3 | How is revenue split across payment methods? | Composition/share | Bar chart *(pie avoided — see note)* |
| 4 | Does order quantity relate to order value? | Relationship between variables | Scatter plot |

**Note on pie charts:** bar charts were used even for the composition
question, since exact values are easier to compare at a glance on a bar
chart than pie-slice angles are to compare visually.

## Key Insights (chart titles used)

Worth noting: the "honest headline" test doesn't always produce a dramatic
finding. In three of these four charts, the real insight is that nothing
dominates — and the title says that plainly rather than manufacturing a
more exciting claim the data doesn't support.

1. **"Revenue Is Evenly Split Across All 7 Products — No Single Leader"**
   (bar chart). Chair (NGN 195,620) and Printer (NGN 195,613) are
   effectively tied for first, with the full range spanning only NGN
   151,722–195,620 — a flat spread, not a hero SKU.
2. **"Monthly Revenue Holds Roughly Steady, With No Sustained Trend"**
   (line chart). Revenue swung between NGN 27,752 (Apr 2023) and NGN
   68,069 (Jun 2024) month to month, but shows no consistent upward or
   downward direction across the full 30-month window — variance, not
   trend, is the story.
3. **"Payment Methods Are Nearly Evenly Used — Credit Card Leads Narrowly at 20.86%"**
   (bar chart). All five channels sit within a 2.5-point band
   (18.37%–20.86%) of total revenue share — customers aren't gravitating
   toward one payment method over another.
4. **"Order Value Scales Moderately With Quantity (r = 0.62) — Price Per Unit Matters More"**
   (scatter plot). The correlation is real but not tight: `UnitPrice`
   actually correlates more strongly with `TotalPrice` (r = 0.72) than
   `Quantity` does, meaning *what* customers buy drives order value more
   than *how many* units they buy.

## Folder Structure

```
04-visualization/
├── README.md
└── outputs/
    └── charts/
        ├── revenue_by_product_bar.png
        ├── monthly_revenue_trend_line.png
        ├── payment_method_share_bar.png
        └── quantity_vs_totalprice_scatter.png
```

---

*Previous: [Phase 3 — SQL Data Analysis](../03-sql-analysis/README.md)*
*This is the final phase of the project — see the [top-level README](../README.md) for the full narrative.*
