-- BAI THUC HANH: VIEW, INDEX, STORED PROCEDURE
-- CSDL demo quan ly san pham

CREATE DATABASE IF NOT EXISTS product_management;
USE product_management;

-- =========================================================
-- BUOC 2: TAO BANG Products
-- =========================================================
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(15,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription VARCHAR(255),
    productStatus VARCHAR(50)
);

-- Du lieu mau
INSERT INTO Products
    (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
    ('P001', 'Laptop Dell', 15000000, 10, 'Laptop van phong', 'Available'),
    ('P002', 'Laptop HP', 14000000, 8, 'Laptop hoc tap', 'Available'),
    ('P003', 'MacBook Air', 22000000, 5, 'Laptop Apple', 'Available'),
    ('P004', 'iPhone 15', 18000000, 15, 'Dien thoai Apple', 'Available'),
    ('P005', 'Samsung S24', 17000000, 12, 'Dien thoai Samsung', 'Available'),
    ('P006', 'iPad Air', 15000000, 7, 'May tinh bang Apple', 'Out of stock');

-- =========================================================
-- BUOC 3: KIEM TRA TRUY VAN TRUOC KHI TAO INDEX
-- =========================================================

-- Truy van theo productCode truoc khi co Unique Index
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P001';

-- Truy van theo productName va productPrice truoc Composite Index
EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Dell'
  AND productPrice = 15000000;

-- =========================================================
-- TAO UNIQUE INDEX tren productCode
-- =========================================================
CREATE UNIQUE INDEX idx_product_code
ON Products(productCode);

-- TAO COMPOSITE INDEX tren productName, productPrice
-- =========================================================
CREATE INDEX idx_product_name_price
ON Products(productName, productPrice);

-- =========================================================
-- EXPLAIN SAU KHI TAO INDEX
-- =========================================================

-- Query theo productCode
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P001';

-- Query theo productName va productPrice
EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Dell'
  AND productPrice = 15000000;

-- Kiem tra danh sach Index
SHOW INDEX FROM Products;

-- =========================================================
-- BUOC 4: TAO VIEW
-- =========================================================
DROP VIEW IF EXISTS product_views;

CREATE VIEW product_views AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus
FROM Products;

-- Doc du lieu tu View
SELECT *
FROM product_views;

-- =========================================================
-- SUA VIEW
-- Bo sung productAmount vao View
-- =========================================================
CREATE OR REPLACE VIEW product_views AS
SELECT
    productCode,
    productName,
    productPrice,
    productAmount,
    productStatus
FROM Products;

-- Kiem tra View sau khi sua
SELECT *
FROM product_views;

-- =========================================================
-- XOA VIEW
-- =========================================================
DROP VIEW IF EXISTS product_views;

-- =========================================================
-- BUOC 5: STORED PROCEDURE
-- =========================================================

-- 1. Lay tat ca san pham
DELIMITER //

DROP PROCEDURE IF EXISTS GetAllProducts //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT *
    FROM Products;
END //

DELIMITER ;

-- Goi Procedure
CALL GetAllProducts();

-- =========================================================
-- 2. Them san pham moi
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS AddProduct //

CREATE PROCEDURE AddProduct(
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(15,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(50)
)
BEGIN
    INSERT INTO Products
        (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES
        (p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus);
END //

DELIMITER ;

-- Vi du goi Procedure AddProduct
CALL AddProduct(
    'P007',
    'Tai nghe Bluetooth',
    1200000,
    20,
    'Tai nghe khong day',
    'Available'
);

-- =========================================================
-- 3. Sua san pham theo Id
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS UpdateProduct //

CREATE PROCEDURE UpdateProduct(
    IN p_Id INT,
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(15,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_Id;
END //

DELIMITER ;

-- Vi du sua san pham co Id = 1
CALL UpdateProduct(
    1,
    'P001',
    'Laptop Dell Updated',
    15500000,
    12,
    'Laptop Dell da cap nhat',
    'Available'
);

-- =========================================================
-- 4. Xoa san pham theo Id
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS DeleteProduct //

CREATE PROCEDURE DeleteProduct(IN p_Id INT)
BEGIN
    DELETE FROM Products
    WHERE Id = p_Id;
END //

DELIMITER ;

-- Vi du xoa san pham co Id = 7
CALL DeleteProduct(7);

-- =========================================================
-- KIEM TRA DU LIEU SAU CUNG
-- =========================================================
SELECT *
FROM Products;
