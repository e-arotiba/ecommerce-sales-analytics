-- ======================================================
-- PHASE 3: BUSINESS & REVENUE ANALYSIS
-- ======================================================

USE sales_db;

-- 1. Filtered SELECT: high-value shipped orders (> NGN 500)
SELECT OrderID, CustomerID, Product, TotalPrice, `Date`
FROM orders
WHERE OrderStatus = 'Shipped' AND TotalPrice > 500
ORDER BY TotalPrice DESC;

-- 2. Revenue and volume by product
SELECT
    Product,
    COUNT(*)         AS orders_count,
    SUM(TotalPrice)  AS total_revenue,
    AVG(TotalPrice)  AS avg_order_value
FROM orders
GROUP BY Product
ORDER BY total_revenue DESC;

-- 3. Referral source performance
SELECT
    ReferralSource,
    COUNT(*)         AS orders_count,
    SUM(TotalPrice)  AS revenue_generated
FROM orders
GROUP BY ReferralSource
ORDER BY revenue_generated DESC;

-- 4. Key Revenue Drivers (HAVING threshold > NGN 180,000 to isolate top SKUs)
SELECT
    Product,
    SUM(TotalPrice) AS total_revenue,
    COUNT(*)        AS orders_count
FROM orders
GROUP BY Product
HAVING SUM(TotalPrice) > 180000
ORDER BY total_revenue DESC;

-- 5. Percentage contribution of each payment method to total revenue
SELECT
    PaymentMethod,
    SUM(TotalPrice) AS revenue,
    ROUND(SUM(TotalPrice) * 100.0 / (SELECT SUM(TotalPrice) FROM orders), 2) AS pct_of_total
FROM orders
GROUP BY PaymentMethod
ORDER BY pct_of_total DESC;

-- 6. Coupon usage impact: average order value with vs. without a coupon
SELECT
    CASE WHEN CouponCode = 'No Coupon Used' THEN 'No Coupon' ELSE 'Coupon Used' END AS coupon_flag,
    COUNT(*)        AS orders_count,
    AVG(TotalPrice) AS avg_order_value
FROM orders
GROUP BY coupon_flag;

-- 7. Cancellation rate by payment method
SELECT
    PaymentMethod,
    COUNT(*)                                                   AS total_orders,
    SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct
FROM orders
GROUP BY PaymentMethod
ORDER BY cancellation_rate_pct DESC;