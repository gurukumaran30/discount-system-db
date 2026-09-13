# Discount System Database Project

A comprehensive MySQL database project for managing users, products, discounts, and purchases. This project is designed as a student learning resource for database design, SQL operations, and data preparation for machine learning applications.

---

## 📋 Project Objective

The Discount System Database demonstrates:
- **Database Design**: Creating normalized tables with proper relationships
- **Data Integrity**: Implementing primary keys, foreign keys, and constraints
- **SQL Operations**: INSERT, SELECT, UPDATE, DELETE queries
- **Complex Queries**: JOINs, aggregations, and analytics
- **ML-Ready Data**: Preparing datasets for machine learning models
- **Data Validation**: Ensuring data quality and consistency

---

## 🛠️ Technologies Used

- **Database**: MySQL 8.x
- **GUI Tool**: MySQL Workbench
- **Backend**: Flask/Python (for integration)
- **Python Library**: mysql-connector-python
- **Version Control**: Git & GitHub

---

## 📊 Database Structure

### Tables Overview

#### 1. **users** - Customer Information
- `user_id` (INT, PK, AUTO_INCREMENT)
- `name` (VARCHAR 100, NOT NULL)
- `email` (VARCHAR 150, UNIQUE, NOT NULL)
- `age` (INT, NOT NULL)
- `gender` (VARCHAR 20, NOT NULL)
- `city` (VARCHAR 100, NOT NULL)
- Timestamps: `created_at`, `updated_at`

#### 2. **products** - Product Catalog
- `product_id` (INT, PK, AUTO_INCREMENT)
- `product_name` (VARCHAR 150, NOT NULL)
- `category` (VARCHAR 100, NOT NULL)
- `price` (DECIMAL 10,2, NOT NULL)
- `stock_quantity` (INT, DEFAULT 0)
- Timestamps: `created_at`, `updated_at`

#### 3. **discounts** - Discount Management
- `discount_id` (INT, PK, AUTO_INCREMENT)
- `product_id` (INT, FK → products)
- `discount_percent` (DECIMAL 5,2, NOT NULL)
- `start_date` (DATE, NOT NULL)
- `end_date` (DATE, NOT NULL)
- `is_active` (BOOLEAN, DEFAULT TRUE)
- Timestamps: `created_at`, `updated_at`

#### 4. **purchases** - Purchase Transactions
- `purchase_id` (INT, PK, AUTO_INCREMENT)
- `user_id` (INT, FK → users)
- `product_id` (INT, FK → products)
- `discount_id` (INT, FK → discounts, NULLABLE)
- `quantity` (INT, NOT NULL)
- `amount` (DECIMAL 10,2, NOT NULL)
- `purchase_date` (DATE, NOT NULL)
- `discount_used` (BOOLEAN, DEFAULT FALSE)
- Timestamps: `created_at`, `updated_at`

### Entity Relationships

```
users (1) ──→ (many) purchases
products (1) ──→ (many) purchases
products (1) ──→ (many) discounts
discounts (1) ──→ (many) purchases (optional)
```

### Indexes for Performance

- Email uniqueness on `users.email`
- Category search on `products.category`
- Foreign key lookups on all relationship columns
- Date range searches on `discounts` and `purchases`

---

## 🚀 How to Run in MySQL Workbench

### Prerequisites
1. MySQL Server 8.x installed and running
2. MySQL Workbench installed
3. Project files downloaded from GitHub

### Step-by-Step Instructions

#### **Step 1: Clone the Repository**
```bash
git clone https://github.com/gurukumaran30/discount-system-db.git
cd discount-system-db
```

#### **Step 2: Open MySQL Workbench**
1. Launch MySQL Workbench
2. Click on your MySQL connection (or create one if needed)
3. You should now see the SQL Editor window

#### **Step 3: Run schema.sql (Create Database & Tables)**

