-- =============================================
-- DecodeLabs Data Analytics Internship — Batch 2026
-- Data Analytics Project 3 - SQL Analysis
-- Description: Analysis of e-commerce orders dataset of 1,200 rows
-- Date: July 11, 2026
-- Prepared by: Afolayan Racheal | June 2026
-- ============================================

-- Query 1: Data Overview & Validation
-- Objective: Gives the big picture of the entire dataset (total records, revenue, time range).

SELECT COUNT(*) AS total_orders,
       ROUND(SUM(TotalPrice), 2) AS total_revenue,
       ROUND(AVG(TotalPrice), 2) AS avg_order_value,
       MIN(Date) AS first_order_date,
       MAX(Date) AS last_order_date
FROM orders;

-- Query 2: Order Status Performance
-- Objective: Groups orders by their current status (Shipped, Cancelled, Returned, etc.).

SELECT OrderStatus,
       COUNT(*) AS order_count,
       ROUND(SUM(TotalPrice), 2) AS total_revenue,
       ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY OrderStatus
ORDER BY total_revenue DESC;

-- Query 3: Top Products by Revenue
-- Objective: Identifies which products generate the most money.

SELECT Product,
       COUNT(*) AS times_ordered,
       SUM(Quantity) AS total_units_sold,
       ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM orders
GROUP BY Product
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 4: Referral Source Effectiveness
-- Objective: Shows performance of different marketing channels (Instagram, Google, Email, etc.).

SELECT ReferralSource,
       COUNT(*) AS order_count,
       ROUND(SUM(TotalPrice), 2) AS total_revenue,
       ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY ReferralSource
ORDER BY total_revenue DESC;

-- Query 5: Coupon Code Impact
-- Objective: Analyzes how coupons affect sales volume and revenue.

SELECT COALESCE(CouponCode, 'No Coupon') AS coupon_code,
       COUNT(*) AS order_count,
       ROUND(SUM(TotalPrice), 2) AS total_revenue,
       ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY CouponCode
ORDER BY total_revenue DESC;

-- Query 6: Payment Method Analysis
-- Objective: Compares performance across different payment options.

SELECT PaymentMethod,
       COUNT(*) AS order_count,
       ROUND(SUM(TotalPrice), 2) AS total_revenue,
       ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY PaymentMethod
ORDER BY total_revenue DESC;

-- Query 7: High-Value Customers
-- Objective: Identifies the best (most valuable) customers.

SELECT CustomerID,
       COUNT(*) AS order_count,
       ROUND(SUM(TotalPrice), 2) AS total_spent
FROM orders
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;

-- Query 8: Orders Above Average Value
-- Objective: Finds premium / high-value transactions using a subquery.

SELECT OrderID, Date, Product, TotalPrice, OrderStatus
FROM orders
WHERE TotalPrice > (SELECT AVG(TotalPrice) FROM orders)
ORDER BY TotalPrice DESC
LIMIT 15;

-- Query 9: 2024 Performance Trend
-- Objective: Focuses analysis on a specific year.

SELECT OrderID, Date, Product, TotalPrice, OrderStatus
FROM orders
WHERE Date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY Date ASC;

-- Query 10: Most Popular Products (High Volume)
-- Objective: Shows only the most frequently ordered products

SELECT Product,
       COUNT(*) AS total_orders,
       ROUND(SUM(TotalPrice), 2) AS revenue
FROM orders
GROUP BY Product
HAVING COUNT(*) > 80
ORDER BY total_orders DESC;






