-- ============================================================================
-- DISCOUNT SYSTEM - SAMPLE DATA
-- ============================================================================
-- Purpose: Insert realistic sample data into all tables
-- Note: Ensure schema.sql is executed first before running this file
-- ============================================================================

USE discount_system;

-- ============================================================================
-- INSERT SAMPLE USERS
-- ============================================================================
-- Inserting 12 realistic user records
-- ============================================================================
INSERT INTO users (name, email, age, gender, city) VALUES
('Rajesh Kumar', 'rajesh.kumar@email.com', 28, 'Male', 'Mumbai'),
('Priya Sharma', 'priya.sharma@email.com', 25, 'Female', 'Delhi'),
('Amit Patel', 'amit.patel@email.com', 32, 'Male', 'Bangalore'),
('Neha Singh', 'neha.singh@email.com', 27, 'Female', 'Hyderabad'),
('Vikram Desai', 'vikram.desai@email.com', 35, 'Male', 'Pune'),
('Ananya Gupta', 'ananya.gupta@email.com', 24, 'Female', 'Chennai'),
('Rohan Verma', 'rohan.verma@email.com', 29, 'Male', 'Kolkata'),
('Divya Reddy', 'divya.reddy@email.com', 26, 'Female', 'Cochin'),
('Karan Singh', 'karan.singh@email.com', 31, 'Male', 'Ahmedabad'),
('Pooja Nair', 'pooja.nair@email.com', 23, 'Female', 'Surat'),
('Arjun Menon', 'arjun.menon@email.com', 33, 'Male', 'Jaipur'),
('Sneha Das', 'sneha.das@email.com', 28, 'Female', 'Lucknow');

-- ============================================================================
-- INSERT SAMPLE PRODUCTS
-- ============================================================================
-- Inserting 12 product records across different categories
-- ============================================================================
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Apple iPhone 15', 'Electronics', 79999.00, 50),
('Samsung Galaxy S24', 'Electronics', 85000.00, 45),
('Sony Headphones WH-1000XM5', 'Electronics', 24990.00, 100),
('Nike Air Max 90', 'Footwear', 8999.00, 80),
('Adidas Running Shoes', 'Footwear', 6999.00, 120),
('Puma Sports Shoes', 'Footwear', 5499.00, 95),
('Casio Digital Watch', 'Accessories', 3999.00, 150),
('Titan Analog Watch', 'Accessories', 12999.00, 60),
('Blue Denim Jacket', 'Clothing', 3499.00, 75),
('Cotton T-Shirt', 'Clothing', 899.00, 200),
('Levi''s Jeans', 'Clothing', 4999.00, 110),
('Winter Wool Sweater', 'Clothing', 2999.00, 85);

-- ============================================================================
-- INSERT SAMPLE DISCOUNTS
-- ============================================================================
-- Inserting 8 discount records for various products
-- Valid date ranges with some active and some expired
-- ============================================================================
INSERT INTO discounts (product_id, discount_percent, start_date, end_date, is_active) VALUES
(1, 10.00, '2026-08-01', '2026-10-31', TRUE),
(2, 15.00, '2026-09-01', '2026-09-30', TRUE),
(3, 20.00, '2026-09-10', '2026-10-10', TRUE),
(4, 25.00, '2026-07-01', '2026-09-15', TRUE),
(5, 30.00, '2026-09-01', '2026-12-31', TRUE),
(9, 40.00, '2026-08-15', '2026-10-15', TRUE),
(10, 50.00, '2026-09-01', '2026-09-30', TRUE),
(12, 35.00, '2026-09-10', '2026-11-10', TRUE);

-- ============================================================================
-- INSERT SAMPLE PURCHASES
-- ============================================================================
-- Inserting 25 purchase records with valid foreign-key relationships
-- All user_id, product_id, and discount_id references are valid
-- ============================================================================
INSERT INTO purchases (user_id, product_id, discount_id, quantity, amount, purchase_date, discount_used) VALUES
(1, 1, 1, 1, 71999.00, '2026-09-01', TRUE),
(2, 3, 3, 2, 39980.00, '2026-09-02', TRUE),
(3, 2, 2, 1, 72250.00, '2026-09-03', TRUE),
(4, 4, 4, 2, 13498.50, '2026-09-04', TRUE),
(5, 5, 5, 1, 4899.00, '2026-09-05', TRUE),
(6, 6, NULL, 3, 16497.00, '2026-09-06', FALSE),
(7, 9, 6, 1, 2099.40, '2026-09-07', TRUE),
(8, 10, 7, 5, 4045.00, '2026-09-08', TRUE),
(9, 12, 8, 1, 1949.35, '2026-09-09', TRUE),
(10, 1, 1, 1, 71999.00, '2026-09-10', TRUE),
(11, 3, 3, 1, 19995.00, '2026-09-11', TRUE),
(12, 2, 2, 1, 72250.00, '2026-09-12', TRUE),
(1, 11, NULL, 2, 9998.00, '2026-09-01', FALSE),
(2, 8, NULL, 1, 12999.00, '2026-09-02', FALSE),
(3, 4, 4, 1, 6749.25, '2026-09-03', TRUE),
(4, 5, 5, 2, 9798.00, '2026-09-04', TRUE),
(5, 7, NULL, 3, 11997.00, '2026-09-05', FALSE),
(6, 10, 7, 4, 3236.00, '2026-09-06', TRUE),
(7, 12, 8, 2, 3898.70, '2026-09-07', TRUE),
(8, 1, 1, 1, 71999.00, '2026-09-08', TRUE),
(9, 6, NULL, 5, 27495.00, '2026-09-09', FALSE),
(10, 9, 6, 3, 6298.20, '2026-09-10', TRUE),
(11, 2, 2, 1, 72250.00, '2026-09-11', TRUE),
(12, 3, 3, 2, 39980.00, '2026-09-12', TRUE),
(1, 11, NULL, 1, 4999.00, '2026-09-13', FALSE);

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================
-- Run these to verify data insertion

-- Check users count
SELECT COUNT(*) AS total_users FROM users;

-- Check products count
SELECT COUNT(*) AS total_products FROM products;

-- Check discounts count
SELECT COUNT(*) AS total_discounts FROM discounts;

-- Check purchases count
SELECT COUNT(*) AS total_purchases FROM purchases;

-- Display all data
SELECT 'Users' AS table_name, COUNT(*) AS record_count FROM users
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Discounts', COUNT(*) FROM discounts
UNION ALL
SELECT 'Purchases', COUNT(*) FROM purchases;

-- ============================================================================
-- END OF SAMPLE DATA
-- ============================================================================
