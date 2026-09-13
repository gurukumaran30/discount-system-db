-- ============================================================================
-- DISCOUNT SYSTEM - SQL QUERIES
-- ============================================================================
-- Purpose: Comprehensive SQL examples for INSERT, SELECT, UPDATE, DELETE,
--          JOIN operations, and ML-ready dataset preparation
-- Note: Execute schema.sql and sample_data.sql before running these queries
-- ============================================================================

USE discount_system;

-- ============================================================================
-- SECTION 1: BASIC INSERT OPERATIONS
-- ============================================================================

-- Example 1.1: Insert a new user
-- ============================================================================
INSERT INTO users (name, email, age, gender, city) 
VALUES ('Aditya Kumar', 'aditya.kumar@email.com', 30, 'Male', 'Gurgaon');

-- Example 1.2: Insert multiple users at once
-- ============================================================================
INSERT INTO users (name, email, age, gender, city) VALUES
('Madhav Singh', 'madhav.singh@email.com', 26, 'Male', 'Indore'),
('Isha Pandey', 'isha.pandey@email.com', 24, 'Female', 'Bhopal');

-- Example 1.3: Insert a new product
-- ============================================================================
INSERT INTO products (product_name, category, price, stock_quantity) 
VALUES ('MacBook Pro 16', 'Electronics', 149999.00, 30);

-- Example 1.4: Insert a discount for a product
-- ============================================================================
INSERT INTO discounts (product_id, discount_percent, start_date, end_date, is_active) 
VALUES (1, 5.00, '2026-09-15', '2026-10-15', TRUE);

-- Example 1.5: Insert a purchase record
-- ============================================================================
INSERT INTO purchases (user_id, product_id, discount_id, quantity, amount, purchase_date, discount_used) 
VALUES (1, 3, 3, 1, 19995.00, '2026-09-15', TRUE);

-- ============================================================================
-- SECTION 2: BASIC SELECT OPERATIONS
-- ============================================================================

-- Example 2.1: Display all users
-- ============================================================================
SELECT user_id, name, email, age, gender, city 
FROM users 
ORDER BY user_id;

-- Example 2.2: Display all products
-- ============================================================================
SELECT product_id, product_name, category, price, stock_quantity 
FROM products 
ORDER BY category, product_name;

-- Example 2.3: Display all discounts
-- ============================================================================
SELECT d.discount_id, p.product_name, d.discount_percent, 
       d.start_date, d.end_date, d.is_active 
FROM discounts d
JOIN products p ON d.product_id = p.product_id
ORDER BY d.discount_id;

-- Example 2.4: Display all purchases
-- ============================================================================
SELECT purchase_id, user_id, product_id, discount_id, quantity, amount, 
       purchase_date, discount_used 
FROM purchases 
ORDER BY purchase_date DESC;

-- Example 2.5: Find products by category (Electronics)
-- ============================================================================
SELECT product_id, product_name, category, price, stock_quantity 
FROM products 
WHERE category = 'Electronics' 
ORDER BY price DESC;

-- Example 2.6: Find products by category (Clothing)
-- ============================================================================
SELECT product_id, product_name, category, price, stock_quantity 
FROM products 
WHERE category = 'Clothing' 
ORDER BY product_name;

-- Example 2.7: Find purchases above a certain amount (above 10000)
-- ============================================================================
SELECT purchase_id, user_id, product_id, quantity, amount, purchase_date 
FROM purchases 
WHERE amount > 10000 
ORDER BY amount DESC;

-- Example 2.8: Find purchases below a certain amount (below 5000)
-- ============================================================================
SELECT purchase_id, user_id, product_id, quantity, amount, purchase_date 
FROM purchases 
WHERE amount < 5000 
ORDER BY amount ASC;

-- Example 2.9: Find users who made purchases
-- ============================================================================
SELECT DISTINCT u.user_id, u.name, u.email, u.city 
FROM users u
INNER JOIN purchases p ON u.user_id = p.user_id
ORDER BY u.user_id;

-- Example 2.10: Find users who have NOT made any purchases
-- ============================================================================
SELECT u.user_id, u.name, u.email, u.city 
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
WHERE p.purchase_id IS NULL
ORDER BY u.user_id;

-- Example 2.11: Find all active discounts
-- ============================================================================
SELECT d.discount_id, p.product_name, d.discount_percent, 
       d.start_date, d.end_date 
FROM discounts d
JOIN products p ON d.product_id = p.product_id
WHERE d.is_active = TRUE
ORDER BY d.start_date DESC;

-- Example 2.12: Find purchases where discount was used
-- ============================================================================
SELECT p.purchase_id, u.name, pr.product_name, p.quantity, p.amount, 
       d.discount_percent, p.purchase_date 
