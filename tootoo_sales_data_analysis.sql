-- Use the database
USE tootoo;

-- Cutomer Analysis
-- Count the number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Analyze customer demographics based on city
SELECT city, COUNT(*) AS total_customers FROM customers GROUP BY city;

-- Identify the top customers based on the number of orders
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 5;

-- Calculate average registration date
SELECT AVG(DATEDIFF(NOW(), registration_date)) AS avg_registration_days FROM customers;




-- Product Analysis:
-- Count the number of products
SELECT COUNT(*) AS total_products FROM products;

-- Analyze product categories and their distribution
SELECT category, COUNT(*) AS total_products FROM products GROUP BY category;

-- Identify top-selling products based on the number of orders
SELECT p.product_name, COUNT(o.order_id) AS total_orders
FROM products p
JOIN orders_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY total_orders DESC
LIMIT 5;

-- Calculate average product price
SELECT AVG(price) AS avg_price FROM products;





-- Order Analysis:
-- Count the number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Calculate total revenue generated from orders
SELECT SUM(price * quantity) AS total_revenue FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Analyze order status distribution
SELECT status, COUNT(*) AS total_orders FROM orders GROUP BY status;

-- Identify the most popular shipping locations
SELECT shipping_city, shipping_state, COUNT(*) AS total_orders
FROM orders
GROUP BY shipping_city, shipping_state
ORDER BY total_orders DESC
LIMIT 5;

-- Analyze order frequency over time
SELECT DATE(order_date) AS order_date, COUNT(*) AS total_orders
FROM orders
GROUP BY DATE(order_date)
ORDER BY order_date;



-- Review Analysis:
-- Count the number of reviews
SELECT COUNT(*) AS total_reviews FROM reviews;

-- Calculate average product rating
SELECT AVG(rating) AS avg_rating FROM reviews;

-- Identify products with the highest ratings
SELECT p.product_name, AVG(r.rating) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id
ORDER BY avg_rating DESC
LIMIT 5;



-- Employee Analysis:
-- Count the number of employees
SELECT COUNT(*) AS total_employees FROM employees;

-- Analyze employee demographics based on city
SELECT city, COUNT(*) AS total_employees FROM employees GROUP BY city;

-- Calculate average salary
SELECT AVG(salary) AS avg_salary FROM employees;

-- Identify the highest-paid employees
SELECT full_name, salary FROM employees ORDER BY salary DESC LIMIT 5;





