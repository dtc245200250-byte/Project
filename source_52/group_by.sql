-- BAI THUC HANH: CAC HAM VA GROUP BY TRONG MYSQL
-- CSDL: QuanLySinhVien
-- Noi dung: COUNT, AVG, GROUP BY, HAVING va ALL

USE QuanLySinhVien;

-- =========================================================
-- 1. Hien thi so luong sinh vien o tung noi
-- =========================================================
SELECT
    Address,
    COUNT(StudentId) AS 'Số lượng học viên'
FROM Student
GROUP BY Address;

-- =========================================================
-- 2. Tinh diem trung binh cac mon hoc cua moi hoc vien
-- =========================================================
SELECT
    S.StudentId,
    S.StudentName,
    AVG(M.Mark) AS 'Điểm trung bình'
FROM Student S
JOIN Mark M
    ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;

-- =========================================================
-- 3. Hien thi hoc vien co diem trung binh cac mon > 15
-- =========================================================
SELECT
    S.StudentId,
    S.StudentName,
    AVG(M.Mark) AS 'Điểm trung bình'
FROM Student S
JOIN Mark M
    ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) > 15;

-- =========================================================
-- 4. Hien thi hoc vien co diem trung binh lon nhat
-- =========================================================
SELECT
    S.StudentId,
    S.StudentName,
    AVG(M.Mark) AS 'Điểm trung bình'
FROM Student S
JOIN Mark M
    ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) >= ALL (
    SELECT AVG(Mark)
    FROM Mark
    GROUP BY Mark.StudentId
);
