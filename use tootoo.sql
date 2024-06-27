-- Create the database
DROP DATABASE IF EXISTS tootoo;
CREATE DATABASE tootoo;

-- Use the database
USE tootoo;

-- Create table for storing customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create table for storing products
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    product_description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    category VARCHAR(50)
);

-- Create table for storing orders and order items combined
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    shipping_address VARCHAR(255),
    shipping_city VARCHAR(100),
    shipping_state VARCHAR(100),
    shipping_postal_code VARCHAR(20),
    status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    delivery_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create table for storing reviews
CREATE TABLE IF NOT EXISTS reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    review_text VARCHAR(1000) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    UNIQUE (customer_id, product_id)
);

-- Create table for storing employees and their salary details
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100), -- Removed UNIQUE constraint
    manager_id INT,
    date_of_joining DATE,
    city VARCHAR(100),
    salary DECIMAL(10, 2),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Insert more sample data into customers table
INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, postal_code)
VALUES
    ('Michael', 'Johnson', 'michael@example.com', '123-456-7890', '123 Main St', 'New York', 'NY', '10001'),
    ('Emily', 'Brown', 'emily@example.com', '234-567-8901', '456 Oak St', 'Los Angeles', 'CA', '90001'),
    ('William', 'Taylor', 'william@example.com', '345-678-9012', '789 Elm St', 'Chicago', 'IL', '60601'),
    ('Sophia', 'Anderson', 'sophia@example.com', '456-789-0123', '123 Pine St', 'Houston', 'TX', '77001'),
    ('James', 'Martinez', 'james@example.com', '567-890-1234', '456 Maple St', 'Phoenix', 'AZ', '85001'),
    ('Olivia', 'Lopez', 'olivia@example.com', '678-901-2345', '789 Cedar St', 'Philadelphia', 'PA', '19101'),
    ('Benjamin', 'Garcia', 'benjamin@example.com', '789-012-3456', '123 Cherry St', 'San Antonio', 'TX', '78201'),
    ('Emma', 'Wilson', 'emma@example.com', '890-123-4567', '456 Walnut St', 'San Diego', 'CA', '92101'),
    ('Alexander', 'Rodriguez', 'alexander@example.com', '901-234-5678', '789 Pine St', 'Dallas', 'TX', '75201'),
    ('Ava', 'Lee', 'ava@example.com', '012-345-6789', '123 Oak St', 'San Francisco', 'CA', '94101');


-- Insert more sample data into products table
INSERT INTO products (product_name, product_description, price, stock_quantity, category)
VALUES
    ('Smartphone', 'High-quality smartphone', 499.99, 100, 'Electronics'),
    ('Headphones', 'Noise-cancelling headphones', 199.99, 200, 'Electronics'), 
    ('Running Shoes', 'High-performance running shoes', 89.99, 50, 'Sports'), 
	('Bluetooth Speaker', 'Portable Bluetooth speaker', 149.99, 40, 'Electronics'), 
	('Yoga Mat', 'Eco-friendly yoga mat', 29.99, 120, 'Sports'), 
    ('Mouse', 'High-performance gaming mouse', 69.99, 50, 'Electronics'),
    ('Running Shorts', 'Breathable running shorts', 24.99, 150, 'Sports'), 
	('Fitness Tracker', 'Waterproof fitness tracker', 79.99, 100, 'Sports'),
    ('Coffee Maker', 'Programmable coffee maker', 49.99, 30, 'Home & Kitchen'),
    ('Backpack', 'Durable backpack for everyday use', 39.99, 80, 'Fashion'),
    ('Bedding Set', 'Soft bedding set', 99.99, 60, 'Home & Kitchen'),
    ('Sunglasses', 'Polarized sunglasses for UV protection', 59.99, 90, 'Fashion'),
    ('Mouse', 'Wireless optical mouse', 79.99, 50, 'Electronics');
    
