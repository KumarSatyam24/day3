-- Drop tables if they exist
DROP TABLE IF EXISTS order_items, orders, products, customers;

-- Customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    country TEXT
);

-- Products table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name TEXT,
    category TEXT,
    price DECIMAL(10, 2)
);

-- Orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order items table
CREATE TABLE order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Customers
INSERT INTO customers (customer_id, name, email, country) VALUES
(1, 'John Smith', 'john@example.com', 'USA'),
(2, 'Jane Doe', 'jane@example.com', 'Canada'),
(3, 'Alice Brown', 'alice@example.com', 'UK'),
(4, 'Carlos Garcia', 'carlos@example.com', 'Mexico');

-- Products
INSERT INTO products (product_id, name, category, price) VALUES
(1, 'Wireless Mouse', 'Electronics', 20.00),
(2, 'Mechanical Keyboard', 'Electronics', 70.00),
(3, 'Bluetooth Earbuds', 'Electronics', 25.00),
(4, 'Notebook', 'Stationery', 5.00),
(5, 'Pen Set', 'Stationery', 3.00);

-- Orders
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-12-01', 120.50),
(2, 2, '2024-12-02', 75.00),
(3, 3, '2024-12-03', 40.00),
(4, 1, '2025-01-15', 60.00),
(5, 4, '2025-01-20', 33.00);

-- Order Items
INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 3, 2, 25.00),
(2, 1, 2, 1, 70.00),
(3, 2, 1, 2, 20.00),
(4, 2, 4, 3, 5.00),
(5, 3, 5, 5, 3.00),
(6, 4, 1, 1, 20.00),
(7, 4, 3, 2, 25.00),
(8, 5, 5, 3, 3.00),
(9, 5, 4, 2, 5.00);

-- 1. Select all customers from USA
SELECT * FROM customers WHERE country = 'USA';

-- 2. Total number of orders per customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- 3. Total revenue per customer
SELECT o.customer_id, SUM(o.total_amount) AS revenue
FROM orders o
GROUP BY o.customer_id;

-- 4. Join: Get order details with customer name and product names
SELECT c.name AS customer_name, o.order_id, oi.quantity, p.name AS product_name
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

-- 5. Subquery: Find customers who spent more than average order amount
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (SELECT AVG(total_amount) FROM orders)
);

-- 6. Aggregate: Average order amount by country
SELECT c.country, AVG(o.total_amount) AS avg_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country;

-- 7. Create a view: Top 5 customers by revenue
CREATE VIEW top_customers AS
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 8. Add index to optimize performance on orders table
CREATE INDEX idx_orders_customer ON orders(customer_id);