-- BAI THUC HANH: QUICKFEED - INDEX OPTIMIZATION
-- CSDL: quickfeed_db
-- Muc tieu:
-- 1. Do luong Data Length va Index Length.
-- 2. Loai bo 3 Index co gia tri thap.
-- 3. Giu lai idx_user_id va idx_created_at.
-- 4. So sanh Storage truoc va sau khi toi uu.

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

-- =========================================================
-- 1. KIEM TRA STORAGE TRUOC KHI TOI UU
-- =========================================================

SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- Xem danh sach Index hien tai
SHOW INDEX FROM Posts;

-- =========================================================
-- 2. CHAN DOAN 5 INDEX
--    GIU LAI:
--      idx_user_id
--      idx_created_at
--
--    XOA:
--      idx_content
--      idx_post_type
--      idx_is_visible
-- =========================================================

-- Index tren TEXT(content(255)): ton dung luong va chi phi
-- bao tri; neu can tim kiem noi dung nen can nhac FULLTEXT.
ALTER TABLE Posts DROP INDEX idx_content;

-- post_type chi co khoang 3 gia tri -> cardinality thap.
ALTER TABLE Posts DROP INDEX idx_post_type;

-- is_visible chi co 0/1 -> cardinality rat thap.
ALTER TABLE Posts DROP INDEX idx_is_visible;

-- =========================================================
-- 3. KIEM TRA LAI SAU KHI DROP INDEX
-- =========================================================

SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- Kiem tra lai cac Index duoc giu lai
SHOW INDEX FROM Posts;

-- =========================================================
-- 4. KIEM TRA TIEP CAC INDEX CON LAI
-- =========================================================
SELECT
    INDEX_NAME,
    COLUMN_NAME,
    CARDINALITY
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts'
ORDER BY INDEX_NAME, SEQ_IN_INDEX;

-- =========================================================
-- GHI CHU
-- =========================================================
-- Truy van content dang TEXT khong nen dung B-Tree prefix index
-- chi de tim kiem tu khoa. Neu can full-text search, co the
-- can nhac:
--
-- CREATE FULLTEXT INDEX idx_content_fulltext ON Posts(content);
--
-- Tuy nhien FULLTEXT chi nen tao khi ung dung thuc su co nhu cau
-- tim kiem van ban.
