-- BAI THUC HANH: SMARTFACTORY - REINDEX TOI UU
-- CSDL: smartfactory_db
-- Muc tieu: thay Fat Covering Index bang Lean Index phuc vu loc du lieu.

CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

-- =========================================================
-- 1. Tao bang SensorLogs neu chua co
-- =========================================================
CREATE TABLE IF NOT EXISTS SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20)
);

-- =========================================================
-- 2. LEGACY: Fat Covering Index
--    Chi tao khi Index cu chua ton tai.
-- =========================================================
-- CREATE INDEX idx_fat_covering
-- ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);

-- =========================================================
-- 3. Kiem tra Storage truoc khi reindex
-- =========================================================
SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db'
  AND TABLE_NAME = 'SensorLogs';

SHOW INDEX FROM SensorLogs;

-- =========================================================
-- 4. Xoa Fat Covering Index
-- =========================================================
DROP INDEX IF EXISTS idx_fat_covering ON SensorLogs;

-- =========================================================
-- 5. Tao Lean Index
--    Chi giu cac cot can cho WHERE.
-- =========================================================
CREATE INDEX idx_lean_search
ON SensorLogs(sensor_id, recorded_at);

-- =========================================================
-- 6. Kiem tra Storage sau khi reindex
-- =========================================================
SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db'
  AND TABLE_NAME = 'SensorLogs';

-- =========================================================
-- 7. EXPLAIN truy van Dashboard sau khi toi uu
-- =========================================================
EXPLAIN
SELECT
    temperature,
    humidity,
    status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20';

-- Kiem tra Index sau cung
SHOW INDEX FROM SensorLogs;
