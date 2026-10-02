-- HEALTHSYNC DATABASE OPTIMIZATION
-- Muc tieu:
-- 1. Loai bo is_active va thay bang lifecycle status.
-- 2. Bo sung deposit_amount, penalty_fee, cancel_reason.
-- 3. Tao bang Prescriptions va rang buoc FK.
-- 4. Mo phong 2 kich ban nghiep vu bang INSERT/UPDATE.
-- 5. Cung cap SELECT de kiem tra tinh nhat quan giua Activity Diagram va DB.

CREATE DATABASE IF NOT EXISTS healthsync_db;
USE healthsync_db;

-- =========================================================
-- PHAN 1: TAO CAC BANG GOC
-- =========================================================

CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_appointments_patient
        FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    CONSTRAINT fk_appointments_doctor
        FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- =========================================================
-- PHAN 2: TAI CAU TRUC APPOINTMENTS
-- =========================================================

ALTER TABLE Appointments
    DROP COLUMN is_active;

ALTER TABLE Appointments
    ADD COLUMN status ENUM(
        'PENDING',
        'CONFIRMED',
        'CHECKED_IN',
        'COMPLETED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING'
    AFTER appointment_date;

ALTER TABLE Appointments
    ADD COLUMN deposit_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00
    AFTER status;

ALTER TABLE Appointments
    ADD COLUMN penalty_fee DECIMAL(12,2) NOT NULL DEFAULT 0.00
    AFTER deposit_amount;

ALTER TABLE Appointments
    ADD COLUMN cancel_reason VARCHAR(255) NULL
    AFTER penalty_fee;

ALTER TABLE Appointments
    ADD CONSTRAINT chk_appointment_penalty
    CHECK (penalty_fee >= 0 AND penalty_fee <= deposit_amount);

-- =========================================================
-- PHAN 3: TAO BANG PRESCRIPTIONS
-- Thiết kế 1-1: moi appointment chi co toi da 1 prescription.
-- UNIQUE appointment_id dam bao quan he nay.
-- =========================================================

CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    medication_details TEXT NOT NULL,
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_prescriptions_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES Appointments(appointment_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================================================
-- PHAN 4: TRIGGER BAO VE LOGIC NGHIEP VU
-- Chi cho phep them Don thuoc khi Appointment da COMPLETED.
-- =========================================================

DELIMITER $$

CREATE TRIGGER trg_prescription_only_completed
BEFORE INSERT ON Prescriptions
FOR EACH ROW
BEGIN
    DECLARE appointment_status VARCHAR(20);

    SELECT status
    INTO appointment_status
    FROM Appointments
    WHERE appointment_id = NEW.appointment_id;

    IF appointment_status <> 'COMPLETED' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Chi duoc tao don thuoc cho lich hen da COMPLETED';
    END IF;
END$$

DELIMITER ;

-- =========================================================
-- PHAN 5: DU LIEU MAU
-- =========================================================

INSERT INTO Patients (full_name, phone)
VALUES
    ('Nguyen Van An', '0901234567'),
    ('Tran Thi Binh', '0912345678');

INSERT INTO Doctors (full_name, specialty)
VALUES
    ('BS. Nguyen Minh Duc', 'Noi khoa'),
    ('BS. Le Thu Ha', 'Nhi khoa');

-- =========================================================
-- PHAN 6: KICH BAN 1 - KHAM THANH CONG
-- PENDING + coc 500000
-- -> CHECKED_IN
-- -> COMPLETED
-- -> tao Prescription
-- =========================================================

INSERT INTO Appointments (
    patient_id,
    doctor_id,
    appointment_date,
    status,
    deposit_amount,
    penalty_fee,
    cancel_reason
)
VALUES (
    1,
    1,
    '2026-10-05 08:30:00',
    'PENDING',
    500000.00,
    0.00,
    NULL
);

SET @success_appointment_id = LAST_INSERT_ID();

UPDATE Appointments
SET status = 'CONFIRMED'
WHERE appointment_id = @success_appointment_id;

UPDATE Appointments
SET status = 'CHECKED_IN'
WHERE appointment_id = @success_appointment_id;

UPDATE Appointments
SET status = 'COMPLETED'
WHERE appointment_id = @success_appointment_id;

INSERT INTO Prescriptions (
    appointment_id,
    medication_details,
    issued_date
)
VALUES (
    @success_appointment_id,
    'Paracetamol 500mg - ngay 2 lan sau an; Vitamin B - ngay 1 lan.',
    '2026-10-05 10:30:00'
);

-- =========================================================
-- PHAN 7: KICH BAN 2 - HUY VA PHAT
-- CONFIRMED + coc 300000
-- -> CANCELLED + ly do + penalty 150000
-- =========================================================

INSERT INTO Appointments (
    patient_id,
    doctor_id,
    appointment_date,
    status,
    deposit_amount,
    penalty_fee,
    cancel_reason
)
VALUES (
    2,
    2,
    '2026-10-06 14:00:00',
    'CONFIRMED',
    300000.00,
    0.00,
    NULL
);

SET @cancelled_appointment_id = LAST_INSERT_ID();

UPDATE Appointments
SET
    status = 'CANCELLED',
    cancel_reason = 'Ban viec dot xuat',
    penalty_fee = 150000.00
WHERE appointment_id = @cancelled_appointment_id;

-- =========================================================
-- PHAN 8: TRUY VAN KIEM TRA
-- =========================================================

-- Kiem tra trang thai, tien coc va phi phat
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    status,
    deposit_amount,
    penalty_fee,
    (deposit_amount - penalty_fee) AS refundable_deposit,
    cancel_reason
FROM Appointments
ORDER BY appointment_id;

-- Danh sach benh nhan da COMPLETED va chi tiet don thuoc
SELECT
    a.appointment_id,
    p.full_name AS patient_name,
    a.appointment_date,
    a.status,
    pr.prescription_id,
    pr.medication_details,
    pr.issued_date
FROM Appointments AS a
JOIN Patients AS p
    ON p.patient_id = a.patient_id
LEFT JOIN Prescriptions AS pr
    ON pr.appointment_id = a.appointment_id
WHERE a.status = 'COMPLETED'
ORDER BY a.appointment_id;

-- Kiem tra tong tien coc va tong phi phat
SELECT
    SUM(deposit_amount) AS total_deposit,
    SUM(penalty_fee) AS total_penalty,
    SUM(deposit_amount - penalty_fee) AS total_refundable
FROM Appointments;