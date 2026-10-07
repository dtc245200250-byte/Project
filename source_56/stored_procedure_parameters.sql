-- BAI THUC HANH: STORED PROCEDURE VOI THAM SO IN, OUT, INOUT
-- CSDL: classicmodels

USE classicmodels;

-- =========================================================
-- 1. THAM SO IN
-- Tra ve thong tin khach hang theo customerNumber
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS getCusById //

CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Goi Procedure
CALL getCusById(175);

-- =========================================================
-- 2. THAM SO OUT
-- Dem so luong khach hang theo thanh pho
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomersCountByCity //

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Goi Procedure va nhan ket qua qua bien OUT
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS 'Total Customers';

-- =========================================================
-- 3. THAM SO INOUT
-- Tang gia tri cua bien theo muc increment
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS SetCounter //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Goi Procedure nhieu lan de thay doi bien INOUT
SET @counter = 1;

CALL SetCounter(@counter, 1);
SELECT @counter AS 'Counter after +1';

CALL SetCounter(@counter, 1);
SELECT @counter AS 'Counter after +1';

CALL SetCounter(@counter, 5);
SELECT @counter AS 'Counter after +5';

-- Ket qua cuoi cung: 8

-- =========================================================
-- 4. XOA CAC PROCEDURE SAU KHI THUC HANH (neu can)
-- =========================================================
-- DROP PROCEDURE IF EXISTS getCusById;
-- DROP PROCEDURE IF EXISTS GetCustomersCountByCity;
-- DROP PROCEDURE IF EXISTS SetCounter;
