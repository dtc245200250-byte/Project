CREATE DATABASE IF NOT EXISTS inotes_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE inotes_db;

CREATE TABLE IF NOT EXISTS note_type (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (id),
    UNIQUE KEY uq_note_type_name (name)
);

CREATE TABLE IF NOT EXISTS notes (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    type_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_notes_note_type
      FOREIGN KEY (type_id) REFERENCES note_type(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
    INDEX idx_notes_type_id (type_id),
    INDEX idx_notes_title (title)
);

INSERT INTO note_type (id, name, description) VALUES
  (1, 'Cá nhân', 'Ghi chú cho cuộc sống cá nhân'),
  (2, 'Công việc', 'Công việc, lịch họp và việc cần làm'),
  (3, 'Học tập', 'Bài học, ôn tập và tài liệu')
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  description = VALUES(description);

INSERT INTO notes (title, content, type_id)
SELECT 'Họp giao ban đầu tuần', 'Chuẩn bị nội dung, cập nhật tiến độ và các việc cần xử lý.', 2
WHERE NOT EXISTS (SELECT 1 FROM notes WHERE title = 'Họp giao ban đầu tuần');

INSERT INTO notes (title, content, type_id)
SELECT 'Ôn tập Design Pattern Servlet', 'Ôn Strategy Pattern, MVC và cách tách tầng lưu trữ.', 3
WHERE NOT EXISTS (SELECT 1 FROM notes WHERE title = 'Ôn tập Design Pattern Servlet');