**Option A: Using File Menu**
1. Go to **File** → **Open SQL Script**
2. Navigate to `database/schema.sql` and open it
3. Click **Execute** (or press `Ctrl+Shift+Enter`)
4. Wait for execution to complete (you should see "Query OK" messages)

**Option B: Copy-Paste Method**
1. Open `database/schema.sql` in a text editor
2. Copy all content
3. Paste into the MySQL Workbench SQL Editor
4. Press `Ctrl+Shift+Enter` to execute

**Expected Output:**
```
Query OK, 1 row affected
Query OK, 0 rows affected (0.05 sec)
Query OK, 0 rows affected (0.06 sec)
...
```

**Verify Tables Created:**
```sql
SHOW TABLES IN discount_system;
```

#### **Step 4: Run sample_data.sql (Insert Sample Data)**

1. Go to **File** → **Open SQL Script**
2. Navigate to `data/sample_data.sql` and open it
3. Click **Execute** (or press `Ctrl+Shift+Enter`)
4. Wait for execution to complete

**Expected Output:**
```
Query OK, 12 rows affected
Query OK, 12 rows affected
Query OK, 8 rows affected
Query OK, 25 rows affected
```

**Verify Data Inserted:**
```sql
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM discounts;
SELECT COUNT(*) FROM purchases;
```

#### **Step 5: Run queries.sql (Execute Query Examples)**

1. Go to **File** → **Open SQL Script**
2. Navigate to `queries/queries.sql` and open it
3. You can now execute individual queries or sections:
   - To run a single query: Select it and press `Ctrl+Enter`
   - To run all: Press `Ctrl+Shift+Enter`

**Example: Display All Users**
```sql
SELECT user_id, name, email, age, gender, city 
FROM users 
ORDER BY user_id;
```

**Example: Top 5 Customers by Spending**
```sql
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
```

### Useful MySQL Workbench Tips

| Action | Shortcut |
|--------|----------|
| Execute Current Query | `Ctrl+Enter` |
| Execute All | `Ctrl+Shift+Enter` |
| Format SQL | `Ctrl+B` |
| Find | `Ctrl+F` |
| Replace | `Ctrl+H` |
| Comment Line | `Ctrl+/` |

---

## ✅ How to Verify the Database

### Verification Query Set

Run these queries to verify everything is working correctly:

```sql
-- 1. Check all tables exist
SHOW TABLES IN discount_system;

-- 2. Count records in each table
SELECT 'users' AS table_name, COUNT(*) AS count FROM users
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'discounts', COUNT(*) FROM discounts
UNION ALL
SELECT 'purchases', COUNT(*) FROM purchases;

-- 3. Verify foreign key relationships
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'discount_system' AND REFERENCED_TABLE_NAME IS NOT NULL;

-- 4. Check for orphaned records
SELECT COUNT(*) FROM purchases WHERE user_id NOT IN (SELECT user_id FROM users);
SELECT COUNT(*) FROM purchases WHERE product_id NOT IN (SELECT product_id FROM products);

-- 5. Display sample JOIN query results
SELECT 
    u.name,
    pr.product_name,
    p.quantity,
    p.amount,
    d.discount_percent,
    p.purchase_date
FROM purchases p
INNER JOIN users u ON p.user_id = u.user_id
INNER JOIN products pr ON p.product_id = pr.product_id
LEFT JOIN discounts d ON p.discount_id = d.discount_id
LIMIT 10;

-- 6. Test ML-ready dataset
SELECT 
    u.user_id,
    u.name,
    COUNT(p.purchase_id) AS purchase_count,
    SUM(p.amount) AS total_amount,
    AVG(p.amount) AS average_amount
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
GROUP BY u.user_id, u.name
ORDER BY total_amount DESC;
```

---

## 🧠 ML-Ready Dataset

The project includes prepared queries for machine learning:

