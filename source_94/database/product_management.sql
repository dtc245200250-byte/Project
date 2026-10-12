CREATE DATABASE IF NOT EXISTS product_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE product_management;

CREATE TABLE IF NOT EXISTS products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  price DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  quantity INT NOT NULL DEFAULT 0,
  CONSTRAINT chk_products_price CHECK (price >= 0),
  CONSTRAINT chk_products_quantity CHECK (quantity >= 0)
);

INSERT INTO products (name, price, quantity) VALUES
('Bàn phím cơ', 850000.00, 12),
('Chuột không dây', 320000.00, 25),
('Màn hình 24 inch', 2790000.00, 7);