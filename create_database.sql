-- Database creation script
CREATE DATABASE testdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE testdb;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Insert mock data
INSERT INTO users (username, password, first_name, last_name) VALUES 
('admin', 'admin123', 'Admin', 'User'),
('john', 'john123', 'John', 'Doe'),
('jane', 'jane123', 'Jane', 'Smith'),
('test', 'test123', 'Test', 'User');