### Dataset 1: Customer Segmentation
```sql
-- Aggregate purchase behavior by user
SELECT 
    u.user_id,
    u.age,
    u.gender,
    COUNT(p.purchase_id) AS purchase_frequency,
    SUM(p.amount) AS customer_lifetime_value,
    AVG(p.amount) AS average_order_value,
    CASE 
        WHEN COUNT(p.purchase_id) >= 5 THEN 'High Value'
        WHEN COUNT(p.purchase_id) >= 3 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
GROUP BY u.user_id, u.age, u.gender;
```

### Dataset 2: Product Recommendation Features
```sql
-- Product popularity and discount effectiveness
SELECT 
    pr.product_id,
    pr.product_name,
    pr.category,
    COUNT(p.purchase_id) AS popularity_score,
    SUM(p.amount) AS total_revenue,
    SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) AS discount_sales_count
FROM products pr
LEFT JOIN purchases p ON pr.product_id = p.product_id
GROUP BY pr.product_id, pr.product_name, pr.category;
```

### Dataset 3: User-Product Interaction Matrix
```sql
-- Interaction data for recommendation systems
SELECT 
    u.user_id,
    pr.product_id,
    COUNT(p.purchase_id) AS interaction_count,
    SUM(p.amount) AS total_value
FROM users u
CROSS JOIN products pr
LEFT JOIN purchases p ON u.user_id = p.user_id AND pr.product_id = p.product_id
GROUP BY u.user_id, pr.product_id
HAVING COUNT(p.purchase_id) > 0;
```

---

## 🔗 How Flask/Python Can Connect

### Connection Example Using mysql-connector-python

#### **Installation**
```bash
pip install mysql-connector-python
```

#### **Basic Connection Script**
```python
import mysql.connector
from mysql.connector import Error

def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host='localhost',           # Replace with your host
            user='root',                # Replace with your username
            password='your_password',   # Replace with your password
            database='discount_system'
        )
        
        if connection.is_connected():
            db_info = connection.get_server_info()
            print(f"Successfully connected to MySQL Server version {db_info}")
            
            cursor = connection.cursor()
            cursor.execute("SELECT DATABASE();")
            record = cursor.fetchone()
            print(f"You're connected to database: {record}")
            
            return connection
            
    except Error as e:
        print(f"Error while connecting to MySQL: {e}")
        return None

# Usage
conn = connect_to_database()
```

#### **Query Execution Example**
```python
import mysql.connector
import pandas as pd

def get_user_purchases(user_id):
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='your_password',
            database='discount_system'
        )
        
        cursor = connection.cursor(dictionary=True)
        
        query = """
        SELECT 
            u.name,
            pr.product_name,
            p.quantity,
            p.amount,
            p.purchase_date
        FROM purchases p
        INNER JOIN users u ON p.user_id = u.user_id
        INNER JOIN products pr ON p.product_id = pr.product_id
        WHERE u.user_id = %s
        ORDER BY p.purchase_date DESC
        """
        
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()
        
        # Convert to Pandas DataFrame for ML
        df = pd.DataFrame(results)
        
        cursor.close()
        connection.close()
        
        return df
        
    except Error as e:
        print(f"Error: {e}")
        return None

# Usage
user_purchases = get_user_purchases(1)
print(user_purchases)
```

#### **ML Dataset Query Example**
```python
def get_ml_dataset():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='your_password',
            database='discount_system'
        )
        
        query = """
        SELECT 
            u.user_id,
            u.age,
            u.gender,
            COUNT(p.purchase_id) AS purchase_count,
            SUM(p.amount) AS total_amount,
            AVG(p.amount) AS average_amount,
            SUM(CASE WHEN p.discount_used = TRUE THEN 1 ELSE 0 END) AS discount_usage
        FROM users u
        LEFT JOIN purchases p ON u.user_id = p.user_id
        GROUP BY u.user_id, u.age, u.gender
        """
        
        df = pd.read_sql(query, connection)
        connection.close()
        
        return df
        
    except Error as e:
        print(f"Error: {e}")
        return None
```

