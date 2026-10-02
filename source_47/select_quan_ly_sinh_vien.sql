-- BAI THUC HANH: SELECT - QUAN LY SINH VIEN

-- 1. Chon co so du lieu
USE QuanLySinhVien;

-- 2. Hien thi danh sach tat ca hoc vien
SELECT *
FROM Student;

-- 3. Hien thi danh sach hoc vien dang theo hoc
SELECT *
FROM Student
WHERE Status = TRUE;

-- 4. Hien thi danh sach mon hoc co thoi gian hoc nho hon 10 gio
SELECT *
FROM Subject
WHERE Credit < 10;

-- 5. Hien thi danh sach hoc vien lop A1
SELECT
    S.StudentID,
    S.StudentName,
    C.ClassName
FROM Student AS S
JOIN Class AS C
    ON S.ClassID = C.ClassID
WHERE C.ClassName = 'A1';

-- 6. Hien thi tat ca diem hien co cua hoc vien
SELECT
    S.StudentID,
    S.StudentName,
    Sub.SubName,
    M.Mark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
JOIN Subject AS Sub
    ON M.SubID = Sub.SubID;

-- 7. Hien thi diem mon CF cua cac hoc vien
SELECT
    S.StudentID,
    S.StudentName,
    Sub.SubName,
    M.Mark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
JOIN Subject AS Sub
    ON M.SubID = Sub.SubID
WHERE Sub.SubName = 'CF';