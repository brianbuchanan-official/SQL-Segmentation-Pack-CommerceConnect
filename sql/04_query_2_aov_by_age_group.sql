-- Query 2: Average Order Value (AOV = Average Order Value) by age group
-- Business logic:
-- 1. Create age groups using CASE.
-- 2. Join customers to orders to connect age to buying behavior.
-- 3. Calculate AOV (Average Order Value) per age group.
-- 4. Rank age groups by AOV to identify high-value segments.

SELECT
    CASE
        WHEN c.age BETWEEN 18 AND 24 THEN '18-24'
        WHEN c.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    AVG(o.total_amount) AS avg_order_value,   -- AOV
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_id) AS customer_count
FROM orders AS o
JOIN customers AS c
    ON c.customer_id = o.customer_id
GROUP BY age_group
ORDER BY avg_order_value DESC;
