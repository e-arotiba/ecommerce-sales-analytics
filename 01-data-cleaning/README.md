# Phase 1 — Data Cleaning & Preparation

**Part of: E-Commerce Sales Analytics (a self-directed, end-to-end analytics project)**
**Author:** Emmanuel Oluwadabira Arotiba

---

## Overview

This is the foundation phase of a four-part analytics project built around
a 1,200-record e-commerce orders dataset. Before any exploration, querying,
or visualization happens, the raw data needs to be trustworthy — no
duplicate records, no missing values in required fields, and consistent
formatting throughout.

## Objective

- Identify and handle missing/null values without blindly deleting rows
- Eliminate duplicate records (one truth, one record)
- Standardize formats: dates (ISO 8601), text casing, numeric precision
- Document every change made and why
- Prove — not just claim — a 0% error rate on unique identifiers and
  date formats before calling the dataset clean

## Tools Used

- **Excel** — all cleaning steps performed natively (formulas, Find &amp;
  Replace, Remove Duplicates, Data Validation), keeping this stage
  lightweight and visual before the heavier SQL work in later phases.

## Methodology

1. **Audit first.** Used `COUNTBLANK()` and `=ISBLANK()` filters across
   every column to count missing values before changing anything — never
   cleaned blind. This surfaced the dataset's only real gap: 309 blank
   `CouponCode` values (25.75% of rows).
2. **Deliberate imputation, not silent blanks.** A blank `CouponCode`
   is ambiguous — does it mean "no coupon was used" or "this field wasn't
   captured"? Rather than leave it blank (which downstream aggregation
   would silently drop or miscount), it was explicitly imputed as
   `"No Coupon Used"`, making the "no coupon" case a first-class,
   queryable category rather than a gap.
3. **Deduplication check.** Ran **Data → Remove Duplicates** on `OrderID`
   as a standard safeguard — this dataset had zero duplicates, but the
   check is run on every dataset regardless, since assuming cleanliness
   is how errors slip through.
4. **Format consistency check.** Verified numeric precision
   (`UnitPrice × Quantity = TotalPrice` held exactly for all 1,200 rows,
   confirming no rounding drift), confirmed dates were stored as proper
   date values (not text) across a consistent 2023–2025 range, and
   spot-checked categorical fields (`PaymentMethod`, `OrderStatus`,
   `Product`, `ReferralSource`) for spelling variants — none were found.
5. **Verification gate.** Re-ran the duplicate and blank-value checks on
   the final file — both returned zero before the dataset was considered
   ready for Phase 2.

Full workbook: [`data/cleaned_dataset.xlsx`](data/cleaned_dataset.xlsx)
(cleaning steps documented on a dedicated "Cleaning Log" sheet within the
workbook itself, in addition to the change log below)

## Change Log

The raw export was audited column-by-column before any changes were made.
It turned out to be largely well-formed already — no duplicate `OrderID`s,
no missing dates, no negative or zero-value pricing fields, and every
`TotalPrice` value already matched `UnitPrice × Quantity`. The one real
gap found and fixed:

| Change ID | Description | Impact | Status |
|---|---|---|---|
| CR001 | Imputed missing `CouponCode` values with an explicit `"No Coupon Used"` label (rather than leaving blank, which would be ambiguous between "no coupon" and "data not captured") | 309 of 1,200 records (25.75%) | Resolved |

No rows were removed — every `OrderID` in the raw file is preserved in
the cleaned file (1,200 rows in, 1,200 rows out). Deduplication and
date/format standardization steps remain documented in the methodology
above as part of the general cleaning process, but this particular
dataset didn't require them.

## Verification Results

- Duplicate `OrderID` count after cleaning: **0** (target: 0) ✅
- NULL count in required fields after cleaning: **0** (target: 0) ✅
- `CouponCode` nulls after cleaning: **0** — all replaced with `"No Coupon Used"` ✅
- Date column confirmed as consistent format: **Yes** — all dates fall
  within a clean range (2023-01-01 to 2025-06-30), stored as proper date
  values throughout

## Folder Structure

```
01-data-cleaning/
├── README.md
└── data/
    ├── raw_dataset.csv        (uncleaned original export)
    └── cleaned_dataset.xlsx   (final output, feeds into Phase 2)
```

---

*Next: [Phase 2 — Exploratory Data Analysis](../02-exploratory-analysis/README.md)*
