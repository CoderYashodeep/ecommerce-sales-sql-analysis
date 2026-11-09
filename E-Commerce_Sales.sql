-- Task 3: SQL for Data Analysis
-- Project: E-Commerce Sales Analysis
-- Tool: MySQL Workbench

CREATE DATABASE IF NOT EXISTS ecommerce_sales;
USE ecommerce_sales;


-- 1. Create tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    email VARCHAR(255) UNIQUE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Insert sample data
INSERT INTO customers VALUES
(1, 'Aarav Sharma', 'Pune', 'aarav@example.com'),
(2, 'Priya Patel', 'Mumbai', 'priya@example.com'),
(3, 'Rohan Mehta', 'Delhi', 'rohan@example.com'),
(4, 'Sneha Iyer', 'Bengaluru', 'sneha@example.com'),
(5, 'Kabir Singh', 'Pune', 'kabir@example.com'),
(6, 'Ananya Rao', 'Hyderabad', 'ananya@example.com'),
(7, 'Ishaan Gupta', 'Chennai', 'ishaan@example.com');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000.00, 12),
(102, 'Wireless Mouse', 'Accessories', 800.00, 50),
(103, 'Keyboard', 'Accessories', 1500.00, 35),
(104, 'Smartphone', 'Electronics', 30000.00, 18),
(105, 'Headphones', 'Accessories', 2500.00, 25),
(106, 'Office Chair', 'Furniture', 7000.00, 10),
(107, 'Desk Lamp', 'Furniture', 1200.00, 20),
(108, 'Monitor', 'Electronics', 12000.00, 8);

INSERT INTO orders VALUES
(1001, 1, '2026-10-01', 'Delivered'),
(1002, 2, '2026-10-02', 'Delivered'),
(1003, 1, '2026-10-05', 'Shipped'),
(1004, 3, '2026-10-08', 'Delivered'),
(1005, 4, '2026-10-10', 'Pending'),
(1006, 5, '2026-10-12', 'Delivered'),
(1007, 2, '2026-10-15', 'Shipped'),
(1008, 6, '2026-10-18', 'Delivered');

INSERT INTO order_items VALUES
(1, 1001, 101, 1, 55000.00),
(2, 1001, 102, 2, 800.00),
(3, 1002, 104, 1, 30000.00),
(4, 1002, 105, 1, 2500.00),
(5, 1003, 103, 2, 1500.00),
(6, 1003, 105, 1, 2500.00),
(7, 1004, 106, 1, 7000.00),
(8, 1004, 107, 2, 1200.00),
(9, 1005, 108, 1, 12000.00),
(10, 1006, 102, 3, 800.00),
(11, 1006, 103, 1, 1500.00),
(12, 1007, 101, 1, 55000.00),
(13, 1008, 104, 1, 30000.00),
(14, 1008, 105, 2, 2500.00);

-- 3. Check the tables and data
SHOW TABLES;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

-- 4. Basic SELECT, WHERE and ORDER BY queries
-- Q1. Show all customers
SELECT * FROM customers;

-- Q2. Find customers who live in Pune
SELECT *
FROM customers
WHERE city = 'Pune';

-- Q3. Show products from highest price to lowest price
SELECT product_name, category, price
FROM products
ORDER BY price DESC;

-- Q4. Find products that cost more than 5000
SELECT product_name, price
FROM products
WHERE price > 5000;

-- Q5. Find orders that are delivered
SELECT *
FROM orders
WHERE status = 'Delivered';

-- 5. Aggregate functions and GROUP BY
-- Q6. Count the total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q7. Find the total sales amount
SELECT SUM(quantity * unit_price) AS total_sales
FROM order_items;

-- Q8. Find the average price of products
SELECT AVG(price) AS average_product_price
FROM products;

-- Q9. Find the highest and lowest product prices
SELECT MAX(price) AS highest_price, MIN(price) AS lowest_price
FROM products;

-- Q10. Find total quantity sold for each product
SELECT product_id, SUM(quantity) AS total_quantity_sold
FROM order_items
GROUP BY product_id;

-- Q11. Find sales amount for each product category
SELECT p.category,
       SUM(oi.quantity * oi.unit_price) AS category_sales
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_sales DESC;

-- Q12. Show categories where sales are more than 10000
SELECT p.category,
       SUM(oi.quantity * oi.unit_price) AS category_sales
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
HAVING SUM(oi.quantity * oi.unit_price) > 10000;

-- 6. Joins
-- Q13. INNER JOIN: Show customers who have placed orders
SELECT c.customer_name, o.order_id, o.order_date, o.status
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- Q14. LEFT JOIN: Show all customers, even if they have no orders
SELECT c.customer_name, o.order_id, o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Q15. RIGHT JOIN: Show all customers, even if they have no orders
SELECT c.customer_name, o.order_id, o.status
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id;

-- Q16. Show each order with the customer name and order amount
SELECT c.customer_name,
       o.order_id,
       SUM(oi.quantity * oi.unit_price) AS order_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name, o.order_id;

-- Q17. Show product names and the quantity sold
SELECT p.product_name, oi.quantity
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id;

-- 7. Subqueries
-- Q18. Find products that cost more than the average product price
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Q19. Find customers who have placed an order
SELECT customer_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- Q20. Find the most expensive product
SELECT product_name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- 8. Views
-- Q21. Create a view showing customer-wise sales
CREATE VIEW customer_revenue AS
SELECT c.customer_id,
       c.customer_name,
       SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;

-- View the customer sales report
SELECT * FROM customer_revenue
ORDER BY total_sales DESC;

-- Q22. Create a view showing product-wise sales
CREATE VIEW product_sales_summary AS
SELECT p.product_name,
       p.category,
       SUM(oi.quantity) AS total_quantity_sold,
       SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name, p.category;

-- View the product sales report
SELECT * FROM product_sales_summary
ORDER BY total_sales DESC;

-- 9. Indexes for faster searching
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_product_id ON order_items(product_id);

-- Check the query execution plan
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

-- 10. NULL value handling
-- Q23. Find customers whose city is missing
SELECT *
FROM customers
WHERE city IS NULL;

-- Q24. Display Unknown when a city value is NULL
SELECT customer_name,
       IFNULL(city, 'Unknown') AS customer_city
FROM customers;

-- End of project
