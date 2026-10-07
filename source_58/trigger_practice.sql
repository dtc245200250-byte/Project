-- BAI THUC HANH: TRIGGER TRONG MYSQL
-- CSDL: company
-- Noi dung: Tao bang employees, tao Trigger BEFORE INSERT
-- de tu dong xac dinh department theo salary va demo.

CREATE DATABASE IF NOT EXISTS company;
USE company;

-- =========================================================
-- 1. Tao bang employees
-- =========================================================
CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- =========================================================
-- 2. Tao Trigger update_department
--    Quy tac:
--    salary >= 5000 -> Management
--    salary >= 3000 -> Sales
--    salary <  3000 -> Support
-- =========================================================
DELIMITER //

DROP TRIGGER IF EXISTS update_department //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- =========================================================
-- 3. Demo su dung Trigger
--    Gia tri department nhap vao se duoc Trigger tu dong
--    cap nhat lai theo salary.
-- =========================================================
INSERT INTO employees (name, department, salary)
VALUES
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);

-- =========================================================
-- 4. Kiem tra ket qua
-- =========================================================
SELECT *
FROM employees;

-- Ket qua department mong doi:
-- John Doe      -> Sales
-- Jane Smith    -> Support
-- David Johnson -> Management

-- =========================================================
-- 5. Hien thi thong tin Trigger
-- =========================================================
SHOW TRIGGERS FROM company;

-- =========================================================
-- 6. Xoa Trigger khi khong con su dung
-- =========================================================
-- DROP TRIGGER IF EXISTS update_department;
