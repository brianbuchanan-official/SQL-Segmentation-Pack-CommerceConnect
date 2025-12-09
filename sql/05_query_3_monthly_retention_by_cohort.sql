-- Query 3: Monthly retention by cohort
-- Business logic:
-- 1. Assign each customer to a cohort_month based on signup_date.
-- 2. Assign each order to an active_month based on order_date.
-- 3. Count distinct customers active in each month after signup.
-- 4. Calculate retention rate = active_customers / cohort_size.

WITH cohort AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM customers
),
activity AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS active_month
    FROM orders
)
SELECT
    c.cohort_month,
    a.active_month,
    COUNT(DISTINCT a.customer_id) AS active_customers,
    (SELECT COUNT(*)
     FROM cohort
     WHERE cohort_month = c.cohort_month) AS cohort_size,
    ROUND(
        COUNT(DISTINCT a.customer_id)::NUMERIC /
        (SELECT COUNT(*)
         FROM cohort
         WHERE cohort_month = c.cohort_month) * 100, 2
    ) AS retention_rate_percent
FROM cohort c
JOIN activity a
    ON c.customer_id = a.customer_id
GROUP BY
    c.cohort_month,
    a.active_month
ORDER BY
    c.cohort_month,
    a.active_month;