#### **Environment Variables (Secure Approach)**
Create a `.env` file:
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_secure_password
DB_NAME=discount_system
```

Read from `.env`:
```python
import os
from dotenv import load_dotenv
import mysql.connector

load_dotenv()

connection = mysql.connector.connect(
    host=os.getenv('DB_HOST'),
    user=os.getenv('DB_USER'),
    password=os.getenv('DB_PASSWORD'),
    database=os.getenv('DB_NAME')
)
```

---

## 📁 Project File Structure

```
discount-system-db/
│
├── database/
│   └── schema.sql              # Database schema with CREATE statements
│
├── data/
│   └── sample_data.sql         # Sample data INSERT statements
│
├── queries/
│   └── queries.sql             # All SQL query examples
│
├── README.md                   # This file
├── .gitignore                  # Git ignore rules
└── LICENSE                     # Project license (optional)
```

### File Descriptions

| File | Purpose |
|------|---------|
| `database/schema.sql` | Creates database and tables with primary/foreign keys |
| `data/sample_data.sql` | Inserts 12 users, 12 products, 8 discounts, 25 purchases |
| `queries/queries.sql` | 50+ example queries for INSERT, SELECT, UPDATE, DELETE, JOIN, ML |
| `README.md` | Complete documentation and setup guide |
| `.gitignore` | Prevents sensitive files from being committed |

---

## 📤 How to Upload to GitHub

### Prerequisites
1. GitHub account (create at https://github.com/signup)
2. Git installed on your computer (https://git-scm.com/download)

### Step-by-Step Upload Instructions

#### **Step 1: Initialize Local Git Repository**
```bash
# Navigate to your project directory
cd discount-system-db

# Initialize git
git init

# Check git status
git status
```

#### **Step 2: Create .gitignore File**
Create a `.gitignore` file to exclude unnecessary files:
```
# Database backups
*.sql.bak
*.sql.backup

# IDE files
.vscode/
.idea/
*.swp
*.swo

# Environment variables (DO NOT commit passwords)
.env
.env.local

# OS files
.DS_Store
Thumbs.db

# Python files (if applicable)
__pycache__/
*.pyc
*.egg-info/
venv/

# Logs
*.log
```

#### **Step 3: Configure Git User (First Time Only)**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@gmail.com"
```

#### **Step 4: Add Files to Staging**
```bash
# Add all files
git add .

# Verify files added
git status
```

#### **Step 5: Create Initial Commit**
```bash
git commit -m "Initial commit: Discount System Database project with schema, sample data, and queries"
```

#### **Step 6: Create Repository on GitHub**
1. Go to https://github.com/new
2. Repository name: `discount-system-db`
3. Description: `MySQL Discount System Database - A student project for managing users, products, discounts, and purchases`
4. Choose **Public** (to share with team members)
5. DO NOT initialize with README (we already have one)
6. Click **Create repository**

#### **Step 7: Add Remote Repository**
```bash
# Replace 'gurukumaran30' with your GitHub username
git remote add origin https://github.com/gurukumaran30/discount-system-db.git

# Verify remote
git remote -v
```

#### **Step 8: Push to GitHub**
```bash
# Push to main branch
git branch -M main
git push -u origin main

# Enter your GitHub credentials when prompted
# (or use GitHub token for authentication)
```

#### **Step 9: Verify on GitHub**
1. Go to https://github.com/gurukumaran30/discount-system-db
2. Check that all files are uploaded:
   - ✅ README.md
   - ✅ database/schema.sql
   - ✅ data/sample_data.sql
   - ✅ queries/queries.sql
   - ✅ .gitignore

### Git Commands Reference

