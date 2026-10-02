-- BAI THUC HANH: TAO CSDL QUAN LY DIEM THI

-- 1. Tao co so du lieu
CREATE DATABASE QuanLyDiemThi;

-- 2. Chon co so du lieu
USE QuanLyDiemThi;

-- 3. Tao bang HocSinh
CREATE TABLE HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50),
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
);

-- 4. Tao bang MonHoc
CREATE TABLE MonHoc (
    MaMH VARCHAR(50) PRIMARY KEY,
    TenMH VARCHAR(50),
    MaGV VARCHAR(20)
);

-- 5. Tao bang BangDiem
-- Bang trung gian cho moi quan he n - n giua HocSinh va MonHoc
CREATE TABLE BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(50),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

-- 6. Tao bang GiaoVien
CREATE TABLE GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50),
    SDT VARCHAR(10)
);

-- 7. Bo sung khoa ngoai MaGV cho bang MonHoc
ALTER TABLE MonHoc
ADD CONSTRAINT FK_MaGV
FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV);

-- Kiem tra cac bang
SHOW TABLES;

-- Kiem tra cau truc cac bang
DESCRIBE HocSinh;
DESCRIBE MonHoc;
DESCRIBE BangDiem;
DESCRIBE GiaoVien;