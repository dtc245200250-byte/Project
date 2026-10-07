-- BAI THUC HANH: VIEW TRONG MYSQL
-- CSDL: classicmodels
-- Noi dung: Tao, truy van, cap nhat va xoa View.

USE classicmodels;

-- =========================================================
-- 1. Tao View customer_views
-- =========================================================
DROP VIEW IF EXISTS customer_views;

CREATE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    phone
FROM customers;

-- Kiem tra du lieu tu View
SELECT *
FROM customer_views;

-- =========================================================
-- 2. Cap nhat View customer_views
--    Bo sung contactFirstName, contactLastName
--    va loc khach hang o thanh pho Nantes
-- =========================================================
CREATE OR REPLACE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    contactFirstName,
    contactLastName,
    phone
FROM customers
WHERE city = 'Nantes';

-- Kiem tra View sau khi cap nhat
SELECT *
FROM customer_views;

-- =========================================================
-- 3. Xoa View khi khong con su dung
-- =========================================================
DROP VIEW IF EXISTS customer_views;