-- Insert more sample data into orders table
INSERT INTO orders (customer_id, product_id, quantity, order_date, shipping_address, shipping_city, shipping_state, shipping_postal_code, status, delivery_date)
VALUES
    (1, 3, 1, '2023-12-15 10:00:00', '456 Pine St', 'Boston', 'MA', '02101', 'Pending', '2023-12-16 08:00:00'), 
    (2, 2, 2, '2023-12-16 11:30:00', '789 Cedar St', 'Seattle', 'WA', '98101', 'Pending', '2023-12-17 09:30:00'), 
    (3, 1, 1, '2023-12-17 12:45:00', '123 Maple St', 'Denver', 'CO', '80201', 'Pending', '2023-12-18 10:15:00'), 
    (4, 10, 3, '2023-12-18 09:15:00', '456 Oak St', 'Miami', 'FL', '33101', 'Pending', '2023-12-19 07:45:00'), 
    (1, 9, 1, '2023-12-19 08:30:00', '789 Elm St', 'Houston', 'TX', '77001', 'Pending', '2023-12-20 06:30:00'), 
    (6, 4, 50, '2023-12-20 10:20:00', '123 Cherry St', 'San Diego', 'CA', '92101', 'Pending', '2023-12-21 08:45:00'), 
    (7, 5, 1, '2023-12-21 07:40:00', '456 Walnut St', 'Phoenix', 'AZ', '85001', 'Pending', '2023-12-22 09:00:00'), 
    (8, 6, 1, '2023-12-22 11:00:00', '789 Maple St', 'Philadelphia', 'PA', '19101', 'Pending', '2023-12-23 10:30:00'), 
    (9, 7, 1, '2023-12-23 08:50:00', '123 Cedar St', 'San Antonio', 'TX', '78201', 'Pending', '2023-12-24 07:20:00'), 
    (10, 8, 2, '2023-12-24 09:10:00', '456 Pine St', 'Chicago', 'IL', '60601', 'Pending', '2023-12-25 08:15:00'),
    (1, 3, 1, '2023-12-15 10:00:00', '456 Pine St', 'Boston', 'MA', '02101', 'Pending', '2023-12-16 08:00:00'), 
    (2, 2, 2, '2023-12-16 11:30:00', '789 Cedar St', 'Seattle', 'WA', '98101', 'Pending', '2023-12-17 09:30:00'),
    (3, 1, 1, '2023-12-17 12:45:00', '123 Maple St', 'Denver', 'CO', '80201', 'Pending', '2023-12-18 10:15:00'),
    (4, 10, 3, '2023-12-18 09:15:00', '456 Oak St', 'Miami', 'FL', '33101', 'Pending', '2023-12-19 07:45:00'), 
    (5, 9, 1, '2023-12-19 08:30:00', '789 Elm St', 'Houston', 'TX', '77001', 'Pending', '2023-12-20 06:30:00');


-- Insert more sample data into reviews table
INSERT INTO reviews (customer_id, product_id, review_text, rating)
VALUES
    (4, 3, 'Great sound quality, highly recommend!', 5),
    (5, 2, 'Very pleased with the purchase.', 4),
    (6, 1, 'Excellent shoes, comfortable fit.', 5),
    (7, 10, 'Impressive performance, worth the price.', 5),
    (8, 9, 'Love this phone, sleek design.', 4),
    (9, 4, 'Easy to set up and use.', 4),
    (10, 5, 'Super soft and cozy bedding set.', 5);
    
    
-- Insert more sample data into employees table
INSERT INTO employees (full_name, manager_id, date_of_joining, city, salary)
VALUES
  ('Michael Scott', NULL, '2018-05-15', 'Scranton', 8500.00),
  ('Dwight Schrute', 1, '2019-01-20', 'Scranton', 7500.00),
  ('Jim Halpert', 1, '2019-03-10', 'Scranton', 7000.00),
  ('Pam Beesly', 1, '2019-04-25', 'Scranton', 7000.00),
  ('Angela Martin', 1, '2019-06-12', 'Scranton', 7500.00),
  ('Stanley Hudson', 1, '2019-07-30', 'Scranton', 7000.00),
  ('Kevin Malone', 1, '2019-09-15', 'Scranton', 7000.00),
  ('Oscar Martinez', 1, '2019-11-01', 'Scranton', 7500.00),
  ('Meredith Palmer', 1, '2020-01-15', 'Scranton', 7000.00),
  ('Creed Bratton', 1, '2020-03-02', 'Scranton', 7000.00),
  ('Andy Bernard', 1, '2020-05-20', 'Scranton', 7500.00),
  ('Toby Flenderson', 1, '2020-08-10', 'Scranton', 7500.00);
  
  
  -- Show data from the tables
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM reviews;
SELECT * FROM employees;