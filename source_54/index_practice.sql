-- BAI THUC HANH: TAO CHI MUC TRONG MYSQL
-- CSDL: classicmodels
-- Muc tieu: So sanh EXPLAIN truoc va sau khi tao INDEX.

USE classicmodels;

-- =========================================================
-- 1. Kiem tra truy van truoc khi tao INDEX
-- =========================================================
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- =========================================================
-- 2. Tao INDEX cho customerName
-- =========================================================
ALTER TABLE customers
ADD INDEX idx_customerName(customerName);

-- =========================================================
-- 3. Kiem tra lai sau khi tao INDEX
-- =========================================================
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- =========================================================
-- 4. Tao Composite INDEX cho contactFirstName,
--    contactLastName
-- =========================================================
ALTER TABLE customers
ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- Kiem tra truy van su dung Composite INDEX
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactFirstName = 'King';

-- =========================================================
-- 5. Xoa Composite INDEX
-- =========================================================
ALTER TABLE customers
DROP INDEX idx_full_name;

-- Neu can xoa INDEX customerName sau khi kiem tra:
-- ALTER TABLE customers DROP INDEX idx_customerName;

-- =========================================================
-- 6. Xem danh sach INDEX hien tai cua bang
-- =========================================================
SHOW INDEX FROM customers;
