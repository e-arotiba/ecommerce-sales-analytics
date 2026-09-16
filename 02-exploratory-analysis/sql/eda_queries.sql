-- ======================================================
-- PHASE 2: EXPLORATORY DATA ANALYSIS (EDA)
-- ======================================================

USE sales_db;

-- 1. Basic statistics: count, mean, min, max for numeric fields
SELECT
    COUNT(*)               AS total_orders,
    AVG(Quantity)          AS avg_quantity,
    AVG(UnitPrice)         AS avg_unit_price,
    AVG(TotalPrice)        AS avg_total_price,
    MIN(TotalPrice)        AS min_total_price,
    MAX(TotalPrice)        AS max_total_price
FROM orders;

-- 2. Median TotalPrice (MySQL derivation using window functions)
SELECT AVG(TotalPrice) AS median_total_price
FROM (
    SELECT TotalPrice,
           ROW_NUMBER() OVER (ORDER BY TotalPrice) AS rn,
           COUNT(*) OVER ()                        AS cnt
    FROM orders
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2));

-- 3. Quartiles (Q1 / Q3) via NTILE for IQR calculation
WITH quartiled AS (
    SELECT TotalPrice, NTILE(4) OVER (ORDER BY TotalPrice) AS q
    FROM orders
)
SELECT
    MAX(CASE WHEN q = 1 THEN TotalPrice END) AS q1_boundary,
    MAX(CASE WHEN q = 3 THEN TotalPrice END) AS q3_boundary
FROM quartiled;

-- 4. Outlier Detection using IQR
SET @q1 = (SELECT MAX(CASE WHEN q = 1 THEN TotalPrice END)
           FROM (SELECT TotalPrice, NTILE(4) OVER (ORDER BY TotalPrice) AS q FROM orders) x);
SET @q3 = (SELECT MAX(CASE WHEN q = 3 THEN TotalPrice END)
           FROM (SELECT TotalPrice, NTILE(4) OVER (ORDER BY TotalPrice) AS q FROM orders) x);
SET @iqr = @q3 - @q1;

SELECT *
FROM orders
WHERE TotalPrice < (@q1 - 1.5 * @iqr)
   OR TotalPrice > (@q3 + 1.5 * @iqr);

-- 5. Monthly Revenue and Order Volume Trends
SELECT
    DATE_FORMAT(`Date`, '%Y-%m') AS month,
    COUNT(*)                   AS order_count,
    SUM(TotalPrice)            AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 6. Pearson Correlation Coefficient (Quantity vs TotalPrice)
SELECT
    (COUNT(*) * SUM(Quantity * TotalPrice) - SUM(Quantity) * SUM(TotalPrice)) /
    NULLIF(
        SQRT(COUNT(*) * SUM(Quantity * Quantity) - POW(SUM(Quantity), 2)) *
        SQRT(COUNT(*) * SUM(TotalPrice * TotalPrice) - POW(SUM(TotalPrice), 2)),
        0
    ) AS correlation_qty_totalprice
FROM orders;

-- 7. OrderStatus Breakdown by Payment Method
SELECT
    PaymentMethod,
    OrderStatus,
    COUNT(*) AS order_count
FROM orders
GROUP BY PaymentMethod, OrderStatus
ORDER BY PaymentMethod, order_count DESC;