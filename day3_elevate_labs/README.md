# 📊 Ecommerce SQL Analysis Project

This project involves running SQL queries to analyze an Ecommerce dataset using your choice of database (SQLite, MySQL, or PostgreSQL) inside Visual Studio Code (VS Code).

---

## 📁 Project Structure
day3_elevate_labs/
│
├── file1.sql         # Contains table schema and sample data
├── screenshots/          # Save your output screenshots here
└── README.md             # This file

---

## 🧰 Tools Required

- **VS Code**
- **SQLite / MySQL / PostgreSQL**
- **VS Code Extensions** (see below)

---

### ✅ 1. Install Extension
- Install **SQLTools**
- Install **SQLTools MySQL/MariaDB Driver**

### ✅ 2. Setup MySQL
- Install MySQL (e.g., via [XAMPP](https://www.apachefriends.org/index.html))
- Create a database:
  ```sql
  CREATE DATABASE ecommerce;

### ✅ 3. Connect VS Code to MySQL
- Press Ctrl+Shift+P > SQLTools: Add New Connection
-	Fill in MySQL host, port, user, and database
-	Save the connection

### ✅ 4. Run SQL
-	Open ecommerce.sql or analysis_queries.sql
-	Highlight your query and press Ctrl+Enter

---

✅ Queries Covered
	•	SELECT, WHERE, ORDER BY
	•	Joins: INNER JOIN, LEFT JOIN
	•	Aggregate functions: SUM, AVG, COUNT
	•	Subqueries
	•	Views
	•	Indexes