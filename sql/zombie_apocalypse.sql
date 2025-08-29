DROP DATABASE IF EXISTS Zombie_Apocalypse;
CREATE DATABASE Zombie_Apocalypse;
USE Zombie_Apocalypse;

-- Table to store different health statuses
CREATE TABLE health_status (
    health_status_id INT NOT NULL,
    health_status_text VARCHAR(50) NOT NULL,
    PRIMARY KEY (health_status_id)
);

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

---

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
(12, 'Jackson', 'Patel', 'Jackson Patel', 45, 2),
(13, 'Zoe', 'Rodriguez', 'Zoe Rodriguez', 19, 1),
(14, 'Carter', 'White', 'Carter White', 55, 3),
(15, 'Chloe', 'Davis', 'Chloe Davis', 38, 4);

-- Insert data into safehouses
INSERT INTO safehouses (safehouse_id, safehouse_name, city_name, state_name, zombie_count, survivor_id) VALUES
(1, 'The Coast', 'Rockport', 'Massachusetts', 5000, 1),
(2, 'The Farm', 'Champaign', 'Illinois', 1500, 2),
(3,'The Forest', 'Portland', 'Oregon', 750, 3),
(4, 'The Golf Course', 'Augusta', 'Georgia', 1250, 4),
(5, 'The Large City', 'Chicago', 'Illinois', 50000, 5),
(6, 'The Mall', 'Minneapolis', 'Minnesota', 30000, 6),
(7, 'The Military Base', 'Phoenix', 'Arizona', 7500, 7),
(8, 'The Small Town', 'Devils Lake', 'North Dakota', 2500, 8),
(9, 'The Suburbs', 'Carmel', 'Indiana', 10000, 9),
(10, 'The Theme Park', 'Sandusky', 'Ohio', 17500, 10);

-- Insert data into foods
INSERT INTO foods (food_id, safehouse_id, food_name, food_quantity, expiration_date) VALUES
(1, 1, 'Canned Beans', 20, '2030-01-15'),
(2, 1, 'Cereal Boxes', 12, '2026-05-20'),
(3, 2, 'Dried Rice', 50, NULL),
(4, 2, 'Canned Tuna', 15, '2028-11-10'),
(5, 3, 'Protein Bars', 30, '2027-03-05'),
(6, 3, 'Salt', 5, NULL),
(7, 4, 'Bottled Water', 100, NULL),
(8, 5, 'Crackers', 25, '2026-08-01'),
(9, 6, 'Granola Bars', 40, '2027-06-25'),
(10, 7, 'Beef Jerky', 18, '2028-09-30'),
(11, 8, 'Flour', 10, NULL),
(12, 9, 'Sugar', 8, NULL);

-- Insert data into drinks
INSERT INTO drinks (drink_id, drink_name, drink_quantity) VALUES
(1, 'Water Gallons', 25),
(2, 'Pop Cans', 8),
(3, 'Powdered Milk', 2),
(4, 'Energy Drinks', 12),
(5, 'Instant Tea', 4),
(6, 'Coffee Bags', 3),
(7, 'Juice Boxes', 15),
(8, 'Sports Drinks', 10);

-- Insert data into weapons
INSERT INTO weapons (weapon_id, safehouse_id, weapon_name, weapon_durability, weapon_quantity) VALUES
(1, 1, 'Pistol', 90.25, 3),
(2, 1, 'Assault Rifle', 75.50, 1),
(3, 2, 'Sniper Rifle', 98.75, 1),
(4, 2, 'Baseball Bat', 45.23, 3),
(5, 3, 'Crossbow', 79.56, 2),
(6, 4, 'Hunting Knife', 85.10, 5),
(7, 5, 'Shotgun', 65.40, 2),
(8, 6, 'Machete', 58.75, 4),
(9, 7, 'Grenades', 100.00, 10),
(10, 8, 'Axe', 70.30, 3);

-- Insert data into ammo
INSERT INTO ammo (ammo_id, ammo_type, ammo_quantity) VALUES
(1, '5.56mm', 250),
(2, '9mm', 300),
(3, '.308', 100),
(4, '12 Gauge', 150),
(5, 'Broadhead Bolts', 50);

-- Insert data into world_event
INSERT INTO world_event (event_id, safehouse_id, event_type_id, event_date, event_severity_id) VALUES
(1, 1, 5, '2025-11-21', 1),
(2, 2, 1, '2025-09-25', 4),
(3, 4, 4, '2025-10-11', 2),
(4, 5, 5, '2025-12-05', 1),
(5, 7, 3, '2025-11-01', 5),
(6, 10, 6, '2026-01-15', 3),
(7, 9, 7, '2025-10-28', 4);

-- Insert data into resource_usage, now with weapon and durability loss and updated ammo IDs
INSERT INTO resource_usage (usage_id, survivor_id, safehouse_id, usage_date, food_id, food_quantity, drink_id, drink_quantity, ammo_id, ammo_quantity, weapon_id, weapon_durability_loss) VALUES
(1, 1, 1, '2025-09-02', 1, 2, 1, 3, 2, 25, 1, 2.50),
(2, 1, 1, '2025-09-03', 1, 3, 2, 5, 2, 21, 1, 1.80),
(3, 2, 2, '2025-10-02', 3, 5, 3, 2, 4, 12, 7, 3.20),
(4, 3, 3, '2025-10-05', 5, 1, 5, 1, 5, 5, 5, 0.75),
(5, 4, 4, '2025-11-12', 8, 3, 7, 2, NULL, NULL, 6, 0.50),
(6, 5, 5, '2025-12-06', 9, 2, 8, 1, 1, 10, 2, 4.10), -- Updated ammo_id from 7 to 1
(7, 8, 8, '2025-10-20', 11, 1, NULL, NULL, 3, 30, 3, 2.00), -- Updated ammo_id from 6 to 3
(8, 1, 1, '2025-09-10', NULL, NULL, NULL, NULL, NULL, NULL, 4, 1.50),
(9, 2, 2, '2025-10-15', NULL, NULL, NULL, NULL, NULL, NULL, 8, 2.00),
(10, 9, 9, '2025-11-25', 12, 1, 1, 1, NULL, NULL, NULL, NULL);