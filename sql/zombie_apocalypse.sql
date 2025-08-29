DROP DATABASE IF EXISTS `Zombie_Apocalypse`;
CREATE DATABASE `Zombie_Apocalypse`;
USE `Zombie_Apocalypse`;

-- Table to store survivor information
CREATE TABLE survivors (
    survivor_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    full_name VARCHAR(100),
    survivor_age INT NOT NULL,
    health_status_id INT NOT NULL,
    PRIMARY KEY (survivor_id),
    FOREIGN KEY (health_status_id) REFERENCES health_status (health_status_id)
);

-- Table to store different health statuses
CREATE TABLE health_status (
    health_status_id INT NOT NULL,
    health_status_text VARCHAR(50) NOT NULL,
    PRIMARY KEY (health_status_id)
);

-- Table to store safehouse information
CREATE TABLE safehouses (
    safehouse_id INT NOT NULL,
    safehouse_name VARCHAR(50),
    city_name VARCHAR(50),
    state_name VARCHAR(50),
    zombie_count INT,
    survivor_id INT,
    PRIMARY KEY (safehouse_id),
    FOREIGN KEY (survivor_id) REFERENCES survivors (survivor_id)
);

-- Table to store food supplies
CREATE TABLE foods (
    food_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    food_name VARCHAR(50),
    food_quantity INT NOT NULL,
    expiration_date DATE,
    PRIMARY KEY (food_id),
    FOREIGN KEY (safehouse_id) REFERENCES safehouses (safehouse_id)
);

-- Table to store drink supplies
CREATE TABLE drinks (
    drink_id INT NOT NULL,
    drink_name VARCHAR(50),
    drink_quantity INT NOT NULL,
    PRIMARY KEY (drink_id)
);

-- Table to store weapon supplies
CREATE TABLE weapons (
    weapon_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    weapon_name VARCHAR(50),
    weapon_durability DECIMAL(5,2),
    weapon_quantity INT NOT NULL,
    PRIMARY KEY (weapon_id),
    FOREIGN KEY (safehouse_id) REFERENCES safehouses (safehouse_id)
);

-- Table to store ammo supplies
CREATE TABLE ammo (
    ammo_id INT NOT NULL,
    ammo_type VARCHAR(50),
    ammo_quantity INT NOT NULL,
    PRIMARY KEY (ammo_id)
);

-- Table to store event types
CREATE TABLE event_types (
    event_type_id INT NOT NULL,
    event_type_name VARCHAR(50),
    PRIMARY KEY (event_type_id)
);

-- Table to store event severity levels
CREATE TABLE event_severitys (
    event_severity_id INT NOT NULL,
    event_severity_text VARCHAR(50),
    PRIMARY KEY (event_severity_id)
);

-- Table to log world events
CREATE TABLE world_event (
    event_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    event_type_id INT NOT NULL,
    event_date DATE,
    event_severity_id INT NOT NULL,
    PRIMARY KEY (event_id),
    FOREIGN KEY (safehouse_id) REFERENCES safehouses (safehouse_id),
    FOREIGN KEY (event_type_id) REFERENCES event_types (event_type_id),
    FOREIGN KEY (event_severity_id) REFERENCES event_severitys (event_severity_id)
);

-- Table to track resource usage, now including weapon information
CREATE TABLE resource_usage (
    usage_id INT NOT NULL,
    survivor_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    usage_date DATE,
    food_id INT,
    food_quantity INT,
    drink_id INT,
    drink_quantity INT,
    ammo_id INT,
    ammo_quantity INT,
    weapon_id INT,
    weapon_durability_loss DECIMAL(5,2),
    PRIMARY KEY (usage_id),
    FOREIGN KEY (survivor_id) REFERENCES survivors (survivor_id),
    FOREIGN KEY (safehouse_id) REFERENCES safehouses (safehouse_id),
    FOREIGN KEY (food_id) REFERENCES foods (food_id),
    FOREIGN KEY (drink_id) REFERENCES drinks (drink_id),
    FOREIGN KEY (ammo_id) REFERENCES ammo (ammo_id),
    FOREIGN KEY (weapon_id) REFERENCES weapons (weapon_id)
);

-- Data Inserts with Updated Ammo IDs

-- Insert data into health_status
INSERT INTO health_status (health_status_id, health_status_text) VALUES
(1, 'Healthy'),
(2, 'Stable'),
(3, 'Injured'),
(4, 'Sick'),
(5, 'Deceased');

-- Insert data into event_types
INSERT INTO event_types (event_type_id, event_type_name) VALUES
(1, 'Supply Drop'),
(2, 'Weapon Found'),
(3, 'Survivor Rescued'),
(4, 'Safehouse Breached'),
(5, 'Zombie Attack'),
(6, 'Natural Disaster'),
(7, 'Resource Scavenged');

-- Insert data into event_severitys
INSERT INTO event_severitys (event_severity_id, event_severity_text) VALUES
(1, 'Critical'),
(2, 'High'),
(3, 'Medium'),
(4, 'Low'),
(5, 'Informational');

-- Insert data into survivors
INSERT INTO survivors (survivor_id, first_name, last_name, full_name, survivor_age, health_status_id) VALUES
(1, 'Olivia', 'Harper', 'Olivia Harper', 20, 1),
(2, 'Mason', 'Cole', 'Mason Cole', 25, 1),
(3, 'Sophia', 'Ramirez', 'Sophia Ramirez', 65, 3),
(4, 'Liam', 'Bennett', 'Liam Bennett', 40, 2),
(5, 'Ava', 'Montgomery', 'Ava Montgomery', 26, 4),
(6, 'Noah', 'Caldwell', 'Noah Caldwell', 68, 5),
(7, 'Isabella', 'Cruz', 'Isabella Cruz', 4, 2),
(8, 'Ethan', 'Cruz', 'Ethan Cruz', 21, 1),
(9, 'Mia', 'Cruz', 'Mia Cruz', 22, 2),
(10, 'Lucas', 'Harrington', 'Lucas Harrington', 52, 3),
(11, 'Grace', 'Chen', 'Grace Chen', 31, 1),
(12, 'Jackson', 'Patel', 'Jackson Patel',