FROM purchases p
JOIN users u ON p.user_id = u.user_id
JOIN products pr ON p.product_id = pr.product_id
LEFT JOIN discounts d ON p.discount_id = d.discount_id
WHERE p.discount_used = TRUE
ORDER BY p.purchase_date DESC;

-- ============================================================================
-- SECTION 3: UPDATE OPERATIONS
-- ============================================================================

-- Example 3.1: Update a user's city
-- ============================================================================
-- UPDATE users 
-- SET city = 'New Delhi' 
-- WHERE user_id = 1;

-- Example 3.2: Update product stock quantity
-- ============================================================================
-- UPDATE products 
-- SET stock_quantity = stock_quantity - 5 
-- WHERE product_id = 1;

-- Example 3.3: Deactivate an expired discount
-- ============================================================================
-- UPDATE discounts 
-- SET is_active = FALSE 
-- WHERE end_date < CURDATE() AND is_active = TRUE;

-- Example 3.4: Update user age
-- ============================================================================
-- UPDATE users 
-- SET age = 31 
-- WHERE user_id = 2;

-- Example 3.5: Increase product price by 10%
-- ============================================================================
-- UPDATE products 
-- SET price = price * 1.10 
-- WHERE category = 'Electronics';

-- ============================================================================
-- SECTION 4: DELETE OPERATIONS
-- ============================================================================

-- Example 4.1: Delete a purchase (safe example - use a test record)
-- ============================================================================
-- DELETE FROM purchases 
-- WHERE purchase_id = 25 AND user_id = 1;
-- Note: This example deletes the last inserted purchase. Verify before executing.

-- Example 4.2: Delete discounts that have expired
-- ============================================================================
-- DELETE FROM discounts 
-- WHERE end_date < '2026-01-01';

-- Example 4.3: Delete products with zero stock (CAUTION: Use with care)
-- ============================================================================
-- DELETE FROM products 
-- WHERE stock_quantity = 0;
-- Note: This will cascade delete related records. Verify impact before executing.

-- ============================================================================
-- SECTION 5: COMPLEX JOIN QUERIES
-- ============================================================================

-- Example 5.1: Complete JOIN query with all tables
-- ============================================================================
-- Shows comprehensive purchase information
SELECT 
    p.purchase_id,
    u.user_id,
    u.name AS user_name,
    u.email,
    u.city,
    pr.product_id,
    pr.product_name,
    pr.category,
    p.quantity,
    pr.price,
    p.amount,
    d.discount_id,
    d.discount_percent,
    p.discount_used,
    p.purchase_date
FROM purchases p
INNER JOIN users u ON p.user_id = u.user_id
INNER JOIN products pr ON p.product_id = pr.product_id
LEFT JOIN discounts d ON p.discount_id = d.discount_id
ORDER BY p.purchase_date DESC;

-- Example 5.2: Purchase summary by user
-- ============================================================================
SELECT 
    u.user_id,
    u.name,
    u.email,
    COUNT(p.purchase_id) AS total_purchases,
    SUM(p.amount) AS total_spent,
    AVG(p.amount) AS average_purchase_amount,
    MAX(p.amount) AS max_purchase_amount,
    MIN(p.amount) AS min_purchase_amount
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
GROUP BY u.user_id, u.name, u.email
ORDER BY total_spent DESC;

-- Example 5.3: Product sales summary
-- ============================================================================
SELECT 
    pr.product_id,
    pr.product_name,
    pr.category,
    pr.price,
    COUNT(p.purchase_id) AS total_sales,
    SUM(p.quantity) AS total_quantity_sold,
    SUM(p.amount) AS total_revenue,
    AVG(p.quantity) AS avg_quantity_per_sale
FROM products pr
LEFT JOIN purchases p ON pr.product_id = p.product_id
GROUP BY pr.product_id, pr.product_name, pr.category, pr.price
ORDER BY total_revenue DESC;

-- Example 5.4: Discount effectiveness analysis
-- ============================================================================
SELECT 
    d.discount_id,
    pr.product_name,
    d.discount_percent,
    d.start_date,
    d.end_date,
    COUNT(p.purchase_id) AS purchases_with_discount,
    SUM(p.quantity) AS quantity_sold_with_discount,
    SUM(p.amount) AS revenue_with_discount
FROM discounts d
LEFT JOIN products pr ON d.product_id = pr.product_id
LEFT JOIN purchases p ON d.discount_id = p.discount_id AND p.discount_used = TRUE
GROUP BY d.discount_id, pr.product_name, d.discount_percent, d.start_date, d.end_date
ORDER BY purchases_with_discount DESC;

