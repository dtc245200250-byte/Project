-- AUTORIDE DATABASE OPTIMIZATION
-- Nâng cấp từ Legacy Database để khớp Activity Diagram "Thuê và Trả xe".

CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- =========================================================
-- 1. LEGACY SCHEMA
-- =========================================================

CREATE TABLE Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status VARCHAR(50) DEFAULT 'BOOKED',
    CONSTRAINT FK_Rentals_Cars
        FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- =========================================================
-- 2. UPGRADE RENTALS
-- Chuyển status từ VARCHAR tự do sang ENUM.
-- Bổ sung các trường tài chính của quy trình trả xe.
-- =========================================================

ALTER TABLE Rentals
    MODIFY COLUMN status ENUM(
        'BOOKED',
        'ACTIVE',
        'COMPLETED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'BOOKED';

ALTER TABLE Rentals
    ADD COLUMN security_deposit DECIMAL(10,2) NOT NULL DEFAULT 0.00
        AFTER status;

ALTER TABLE Rentals
    ADD COLUMN late_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00
        AFTER security_deposit;

ALTER TABLE Rentals
    ADD COLUMN damage_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00
        AFTER late_fee;

ALTER TABLE Rentals
    ADD CONSTRAINT CK_Rentals_LateFee
        CHECK (late_fee >= 0);

ALTER TABLE Rentals
    ADD CONSTRAINT CK_Rentals_DamageFee
        CHECK (damage_fee >= 0);

ALTER TABLE Rentals
    ADD CONSTRAINT CK_Rentals_Refund
        CHECK (security_deposit >= late_fee + damage_fee);

-- =========================================================
-- 3. CREATE INSPECTIONS
-- Một Rental có thể có nhiều bản ghi inspection nếu hệ thống
-- cần mở rộng theo nhiều lần kiểm tra.
-- =========================================================

CREATE TABLE Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Inspections_Rentals
        FOREIGN KEY (rental_id)
        REFERENCES Rentals(rental_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================================================
-- 4. TRIGGER BẢO VỆ LOGIC NGHIỆP VỤ
-- Không cho tạo biên bản kiểm tra khi hợp đồng còn BOOKED.
-- =========================================================

DELIMITER $$

CREATE TRIGGER trg_inspection_only_after_pickup
BEFORE INSERT ON Inspections
FOR EACH ROW
BEGIN
    DECLARE rental_status VARCHAR(20);

    SELECT status
    INTO rental_status
    FROM Rentals
    WHERE rental_id = NEW.rental_id;

    IF rental_status = 'BOOKED' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Khong the kiem tra xe khi hop dong dang BOOKED';
    END IF;
END$$

DELIMITER ;

-- =========================================================
-- 5. DỮ LIỆU MẪU
-- =========================================================

INSERT INTO Cars (model_name, license_plate)
VALUES ('Toyota Camry', '30A-12345');

-- =========================================================
-- 6. KỊCH BẢN THỰC TẾ
-- Nguyen Van A thuê xe, cọc 10.000.000đ, ACTIVE.
-- Trả xe, phát hiện "Vỡ đèn pha trái".
-- Phí trễ = 0, phí hư hỏng = 2.000.000đ.
-- =========================================================

INSERT INTO Rentals (
    car_id,
    customer_name,
    rent_date,
    return_date,
    status,
    security_deposit,
    late_fee,
    damage_fee
)
VALUES (
    1,
    'Nguyen Van A',
    '2026-10-01 08:00:00',
    NULL,
    'ACTIVE',
    10000000.00,
    0.00,
    0.00
);

SET @rental_id = LAST_INSERT_ID();

INSERT INTO Inspections (
    rental_id,
    inspection_date,
    damage_description,
    inspector_name
)
VALUES (
    @rental_id,
    '2026-10-03 18:00:00',
    'Vỡ đèn pha trái',
    'Tran Van B'
);

UPDATE Rentals
SET
    return_date = '2026-10-03 18:00:00',
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = @rental_id;

-- =========================================================
-- 7. KIỂM TRA SỐ TIỀN HOÀN LẠI
-- Công thức:
-- Refund = Security Deposit - Late Fee - Damage Fee
-- Kết quả mong đợi: 8.000.000đ
-- =========================================================

SELECT
    r.rental_id,
    r.customer_name,
    r.security_deposit,
    r.late_fee,
    r.damage_fee,
    (r.security_deposit - r.late_fee - r.damage_fee) AS refund_amount,
    r.status,
    i.damage_description,
    i.inspector_name,
    i.inspection_date
FROM Rentals AS r
JOIN Inspections AS i
    ON i.rental_id = r.rental_id
WHERE r.rental_id = @rental_id;

-- Kiểm tra toàn bộ Rental
SELECT
    rental_id,
    customer_name,
    status,
    security_deposit,
    late_fee,
    damage_fee,
    (security_deposit - late_fee - damage_fee) AS refund_amount
FROM Rentals
ORDER BY rental_id;