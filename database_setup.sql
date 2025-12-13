-- Hospital Management System Database Setup Script
-- Run this script in your TiDB Cloud SQL Editor

-- Create database (if you have permission)
-- If 'hospital_management_system' database doesn't exist, create it first
CREATE DATABASE IF NOT EXISTS hospital_management_system;

-- Use the database
USE hospital_management_system;

-- Table: specialist - Stores doctor specializations
CREATE TABLE IF NOT EXISTS specialist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    spec_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: doctor - Stores doctor information
CREATE TABLE IF NOT EXISTS doctor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob VARCHAR(50),
    qualification VARCHAR(200),
    specialist VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    mobno VARCHAR(20),
    password VARCHAR(100) NOT NULL,
    photo VARCHAR(255) DEFAULT 'default.jpg',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: user_dtls - Stores patient information
CREATE TABLE IF NOT EXISTS user_dtls (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    photo VARCHAR(255) DEFAULT 'default.jpg',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: appointment - Stores appointment information
CREATE TABLE IF NOT EXISTS appointment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    age VARCHAR(10),
    appoint_date VARCHAR(50),
    email VARCHAR(100),
    phno VARCHAR(20),
    diseases VARCHAR(500),
    doctor_id INT NOT NULL,
    address VARCHAR(500),
    status VARCHAR(50) DEFAULT 'Pending',
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_dtls(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctor(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert some default specialists
INSERT INTO specialist (spec_name) VALUES 
('Cardiologist'),
('Dermatologist'),
('Neurologist'),
('Orthopedic'),
('Pediatrician'),
('Gynecologist'),
('ENT Specialist'),
('General Physician')
ON DUPLICATE KEY UPDATE spec_name=spec_name;

-- Insert a default admin doctor (optional)
-- Password: admin123 (change this after first login)
INSERT INTO doctor (full_name, dob, qualification, specialist, email, mobno, password, photo) 
VALUES ('Dr. Admin', '1980-01-01', 'MBBS, MD', 'General Physician', 'admin.doctor@hospital.com', '1234567890', 'admin123', 'default.jpg')
ON DUPLICATE KEY UPDATE email=email;

-- Show tables to verify
SHOW TABLES;

-- Show table structures
DESCRIBE specialist;
DESCRIBE doctor;
DESCRIBE user_dtls;
DESCRIBE appointment;

SELECT 'Database setup completed successfully!' AS Status;
