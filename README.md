# SQL E-Commerce Database Project 🛒

## 🎯 Objective
This project demonstrates the design and implementation of a complete, realistic, and scalable **E-Commerce Database System** using **SQL Server**. It goes beyond simple table creation to incorporate best practices like Data Definition Language (DDL), Data Manipulation Language (DML), complex relationships, constraints, and advanced scenario-based queries.

---

## 🗂️ Database Architecture

The database `EcommerceDB` contains 12 interconnected tables representing core e-commerce functionalities:

1. **Users & UserRole:** Manages customers, admins, and their specific roles.
2. **Categories & Products:** Organizes products into logical categories.
3. **Orders & OrderItems:** Tracks user purchases and the specific items within each order.
4. **Carts & CartItems:** Represents active shopping carts for users before purchase.
5. **Wishlist:** Allows users to save favorite products.
6. **Reviews:** Captures user feedback and ratings for products.
7. **Payments:** Records transaction details related to orders.
8. **Discount:** Manages promotional coupons and product discounts.

### 🔥 Mandatory Columns & Soft Delete
To maintain data history and prevent accidental permanent data loss, the core tables incorporate tracking columns:
- `IsDeleted BIT DEFAULT 0` (Used for Soft Deleting records instead of hard `DELETE`)
- `CreatedAt DATETIME DEFAULT GETDATE()`
- `UpdatedAt DATETIME NULL`

---

## 🛠️ Features & Implementation details

### 1️⃣ Relationships & Constraints
- Proper **Primary Keys (PK)** and **Foreign Keys (FK)** are established to enforce referential integrity across the system.
- Usage of **CHECK Constraints** to ensure data quality (e.g., Ratings between 1 and 5, Positive Prices, Valid Order Statuses).
- `ON DELETE CASCADE` configured on specific dependencies to maintain structural integrity.

### 2️⃣ Data Manipulation (DML)
- Populated tables with **realistic sample data** across Users, Products, Categories, Orders, and more.
- Modified data utilizing `UPDATE`.
- Implemented **Soft Delete** logic (e.g., `UPDATE Products SET IsDeleted=1 WHERE id=4;`)

### 3️⃣ Aggregate Functions
Extensive application of Aggregate Functions in real business case queries:
- `COUNT()` - To measure user order volume and product distribution across categories.
- `SUM()` - To aggregate total sales and quantities sold.
- `AVG()` - To calculate average user ratings for products.

### 4️⃣ Database JOINs
Complex data combination combining related rows across multiple tables.
- **INNER JOIN** - Used widely to connect Users with Orders, Orders to OrderItems, and Products to Categories.
- **LEFT JOIN** - Utilized to display products along with any potential reviews, accommodating products that haven't been reviewed yet.

---

## 📌 Scenario-Based Queries

The project implements comprehensive SQL queries fulfilling key e-commerce business scenarios:

- **🧾 Scenario 1: Orders Overview:** Fetching comprehensive order history by joining Users, Orders, OrderItems, and Products.
- **🛒 Scenario 2: Product Listing:** Selecting available (non-deleted) products.
- **⭐ Scenario 3: Product Ratings:** Extracting the average rating per product.
- **❤️ Scenario 4: Wishlist:** Retrieving all products listed inside a specific user's wishlist.
- **💰 Scenario 5: Sales Analysis:** Calculating the total sales volume generated per user.
- **🔍 Scenario 6: Filtering:** Retrieving products within a certain price range and specific name patterns string matching (`LIKE`).
- **📅 Scenario 7: Recent Orders:** Extracting the top 5 most recent orders leveraging `ORDER BY` and `TOP`.

---

## 🚀 How to Run

1. Execute the `SQLProject.sql` file in **SQL Server Management Studio (SSMS)** or any SQL Server compatible IDE.
2. The script handles everything sequentially: Database Creation, Table definitions, Constraints mapping, Data Insertion, followed by all executable Scenario Queries.
