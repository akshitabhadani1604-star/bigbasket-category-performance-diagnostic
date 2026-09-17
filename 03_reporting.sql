
-- 1. CASE WHEN: Product revenue tiering
WITH product_revenue AS (
    SELECT
        p.product_name,
        SUM(o.amount_inr) AS total_revenue
    FROM orders AS o
    INNER JOIN products AS p
        ON o.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_name,
    total_revenue,
    CASE
        WHEN total_revenue >= 3000 THEN 'High'
        WHEN total_revenue >= 1000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM product_revenue
ORDER BY total_revenue DESC;


-- 2. Monthly revenue by category
SELECT
    p.category AS category,
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders AS o
INNER JOIN products AS p
    ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY
    p.category,
    strftime('%Y-%m', o.order_date)
ORDER BY
    p.category,
    month;


-- 3. Category target variance
WITH category_revenue AS (
    SELECT
        p.category,
        SUM(o.amount_inr) AS total_revenue
    FROM orders AS o
    INNER JOIN products AS p
        ON o.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY p.category
)
SELECT
    cr.category,
    cr.total_revenue,
    ct.target_revenue_inr,
    ct.target_revenue_inr - cr.total_revenue AS variance,
    ((cr.total_revenue - ct.target_revenue_inr) * 100.0)
        / ct.target_revenue_inr AS percentage_variance,
    CASE
        WHEN cr.total_revenue >= ct.target_revenue_inr
            THEN 'Above Target'
        WHEN (ct.target_revenue_inr - cr.total_revenue)
             <= (ct.target_revenue_inr * 0.15)
            THEN 'Below Target - Watch'
        ELSE 'Below Target - Critical'
    END AS status
FROM category_revenue AS cr
INNER JOIN category_targets AS ct
    ON cr.category = ct.category
ORDER BY cr.category;
