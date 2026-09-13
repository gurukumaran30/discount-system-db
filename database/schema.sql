-- ============================================================================
-- DISCOUNT SYSTEM DATABASE SCHEMA
-- ============================================================================
-- Purpose: A comprehensive database for managing users, products, discounts,
--          and purchase records with proper relationships and constraints.
-- Created for: AI & Data Science Student Project
-- MySQL Version: 8.x
-- ============================================================================

-- Step 1: Create Database
-- ============================================================================
CREATE DATABASE IF NOT EXISTS discount_system;
USE discount_system;

-- ============================================================================
-- TABLE 1: USERS
-- ============================================================================
-- Stores information about all users in the system
-- ============================================================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================================================
-- TABLE 2: PRODUCTS
-- ============================================================================
-- Stores information about all products available for purchase
-- ============================================================================
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================================================
-- TABLE 3: DISCOUNTS
-- ============================================================================
-- Stores information about all active and inactive discounts on products
-- Foreign Key: product_id references products(product_id)
-- ============================================================================
CREATE TABLE IF NOT EXISTS discounts (
    discount_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    discount_percent DECIMAL(5, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_discounts_product_id FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- ============================================================================
-- TABLE 4: PURCHASES
-- ============================================================================
-- Stores all purchase transactions made by users
-- Foreign Keys: 
--   - user_id references users(user_id)
--   - product_id references products(product_id)
--   - discount_id references discounts(discount_id)
-- ============================================================================
CREATE TABLE IF NOT EXISTS purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    discount_id INT,
    quantity INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    purchase_date DATE NOT NULL,
    discount_used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_purchases_user_id FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_purchases_product_id FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_purchases_discount_id FOREIGN KEY (discount_id) REFERENCES discounts(discount_id) ON DELETE SET NULL
);

-- ============================================================================
-- CREATE INDEXES FOR PERFORMANCE OPTIMIZATION
-- ============================================================================
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_discounts_product_id ON discounts(product_id);
CREATE INDEX idx_discounts_dates ON discounts(start_date, end_date);
CREATE INDEX idx_purchases_user_id ON purchases(user_id);
CREATE INDEX idx_purchases_product_id ON purchases(product_id);
CREATE INDEX idx_purchases_discount_id ON purchases(discount_id);
CREATE INDEX idx_purchases_date ON purchases(purchase_date);

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================
