CREATE DATABASE IF NOT EXISTS demo
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE demo;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120),
    PRIMARY KEY (id)
);

INSERT INTO users (name, email, country)
SELECT 'Minh', 'minh@codegym.vn', 'Viet Nam'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'minh@codegym.vn'
);

INSERT INTO users (name, email, country)
SELECT 'Kante', 'kante@che.uk', 'Kenia'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'kante@che.uk'
);


-- Permission catalog used by the JDBC transaction exercise.
CREATE TABLE IF NOT EXISTS permission (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- Each assignment links one user to one permission.
CREATE TABLE IF NOT EXISTS user_permission (
    user_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (user_id, permission_id),
    CONSTRAINT fk_user_permission_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_user_permission_permission
        FOREIGN KEY (permission_id) REFERENCES permission(id)
) ENGINE=InnoDB;

INSERT INTO permission (id, name) VALUES
    (1, 'add'),
    (2, 'edit'),
    (3, 'delete'),
    (4, 'view')
ON DUPLICATE KEY UPDATE name = VALUES(name);
