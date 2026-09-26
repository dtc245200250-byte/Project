-- BAI THUC HANH: XOA CO SO DU LIEU MYSQL

-- =========================================================
-- CACH 1: XOA BANG MYSQL WORKBENCH
-- =========================================================
-- 1. Mo MySQL Workbench va dang nhap.
-- 2. Trong khu vuc SCHEMAS, chon database can xoa.
-- 3. Click chuot phai vao database -> Drop Schema.
-- 4. Chon Drop Now de xac nhan.
-- 5. Kiem tra Action Output de xac nhan thao tac thanh cong.

-- =========================================================
-- CACH 2: XOA BANG CAU LENH SQL
-- =========================================================

-- Kiem tra database truoc khi xoa
SHOW DATABASES;

-- LENH CHINH CUA BAI
DROP DATABASE `my_database`;

-- Kiem tra lai sau khi xoa
SHOW DATABASES;

-- LUU Y:
-- DROP DATABASE se xoa toan bo bang va du lieu trong database.
-- Hay dam bao ten database can xoa la dung va da sao luu du lieu neu can.
