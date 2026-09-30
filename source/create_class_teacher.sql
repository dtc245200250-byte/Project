-- BAI THUC HANH: TAO BANG CLASS VA TEACHER
-- Su dung CSDL student-management theo yeu cau bai tap.

-- Chuyen sang CSDL student-management
USE student-management;

-- Tao bang Class
CREATE TABLE Class (
    id INT,
    name VARCHAR(200)
);

-- Tao bang Teacher
CREATE TABLE Teacher (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);

-- Kiem tra cac bang da tao
SHOW TABLES;

-- Kiem tra cau truc bang Class
DESCRIBE Class;

-- Kiem tra cau truc bang Teacher
DESCRIBE Teacher;