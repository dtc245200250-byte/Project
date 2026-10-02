-- BAI THUC HANH: TAO CSDL QUAN LY BAN HANG
-- Mo hinh gom: Customer, Order, Product, OrderDetail

-- 1. Tao co so du lieu
CREATE DATABASE QuanLyBanHang;

-- 2. Chon co so du lieu
USE QuanLyBanHang;

-- 3. Tao bang Customer
-- Luu tat ca khach hang da den cua hang,
-- bao gom ca khach co mua va khong mua.
CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    cName VARCHAR(25),
    cAge TINYINT
);

-- 4. Tao bang Product
-- Luu danh sach san pham va gia san pham.
CREATE TABLE Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);

-- 5. Tao bang Order
-- Moi khach hang co the co nhieu hoa don.
-- Dung backtick vi Order la tu khoa SQL.
CREATE TABLE `Order` (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT,
    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (cID) REFERENCES Customer(cID)
);

-- 6. Tao bang OrderDetail
-- Moi hoa don co nhieu mat hang.
-- Moi san pham co the xuat hien trong nhieu hoa don.
CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    PRIMARY KEY (oID, pID),
    CONSTRAINT FK_OrderDetail_Order
        FOREIGN KEY (oID) REFERENCES `Order`(oID),
    CONSTRAINT FK_OrderDetail_Product
        FOREIGN KEY (pID) REFERENCES Product(pID)
);

-- 7. Kiem tra cac bang
SHOW TABLES;

-- 8. Kiem tra cau truc cac bang
DESCRIBE Customer;
DESCRIBE Product;
DESCRIBE `Order`;
DESCRIBE OrderDetail;