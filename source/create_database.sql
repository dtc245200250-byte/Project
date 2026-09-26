-- Bài thực hành: Tạo CSDL MySQL bằng MySQL Workbench
-- Có thể thực hiện theo giao diện Workbench hoặc chạy các câu lệnh SQL bên dưới.

-- =========================================================
-- CÁCH 1: TẠO CSDL BẰNG GIAO DIỆN MYSQL WORKBENCH
-- =========================================================
-- 1. Mở MySQL Workbench và đăng nhập vào MySQL Server.
-- 2. Trong khu vực SCHEMAS, tạo một schema/database mới.
-- 3. Nhập tên CSDL, ví dụ: my_database1.
-- 4. Nhấn Apply -> Apply để xác nhận.
--
-- Kết quả: CSDL my_database1 được tạo trong danh sách SCHEMAS.

-- =========================================================
-- CÁCH 2: TẠO CSDL BẰNG CÂU LỆNH SQL
-- =========================================================

CREATE DATABASE IF NOT EXISTS my_database1;

-- Kiểm tra các CSDL hiện có
SHOW DATABASES;

-- Chọn CSDL vừa tạo
USE my_database1;

-- Kiểm tra CSDL hiện tại
SELECT DATABASE();

-- =========================================================
-- CÂU LỆNH CƠ BẢN CÓ THỂ DÙNG TRỰC TIẾP
-- =========================================================
-- Nếu muốn đúng theo ví dụ của bài:
-- CREATE DATABASE my_database1;

-- Sau khi tạo thành công, có thể làm mới SCHEMAS trong
-- MySQL Workbench để nhìn thấy my_database1.
