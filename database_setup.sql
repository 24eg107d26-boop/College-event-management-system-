-- ====================================================================
-- College Event Management System - Database Setup Script
-- MySQL Database Creation and Schema Definition
-- ====================================================================

-- 1. Create Database if not exists
CREATE DATABASE IF NOT EXISTS `college_event_db`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `college_event_db`;

-- 2. Drop existing tables if re-creating
DROP TABLE IF EXISTS `event_registrations`;
DROP TABLE IF EXISTS `events`;
DROP TABLE IF EXISTS `users`;

-- 3. Users Table (Stores Students and Administrators)
CREATE TABLE `users` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(120) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `student_id` VARCHAR(30) DEFAULT NULL,
  `department` VARCHAR(100) DEFAULT NULL,
  `phone_number` VARCHAR(20) DEFAULT NULL,
  `role` VARCHAR(20) NOT NULL,
  `enabled` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Events Table
CREATE TABLE `events` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(150) NOT NULL,
  `description` TEXT NOT NULL,
  `category` VARCHAR(50) NOT NULL,
  `event_date` DATE NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME DEFAULT NULL,
  `venue` VARCHAR(150) NOT NULL,
  `organizer` VARCHAR(100) DEFAULT NULL,
  `capacity` INT NOT NULL DEFAULT 100,
  `registration_fee` DOUBLE NOT NULL DEFAULT 0.0,
  `image_url` VARCHAR(500) DEFAULT NULL,
  `status` VARCHAR(30) NOT NULL DEFAULT 'UPCOMING',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Event Registrations Table
CREATE TABLE `event_registrations` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `event_id` BIGINT NOT NULL,
  `registration_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(30) NOT NULL DEFAULT 'CONFIRMED',
  `remarks` VARCHAR(255) DEFAULT NULL,
  CONSTRAINT `fk_registration_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_registration_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `uk_user_event_registration` UNIQUE (`user_id`, `event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Indexes for High Performance Queries
CREATE INDEX `idx_events_date` ON `events` (`event_date`);
CREATE INDEX `idx_events_category` ON `events` (`category`);
CREATE INDEX `idx_events_status` ON `events` (`status`);
CREATE INDEX `idx_registrations_user` ON `event_registrations` (`user_id`);
CREATE INDEX `idx_registrations_event` ON `event_registrations` (`event_id`);

-- ====================================================================
-- Note: When running Spring Boot, Hibernate will automatically manage
-- these tables using `spring.jpa.hibernate.ddl-auto=update` and
-- `DataInitializer.java` will seed the default admin, sample student,
-- and 5 featured college events with BCrypt password hashes.
-- ====================================================================
