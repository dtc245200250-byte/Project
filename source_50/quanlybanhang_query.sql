-- BAI THUC HANH: QUAN LY BAN HANG - INSERT VA QUERY
-- CSDL: QuanLyBanHang

USE QuanLyBanHang;

-- =========================================================
-- 1. THEM DU LIEU BANG Customer
-- =========================================================

INSERT INTO Customer (cID, cName, cAge)
VALUES
    (1, 'Minh Quan', 10),
    (2, 'Ngoc Oanh', 20),
    (3, 'Hong Ha', 50);

-- =========================================================
-- 2. THEM DU LIEU BANG Order
-- =========================================================

INSERT INTO `Order` (oID, cID, oDate, oTotalPrice)
VALUES
    (1, 1, '2006-03-21 00:00:00', NULL),
    (2, 2, '2006-03-23 00:00:00', NULL),
    (3, 1, '2006-03-16 00:00:00', NULL);

-- =========================================================
-- 3. THEM DU LIEU BANG Product
-- =========================================================

INSERT INTO Product (pID, pName, pPrice)
VALUES
    (1, 'May Giat', 3),
    (2, 'Tu Lanh', 5),
    (3, 'Dieu Hoa', 7),
    (4, 'Quat', 1),
    (5, 'Bep Dien', 2);

-- =========================================================
-- 4. THEM DU LIEU BANG OrderDetail
-- =========================================================
-- Du lieu theo mo ta: don 1 mua SP 1,3,4;
-- don 2 mua SP 1,3,5;
-- don 3 mua SP 2.
-- Dong cuoi duoc trinh bay trong de theo dang roi rac;
-- phieu hop ly voi khoa kep (oID, pID) la (3,2,3).

INSERT INTO OrderDetail (oID, pID, odQTY)
VALUES
    (1, 1, 3),
    (1, 3, 7),
    (1, 4, 2),
    (2, 1, 1),
    (2, 3, 1),
    (2, 5, 4),
    (3, 2, 3);

-- =========================================================
-- 5. HIEN THI oID, oDate, oTotalPrice CUA TAT CA HOA DON
-- =========================================================

SELECT
    oID,
    oDate,
    oTotalPrice
FROM `Order`
ORDER BY oID;

-- =========================================================
-- 6. HIEN THI KHACH HANG DA MUA HANG
-- VA DANH SACH SAN PHAM DUOC MUA
-- =========================================================

SELECT DISTINCT
    c.cID,
    c.cName,
    p.pID,
    p.pName
FROM Customer AS c
JOIN `Order` AS o
    ON c.cID = o.cID
JOIN OrderDetail AS od
    ON o.oID = od.oID
JOIN Product AS p
    ON od.pID = p.pID
ORDER BY c.cID, p.pID;

-- =========================================================
-- 7. HIEN THI KHACH HANG CHUA MUA BAT KY SAN PHAM NAO
-- =========================================================

SELECT
    c.cID,
    c.cName,
    c.cAge
FROM Customer AS c
LEFT JOIN `Order` AS o
    ON c.cID = o.cID
WHERE o.oID IS NULL
ORDER BY c.cID;

-- =========================================================
-- 8. TINH GIA CUA TUNG HOA DON
-- Cong thuc:
-- Gia hoa don = SUM(odQTY * pPrice)
-- =========================================================

SELECT
    o.oID,
    o.oDate,
    SUM(od.odQTY * p.pPrice) AS oPrice
FROM `Order` AS o
JOIN OrderDetail AS od
    ON o.oID = od.oID
JOIN Product AS p
    ON od.pID = p.pID
GROUP BY
    o.oID,
    o.oDate
ORDER BY o.oID;

-- Ket qua voi du lieu tren:
-- Hoa don 1: 58
-- Hoa don 2: 18
-- Hoa don 3: 15

-- =========================================================
-- 9. HIEN THI HOA DON KEM CHI TIET VA THANH TIEN
-- =========================================================

SELECT
    o.oID,
    o.oDate,
    p.pName,
    od.odQTY,
    p.pPrice,
    (od.odQTY * p.pPrice) AS line_total
FROM `Order` AS o
JOIN OrderDetail AS od
    ON o.oID = od.oID
JOIN Product AS p
    ON od.pID = p.pID
ORDER BY o.oID, p.pID;