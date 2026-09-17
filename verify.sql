-- BigBasket Capstone Verification

-- Expected: 31
SELECT COUNT(*) AS product_count FROM products;

-- Expected: 50
SELECT COUNT(*) AS customer_count FROM customers;

-- Expected: 500
SELECT COUNT(*) AS order_count FROM orders;

-- Expected: 6
SELECT COUNT(*) AS category_target_count FROM category_targets;

-- Expected:
-- Cancelled = 42
-- Delivered = 434
-- Pending = 24
SELECT status, COUNT(*) AS status_count
FROM orders
GROUP BY status
ORDER BY status;
