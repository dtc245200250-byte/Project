-- BAI THUC HANH: GROUP BY - CAU TRUY VAN TONG HOP
-- CSDL: QuanLySinhVien
-- Noi dung: MAX, AVG, JOIN, GROUP BY va ORDER BY

USE QuanLySinhVien;

-- =========================================================
-- 1. Hien thi tat ca thong tin mon hoc co credit lon nhat
-- =========================================================
SELECT *
FROM Subject
WHERE Credit = (
    SELECT MAX(Credit)
    FROM Subject
);

-- =========================================================
-- 2. Hien thi cac thong tin mon hoc co diem thi lon nhat
-- =========================================================
SELECT DISTINCT
    S.*
FROM Subject S
JOIN Mark M
    ON S.SubjectId = M.SubjectId
WHERE M.Mark = (
    SELECT MAX(Mark)
    FROM Mark
);

-- =========================================================
-- 3. Hien thi thong tin sinh vien va diem trung binh,
--    sap xep theo diem trung binh giam dan
-- =========================================================
SELECT
    S.StudentId,
    S.StudentName,
    AVG(M.Mark) AS 'Điểm trung bình'
FROM Student S
JOIN Mark M
    ON S.StudentId = M.StudentId
GROUP BY
    S.StudentId,
    S.StudentName
ORDER BY AVG(M.Mark) DESC;
