-- BAI THUC HANH: TRUY VAN MYSQL - PHAN 02
-- CSDL: QuanLySinhVien

USE QuanLySinhVien;

-- 1. Hien thi tat ca sinh vien co ten bat dau bang ky tu 'h'
SELECT *
FROM Student
WHERE StudentName LIKE 'H%';

-- 2. Hien thi thong tin lop hoc co thoi gian bat dau vao thang 12
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;

-- 3. Hien thi thong tin mon hoc co Credit trong khoang tu 3 den 5
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;

-- 4. Thay doi ClassID cua sinh vien co ten 'Hung' thanh 2
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

-- Kiem tra sau khi cap nhat
SELECT *
FROM Student
WHERE StudentName = 'Hung';

-- 5. Hien thi StudentName, SubName, Mark
-- Sap xep diem giam dan; neu trung diem thi sap xep ten tang dan
SELECT
    S.StudentName,
    Sub.SubName,
    M.Mark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
JOIN Subject AS Sub
    ON M.SubID = Sub.SubID
ORDER BY
    M.Mark DESC,
    S.StudentName ASC;