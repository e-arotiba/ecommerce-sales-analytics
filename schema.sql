-- ======================================================
-- DATABASE SCHEMA & TABLE DEFINITION
-- ======================================================

CREATE DATABASE IF NOT EXISTS sales_db;
USE sales_db;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    OrderID VARCHAR(50) PRIMARY KEY,
    `Date` DATE,
    CustomerID VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    ShippingAddress VARCHAR(255),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    TrackingNumber VARCHAR(50),
    ItemsInCart INT,
    CouponCode VARCHAR(50),
    ReferralSource VARCHAR(50),
    TotalPrice DECIMAL(10,2),
    INDEX idx_date (`Date`),
    INDEX idx_customer (CustomerID),
    INDEX idx_payment_status (PaymentMethod, OrderStatus)
);