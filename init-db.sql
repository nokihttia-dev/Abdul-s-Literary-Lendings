-- Create database if not exists
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Create tables based on the SQL files found in DB1draft
-- Member table
CREATE TABLE IF NOT EXISTS member (
    member_id VARCHAR(20) PRIMARY KEY,
    citizen_id VARCHAR(13) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(10),
    email VARCHAR(100),
    member_type ENUM('member', 'non-member') DEFAULT 'non-member',
    member_start DATE,
    member_exp DATE,
    balance DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Employee/Staff table
CREATE TABLE IF NOT EXISTS employee (
    employee_id VARCHAR(20) PRIMARY KEY,
    citizen_id VARCHAR(13) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('male', 'female', 'other'),
    birthday DATE,
    phone VARCHAR(10),
    email VARCHAR(100),
    position VARCHAR(50),
    password VARCHAR(255),
    house_number VARCHAR(10),
    street VARCHAR(100),
    subdistrict VARCHAR(100),
    district VARCHAR(100),
    province VARCHAR(100),
    zipcode VARCHAR(5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Book table
CREATE TABLE IF NOT EXISTS book (
    book_id VARCHAR(20) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    type VARCHAR(50),
    image_path VARCHAR(255),
    status ENUM('available', 'rented', 'unavailable') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lending table
CREATE TABLE IF NOT EXISTS lending (
    lending_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id VARCHAR(20),
    member_id VARCHAR(20),
    employee_id VARCHAR(20),
    start_date DATE,
    return_date DATE,
    actual_return_date DATE,
    total_price DECIMAL(10,2),
    status ENUM('active', 'returned', 'overdue') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- Insert sample data
INSERT INTO employee (employee_id, citizen_id, first_name, last_name, position, email, phone) VALUES
('EMP001', '1234567890123', 'Admin', 'User', 'Manager', 'admin@library.com', '0123456789');

INSERT INTO book (book_id, title, author, category, price, type) VALUES
('BK001', 'Fairy Tail 1', 'Hiro Mashima', 'Fantasy', 60.00, 'Manga'),
('BK002', 'Fairy Tail 11', 'Hiro Mashima', 'Fantasy', 60.00, 'Manga'),
('BK003', 'Fairy Tail 27', 'Hiro Mashima', 'Fantasy', 60.00, 'Manga');

-- Create user for the application
GRANT ALL PRIVILEGES ON library_db.* TO 'library_user'@'%';
FLUSH PRIVILEGES;
