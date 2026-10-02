-- FLASHMART JOIN PRACTICE

CREATE DATABASE IF NOT EXISTS flashmart_db;
USE flashmart_db;

-- =========================================================
-- 1. TAO BANG VA DU LIEU MAU
-- =========================================================

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_id, name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie');

INSERT INTO Products (product_id, product_name)
VALUES
    (101, 'Laptop'),
    (102, 'Mouse'),
    (103, 'Keyboard');

INSERT INTO Orders (order_id, customer_id, product_id)
VALUES
    (1001, 1, 101),
    (1002, 1, 102),
    (1003, 2, 101);

-- =========================================================
-- 2. BAO CAO MARKETING
-- LEFT JOIN de giu lai tat ca Customers,
-- ke ca khach hang chua tung mua hang.
-- COUNT(o.order_id) cho Charlie ket qua 0.
-- =========================================================

SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name
ORDER BY
    c.customer_id;

-- Ket qua mong doi:
-- Alice   2
-- Bob     1
-- Charlie 0

-- =========================================================
-- 3. BAO CAO KHO VAN - ANTI JOIN
-- LEFT JOIN Products sang Orders,
-- sau do loc Orders khong co ket qua bang IS NULL.
-- =========================================================

SELECT
    p.product_id,
    p.product_name
FROM Products AS p
LEFT JOIN Orders AS o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL
ORDER BY p.product_id;

-- Ket qua mong doi:
-- 103 | Keyboard

-- =========================================================
-- 4. TRUY VAN DOI CHIEU DU LIEU
-- =========================================================

SELECT
    COUNT(*) AS total_customers
FROM Customers;

SELECT
    COUNT(*) AS total_products
FROM Products;

SELECT
    COUNT(*) AS total_orders
FROM Orders;