-- Example 5.5: Category-wise sales performance
-- ============================================================================
SELECT 
    pr.category,
    COUNT(p.purchase_id) AS total_transactions,
    SUM(p.quantity) AS total_units_sold,
    SUM(p.amount) AS total_revenue,
    AVG(p.amount) AS avg_transaction_value,
    COUNT(DISTINCT p.user_id) AS unique_customers
FROM products pr
LEFT JOIN purchases p ON pr.product_id = p.product_id
GROUP BY pr.category
ORDER BY total_revenue DESC;

-- ============================================================================
-- SECTION 6: ML-READY DATASET QUERIES
-- ============================================================================

-- Example 6.1: Aggregate purchase behavior by user
-- ============================================================================
SELECT 
    u.user_id,
    u.name,
    u.email,
    u.age,
    u.gender,
    u.city,
    COUNT(p.purchase_id) AS purchase_count,
    SUM(p.amount) AS total_amount_spent,
    AVG(p.amount) AS average_purchase_amount,
    MAX(p.amount) AS max_purchase_amount,
    MIN(p.amount) AS min_purchase_amount,
    SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) AS discount_usage_count,
    ROUND(SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) / COUNT(p.purchase_id) * 100, 2) AS discount_usage_percentage
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
GROUP BY u.user_id, u.name, u.email, u.age, u.gender, u.city
ORDER BY total_amount_spent DESC;

-- Example 6.2: User-Product interaction matrix for ML
-- ============================================================================
SELECT 
    u.user_id,
    pr.product_id,
    pr.product_name,
    pr.category,
    COUNT(p.purchase_id) AS purchase_count,
    SUM(p.quantity) AS total_quantity,
    SUM(p.amount) AS total_amount,
    AVG(p.amount) AS average_amount,
    SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) AS times_used_discount,
    MAX(d.discount_percent) AS max_discount_applied,
    MAX(p.purchase_date) AS last_purchase_date
FROM users u
CROSS JOIN products pr
LEFT JOIN purchases p ON u.user_id = p.user_id AND pr.product_id = p.product_id
LEFT JOIN discounts d ON p.discount_id = d.discount_id
GROUP BY u.user_id, pr.product_id, pr.product_name, pr.category
HAVING COUNT(p.purchase_id) > 0
ORDER BY u.user_id, total_amount DESC;

-- Example 6.3: Customer segmentation data
-- ============================================================================
SELECT 
    u.user_id,
    u.name,
    u.age,
    u.gender,
    u.city,
    COUNT(p.purchase_id) AS purchase_frequency,
    SUM(p.amount) AS customer_lifetime_value,
    AVG(p.amount) AS average_order_value,
    DATEDIFF(MAX(p.purchase_date), MIN(p.purchase_date)) AS customer_tenure_days,
    SUM(CASE WHEN p.discount_used = TRUE THEN p.amount ELSE 0 END) AS discount_revenue,
    SUM(CASE WHEN p.discount_used = FALSE THEN p.amount ELSE 0 END) AS full_price_revenue,
    CASE 
        WHEN COUNT(p.purchase_id) >= 5 THEN 'High Value'
        WHEN COUNT(p.purchase_id) >= 3 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
GROUP BY u.user_id, u.name, u.age, u.gender, u.city
ORDER BY customer_lifetime_value DESC;

-- Example 6.4: Product recommendation features
-- ============================================================================
SELECT 
    pr.product_id,
    pr.product_name,
    pr.category,
    pr.price,
    COUNT(p.purchase_id) AS popularity_score,
    SUM(p.quantity) AS total_units_sold,
    SUM(p.amount) AS total_revenue,
    AVG(CASE WHEN p.discount_used = TRUE THEN d.discount_percent ELSE 0 END) AS avg_discount_offered,
    SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) AS discount_sales_count,
    ROUND(SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) / COUNT(p.purchase_id) * 100, 2) AS discount_conversion_rate
FROM products pr
LEFT JOIN purchases p ON pr.product_id = p.product_id
LEFT JOIN discounts d ON p.discount_id = d.discount_id
GROUP BY pr.product_id, pr.product_name, pr.category, pr.price
ORDER BY popularity_score DESC;

-- Example 6.5: Time-series features for ML
-- ============================================================================
SELECT 
    DATE(p.purchase_date) AS purchase_date,
    COUNT(p.purchase_id) AS daily_transactions,
    SUM(p.amount) AS daily_revenue,
    COUNT(DISTINCT p.user_id) AS unique_customers,
    AVG(p.amount) AS avg_transaction_value,
    SUM(p.quantity) AS total_units_sold,
    SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) AS discount_transactions
FROM purchases p
GROUP BY DATE(p.purchase_date)
ORDER BY purchase_date DESC;

-- ============================================================================
-- SECTION 7: DATA VALIDATION QUERIES
-- ============================================================================

