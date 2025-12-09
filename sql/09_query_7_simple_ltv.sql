-- Query 7: Simple Customer Lifetime Value (LTV)
-- Business logic:
-- 1. Calculate total revenue per customer.
-- 2. Count total orders per customer.
-- 3. Compute Average Order Value (AOV = Average Order Value).
-- 4. Simple LTV = AOV * total_orders.
-- 5. Join customer details for segmentation analysis.

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.region,
    c.age,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    ROUND(
        AVG(o.total_amount) * COUNT(o.order_id), 
        2
    ) AS simple_LTV  -- Simple Lifetime Value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.region,
    c.age
ORDER BY
    simple_LTV DESC;