| Command | Purpose |
|---------|---------|
| `git init` | Initialize local repository |
| `git add .` | Stage all files for commit |
| `git commit -m "message"` | Create commit with message |
| `git remote add origin <url>` | Link to GitHub repository |
| `git push -u origin main` | Push to GitHub |
| `git pull origin main` | Fetch latest changes from GitHub |
| `git status` | Check file status |
| `git log` | View commit history |
| `git diff` | View file changes |

### Updating Repository Later

After initial upload, to push new changes:
```bash
git add .
git commit -m "Describe your changes"
git push origin main
```

---

## 👥 Team Handoff Instructions

### For Team Members to Clone the Project

1. **Clone the repository:**
   ```bash
   git clone https://github.com/gurukumaran30/discount-system-db.git
   cd discount-system-db
   ```

2. **Set up MySQL:**
   - Ensure MySQL 8.x is installed and running
   - Open MySQL Workbench

3. **Execute SQL files in order:**
   - First: `database/schema.sql` (creates database)
   - Second: `data/sample_data.sql` (inserts sample data)
   - Third: `queries/queries.sql` (run example queries)

4. **Verify setup:**
   - Run verification queries from README
   - Check that 12 users, 12 products, 8 discounts, 25 purchases exist

5. **Connect Flask backend (if applicable):**
   - Install: `pip install mysql-connector-python`
   - Use connection examples from this README
   - Configure `.env` file with database credentials

### For Backend Integration

The Flask team should:
1. Create separate branch: `git checkout -b feature/flask-backend`
2. Add Flask connection code to project
3. Create views for:
   - User purchases
   - Product recommendations
   - Discount analytics
   - Customer segmentation
4. Test all endpoints with sample data
5. Submit pull request for review

---

## 📝 SQL Best Practices Used

✅ **Proper Data Types** - INT, VARCHAR, DECIMAL, DATE, BOOLEAN
✅ **Primary Keys** - AUTO_INCREMENT for all tables
✅ **Foreign Keys** - Referential integrity constraints
✅ **NOT NULL Constraints** - Data quality enforcement
✅ **UNIQUE Constraints** - Email uniqueness in users
✅ **Indexes** - Performance optimization
✅ **Timestamps** - created_at, updated_at for audit trail
✅ **Named Constraints** - Clear foreign key naming
✅ **Cascading Actions** - ON DELETE CASCADE for data consistency

---

## 🐛 Troubleshooting

### Issue: "Access Denied" Error
**Solution:** Check MySQL credentials in connection string

### Issue: "Database Already Exists" Error
**Solution:** Drop existing database or use `DROP DATABASE IF EXISTS discount_system;` before running schema.sql

### Issue: "Foreign Key Constraint Failed" Error
**Solution:** Ensure data is inserted in correct order:
1. users first
2. products second
3. discounts third
4. purchases last

### Issue: "Table Already Exists" Error
**Solution:** Use `DROP TABLE IF EXISTS tablename;` or recreate database

### Issue: Can't Find schema.sql File
**Solution:** Ensure file path is correct or copy-paste SQL directly from GitHub

---

## 📚 Resources

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [MySQL Workbench Guide](https://dev.mysql.com/doc/workbench/en/)
- [GitHub Help](https://docs.github.com)
- [Git Basics](https://git-scm.com/book/en/v2/Getting-Started-The-Basics)
- [mysql-connector-python Docs](https://dev.mysql.com/doc/connector-python/en/)

---

## 📄 License

This project is created for educational purposes. Feel free to modify and use for learning.

---

## ✨ Summary

This Discount System Database project provides:
- ✅ Complete MySQL schema with 4 normalized tables
- ✅ 50+ example SQL queries
- ✅ Sample data with valid relationships
- ✅ Data validation queries
- ✅ ML-ready dataset preparation
- ✅ Flask/Python integration examples
- ✅ Complete documentation

**Ready to use for college projects, portfolio, or team collaboration!**

---

**Last Updated:** September 2026
**Version:** 1.0
**Author:** AI & Data Science Student
**GitHub:** https://github.com/gurukumaran30/discount-system-db
