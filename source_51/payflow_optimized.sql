-- PAYFLOW DATABASE PERFORMANCE PRACTICE
-- Muc tieu: bien truy van Non-SARGable thanh truy van SARGable
-- va su dung Composite B-Tree Index.

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

-- =========================================================
-- 1. LEGACY TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);

-- =========================================================
-- 2. TRUY VAN CU - NON-SARGABLE
-- Ham YEAR() va MONTH() duoc ap dung truc tiep len created_at.
-- Lệnh EXPLAIN nay dung de quan sat execution plan.
-- =========================================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- =========================================================
-- 3. TAO COMPOSITE INDEX
-- Cot transaction_type dung de loc loai giao dich,
-- created_at dung de loc khoang thoi gian.
-- =========================================================

CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);

-- =========================================================
-- 4. TRUY VAN MOI - SARGABLE RANGE
-- Khong boc ham YEAR()/MONTH() quanh created_at.
-- Dung >= dau thang va < dau thang tiep theo.
-- =========================================================

EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';

-- =========================================================
-- 5. CHAY TRUY VAN TOI UU
-- =========================================================

SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';

-- =========================================================
-- 6. KIEM TRA INDEX
-- =========================================================

SHOW INDEX FROM Transactions;

-- =========================================================
-- 7. GHI CHU KIEM TRA PERFORMANCE
-- =========================================================
-- Co the dung EXPLAIN ANALYZE tren phien ban MySQL ho tro de xem
-- execution timing thuc te.
--
-- Ket qua EXPLAIN cu the (type, rows, key) phu thuoc vao du lieu,
-- thong ke index va phien ban MySQL; can chay EXPLAIN tren moi truong
-- MySQL thuc te de ghi nhan so lieu thuc te.