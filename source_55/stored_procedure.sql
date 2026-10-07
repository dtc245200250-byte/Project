-- BAI THUC HANH: STORED PROCEDURE TRONG MYSQL
-- CSDL: classicmodels
-- Noi dung: Tao, goi, xoa va tao lai Stored Procedure.

USE classicmodels;

-- =========================================================
-- 1. Xoa Procedure neu da ton tai
-- =========================================================
DROP PROCEDURE IF EXISTS findAllCustomers;

-- =========================================================
-- 2. Tao Stored Procedure lay tat ca khach hang
-- =========================================================
DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers;
END //

DELIMITER ;

-- =========================================================
-- 3. Goi Stored Procedure
-- =========================================================
CALL findAllCustomers();

-- =========================================================
-- 4. Xoa Procedure cu de tao lai
--    Vi MySQL khong co lenh ALTER PROCEDURE de sua than lenh
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS findAllCustomers //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = 175;
END //

DELIMITER ;

-- =========================================================
-- 5. Goi lai Procedure sau khi thay doi
-- =========================================================
CALL findAllCustomers();

-- =========================================================
-- 6. Stored Procedure co tham so
--    Thuc hanh truyen tham so vao Procedure
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS findCustomerByNumber //

CREATE PROCEDURE findCustomerByNumber(IN p_customerNumber INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = p_customerNumber;
END //

DELIMITER ;

-- Goi Procedure voi customerNumber bat ky
CALL findCustomerByNumber(175);

-- =========================================================
-- 7. Xoa Procedure tham so khi khong can dung nua
-- =========================================================
DROP PROCEDURE IF EXISTS findCustomerByNumber;
