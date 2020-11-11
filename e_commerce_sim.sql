CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    email VARCHAR(55)
);

CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    price NUMERIC
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id)
);

INSERT INTO users (name, email)
VALUES ('cool', 'cool@gmail.com'),
('cool2', 'cool2@gmail.com'),
('cool3', 'cool3@gmail.com');

INSERT INTO products (name, price)
VALUES ('product1', 99.99),
('product2', 10.99),
('product3', 1);

INSERT INTO orders (product_id)
VALUES (1), (2), (3);

-- Queries 

--get all products for the first order
SELECT * FROM products 
WHERE product_id = 1;

--get all orders
SELECT * FROM products p
JOIN orders o ON o.product_id = p.product_id;

--Get the total cost of an order
SELECT SUM(p.price) AS cost FROM products p
JOIN orders o ON o.product_id = p.product_id
WHERE o.product_id = 2;


-- Add a foreign key to the reference from orders to users
ALTER TABLE orders
ADD COLUMN user_id INT REFERENCES users(user_id);

-- update the orders table to link a user to each order
UPDATE orders
SET user_id = 1
WHERE order_id = 1;

UPDATE orders
SET user_id = 2
WHERE order_id = 2;

UPDATE orders
SET user_id = 3
WHERE order_id = 3;

-- Number of orders for a user
SELECT o.order_id, u.name FROM users u
JOIN orders o ON o.user_id = u.user_id
WHERE u.user_id = 2

-- Number of orders each user has
SELECT COUNT(p.name), u.name FROM users u
JOIN orders o ON o.user_id = u.user_id
JOIN products p ON p.product_id = o.product_id
GROUP BY u.name;

--Black Diamond
--Sum of orders for each user
SELECT SUM(p.price), u.name FROM users u
JOIN orders o ON o.user_id = u.user_id
JOIN products p ON p.product_id = o.product_id
GROUP BY u.name;