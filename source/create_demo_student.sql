-- BAI THUC HANH: TAO CSDL DEMO VA BANG STUDENT

-- Buoc 1: Tao co so du lieu demo
CREATE DATABASE demo;

-- Buoc 2: Su dung co so du lieu demo
USE demo;

-- Buoc 3: Tao bang Student
CREATE TABLE Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);

-- Kiem tra bang sau khi tao
SHOW TABLES;
DESCRIBE Student;