-- Example 7.1: Check if tables exist
-- ============================================================================
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'discount_system' 
ORDER BY TABLE_NAME;

-- Example 7.2: Count records in each table
-- ============================================================================
SELECT 
    'users' AS table_name, COUNT(*) AS record_count FROM users
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'discounts', COUNT(*) FROM discounts
UNION ALL
SELECT 'purchases', COUNT(*) FROM purchases;

-- Example 7.3: Verify primary keys
-- ============================================================================
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'discount_system' AND COLUMN_KEY = 'PRI'
ORDER BY TABLE_NAME;

-- Example 7.4: Verify foreign key relationships
-- ============================================================================
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'discount_system' AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

-- Example 7.5: Check for orphaned records (purchases with invalid user_id)
-- ============================================================================
SELECT p.purchase_id, p.user_id 
FROM purchases p
LEFT JOIN users u ON p.user_id = u.user_id
WHERE u.user_id IS NULL;

-- Example 7.6: Check for orphaned records (purchases with invalid product_id)
-- ============================================================================
SELECT p.purchase_id, p.product_id 
FROM purchases p
LEFT JOIN products pr ON p.product_id = pr.product_id
WHERE pr.product_id IS NULL;

-- Example 7.7: Check for orphaned records (purchases with invalid discount_id)
-- ============================================================================
SELECT p.purchase_id, p.discount_id 
FROM purchases p
WHERE p.discount_id IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM discounts d WHERE d.discount_id = p.discount_id);

-- Example 7.8: Verify discount records have valid product references
-- ============================================================================
SELECT d.discount_id, d.product_id 
FROM discounts d
LEFT JOIN products p ON d.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Example 7.9: Check for duplicate emails in users
-- ============================================================================
SELECT email, COUNT(*) AS count 
FROM users 
GROUP BY email 
HAVING COUNT(*) > 1;

-- Example 7.10: Verify data types and constraints
-- ============================================================================
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    COLUMN_KEY,
    EXTRA
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'discount_system'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- Example 7.11: Check purchase amounts are positive
-- ============================================================================
SELECT purchase_id, amount 
FROM purchases 
WHERE amount <= 0;

-- Example 7.12: Check quantities are positive
-- ============================================================================
SELECT purchase_id, quantity 
FROM purchases 
WHERE quantity <= 0;

-- Example 7.13: Check discount percentages are valid (0-100)
-- ============================================================================
SELECT discount_id, discount_percent 
FROM discounts 
WHERE discount_percent < 0 OR discount_percent > 100;

-- Example 7.14: Check discount dates are valid (start before end)
-- ============================================================================
SELECT discount_id, start_date, end_date 
FROM discounts 
WHERE start_date >= end_date;

-- ============================================================================
-- SECTION 8: REPORTING QUERIES
-- ============================================================================

-- Example 8.1: Top 5 customers by spending
-- ============================================================================
SELECT 
    u.user_id,
    u.name,
    u.email,
    COUNT(p.purchase_id) AS purchase_count,
    SUM(p.amount) AS total_spent
FROM users u
INNER JOIN purchases p ON u.user_id = p.user_id
GROUP BY u.user_id, u.name, u.email
ORDER BY total_spent DESC
LIMIT 5;

-- Example 8.2: Top 5 products by revenue
-- ============================================================================
SELECT 
    pr.product_id,
    pr.product_name,
    pr.category,
    COUNT(p.purchase_id) AS sales_count,
    SUM(p.amount) AS total_revenue
FROM products pr
LEFT JOIN purchases p ON pr.product_id = p.product_id
GROUP BY pr.product_id, pr.product_name, pr.category
ORDER BY total_revenue DESC
LIMIT 5;

-- Example 8.3: Revenue comparison: with discount vs without discount
-- ============================================================================
SELECT 
    SUM(CASE WHEN discount_used = TRUE THEN amount ELSE 0 END) AS revenue_with_discount,
    SUM(CASE WHEN discount_used = FALSE THEN amount ELSE 0 END) AS revenue_without_discount,
    SUM(amount) AS total_revenue,
    ROUND(SUM(CASE WHEN discount_used = TRUE THEN amount ELSE 0 END) / SUM(amount) * 100, 2) AS discount_revenue_percentage
FROM purchases;

-- Example 8.4: Monthly revenue trend
-- ============================================================================
SELECT 
    DATE_FORMAT(purchase_date, '%Y-%m') AS month,
    COUNT(purchase_id) AS transaction_count,
    SUM(amount) AS monthly_revenue,
    AVG(amount) AS avg_transaction_value
FROM purchases
GROUP BY DATE_FORMAT(purchase_date, '%Y-%m')
ORDER BY month DESC;

-- ============================================================================
-- END OF QUERIES
-- ============================================================================
