-- ============================================================
-- Restaurant Management System - Database Schema
-- ============================================================
-- Contains: database creation, table definitions (DDL),
-- and sample seed data (DML inserts).
-- Run this file first before running queries.sql
-- ============================================================

CREATE DATABASE RMS;
USE RMS;

CREATE TABLE Owner (
    Owner_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Phone_Number VARCHAR(20)
);
INSERT INTO Owner (Owner_ID, Name, Address, Phone_Number) VALUES
(1, 'Ahmed Khan', 'Lahore, Pakistan', '03001234567'),
(2, 'Bilal Raza', 'Karachi, Pakistan', '03012345678'),
(3, 'Sana Tariq', 'Islamabad, Pakistan', '03121234567');

CREATE TABLE Restaurant (
    Restaurant_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Phone_Number VARCHAR(20),
    Email VARCHAR(100),
    Owner_ID INT,
    FOREIGN KEY (Owner_ID) REFERENCES Owner(Owner_ID)
);
INSERT INTO Restaurant (Restaurant_ID, Name, Address, Phone_Number, Email, Owner_ID) VALUES
(201, 'Spice Villa', 'Gulberg, Lahore', '04235123456', 'spicevilla@example.com', 1),
(202, 'Sea Breeze', 'Clifton, Karachi', '02134123456', 'seabreeze@example.com', 2),
(203, 'Hill Top Diner', 'F-7, Islamabad', '05112345678', 'hilltop@example.com', 3);

CREATE TABLE Manager (
    Manager_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone_Number VARCHAR(20),
    Restaurant_ID INT,
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID)
);
INSERT INTO Manager (Manager_ID, Name, Email, Phone_Number, Restaurant_ID) VALUES
(301, 'Hamza Sheikh', 'hamza@example.com', '03211234567', 201),
(302, 'Areeba Noor', 'areeba@example.com', '03311234567', 202),
(303, 'Usman Ali', 'usman@example.com', '03451234567', 203);

CREATE TABLE Inventory (
    Item_ID INT PRIMARY KEY,
    Item_Name VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Manager_ID INT,
    FOREIGN KEY (Manager_ID) REFERENCES Manager(Manager_ID)
);
INSERT INTO Inventory (Item_ID, Item_Name, Quantity, Unit_Price, Manager_ID) VALUES
(1, 'Chicken Breast', 50, 350.00, 301),
(2, 'Basmati Rice', 100, 180.00, 301),
(3, 'Prawns', 30, 800.00, 302),
(4, 'Olive Oil', 20, 950.00, 302),
(5, 'Tomatoes', 80, 60.00, 303),
(6, 'Cheese Slices', 40, 450.00, 303);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Phone_Number VARCHAR(20),
    Manager_ID INT,
    FOREIGN KEY (Manager_ID) REFERENCES Manager(Manager_ID)
);
INSERT INTO Employee (Employee_ID, Name, Role, Phone_Number, Manager_ID) VALUES
(401, 'Fahad Iqbal', 'Waiter', '03551234567', 301),
(402, 'Hira Mustafa', 'Chef', '03661234567', 301),
(403, 'Zain Abbas', 'Accountant', '03771234567', 302),
(404, 'Mahnoor Ali', 'Waiter', '03881234567', 302),
(405, 'Talha Saeed', 'Chef', '03991234567', 303),
(406, 'Iqra Yousaf', 'Accountant', '03021234567', 303);

CREATE TABLE Waiter (
    Waiter_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone_Number VARCHAR(20),
    Employee_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
INSERT INTO Waiter (Waiter_ID, Name, Email, Phone_Number, Employee_ID) VALUES
(501, 'Fahad Iqbal', 'fahad@example.com', '03551234567', 401),
(502, 'Mahnoor Ali', 'mahnoor@example.com', '03881234567', 404);

CREATE TABLE Chef (
    Chef_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone_Number VARCHAR(20),
    Employee_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
INSERT INTO Chef (Chef_ID, Name, Email, Phone_Number, Employee_ID) VALUES
(601, 'Hira Mustafa', 'hira@example.com', '03661234567', 402),
(602, 'Talha Saeed', 'talha@example.com', '03991234567', 405);

CREATE TABLE Accountant (
    Accountant_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone_Number VARCHAR(20),
    Employee_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
INSERT INTO Accountant (Accountant_ID, Name, Email, Phone_Number, Employee_ID) VALUES
(701, 'Zain Abbas', 'zain@example.com', '03771234567', 403),
(702, 'Iqra Yousaf', 'iqra@example.com', '03021234567', 406);

CREATE TABLE Dining_Tables (
    Table_No INT PRIMARY KEY,
    Shape VARCHAR(20),
    Seats INT,
    Waiter_ID INT,
    FOREIGN KEY (Waiter_ID) REFERENCES Waiter(Waiter_ID)
);
INSERT INTO Dining_Tables (Table_No, Shape, Seats, Waiter_ID) VALUES
(1, 'Round', 4, 501),
(2, 'Square', 2, 501),
(3, 'Rectangle', 6, 502),
(4, 'Round', 4, 502);

CREATE TABLE Menu (
    Menu_ID INT PRIMARY KEY,
    Item_Name VARCHAR(100),
    Price DECIMAL(10,2),
    Deals VARCHAR(100),
    Waiter_ID INT,
    FOREIGN KEY (Waiter_ID) REFERENCES Waiter(Waiter_ID)
);
INSERT INTO Menu (Menu_ID, Item_Name, Price, Deals, Waiter_ID) VALUES
(1, 'Chicken Karahi', 1200.00, 'Family Deal', 501),
(2, 'Biryani', 350.00, NULL, 501),
(3, 'Grilled Fish', 900.00, 'Couple Deal', 502),
(4, 'Pasta Alfredo', 650.00, NULL, 502),
(5, 'BBQ Platter', 1500.00, 'Friends Deal', 501);

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone_Number VARCHAR(20)
);
INSERT INTO Customer (Customer_ID, Name, Phone_Number) VALUES
(1, 'Hafsa', '03001234567'),
(2, 'Iqra', '03012345678'),
(3, 'Hadia', '03121234567'),
(4, 'Maliha', '03211234567'),
(5, 'Laiba', '03311234567'),
(6, 'Saniya', '03451234567');

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Ordered_Item VARCHAR(100),
    Price_Per_Item DECIMAL(10,2),
    Customer_ID INT,
    Waiter_ID INT,
    Table_No INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Waiter_ID) REFERENCES Waiter(Waiter_ID),
    FOREIGN KEY (Table_No) REFERENCES Dining_Tables(Table_No)
);
INSERT INTO Orders (Order_ID, Ordered_Item, Price_Per_Item, Customer_ID, Waiter_ID, Table_No) VALUES
(1, 'Chicken Karahi', 1200.00, 1, 501, 1),
(2, 'Biryani', 350.00, 2, 501, 2),
(3, 'Grilled Fish', 900.00, 3, 502, 3),
(4, 'Pasta Alfredo', 650.00, 4, 502, 4),
(5, 'BBQ Platter', 1500.00, 5, 501, 1),
(6, 'Biryani', 350.00, 6, 502, 3);

CREATE TABLE Bill (
    Bill_ID INT PRIMARY KEY,
    Items_Amount DECIMAL(10,2),
    Deal_Discount DECIMAL(10,2),
    Total_Amount DECIMAL(10,2),
    Order_ID INT,
    Accountant_ID INT,
    Customer_ID INT,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Accountant_ID) REFERENCES Accountant(Accountant_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
INSERT INTO Bill (Bill_ID, Items_Amount, Deal_Discount, Total_Amount, Order_ID, Accountant_ID, Customer_ID) VALUES
(1, 1200.00, 100.00, 1100.00, 1, 701, 1),
(2, 350.00, 0.00, 350.00, 2, 701, 2),
(3, 900.00, 50.00, 850.00, 3, 702, 3),
(4, 650.00, 0.00, 650.00, 4, 702, 4),
(5, 1500.00, 200.00, 1300.00, 5, 701, 5),
(6, 350.00, 0.00, 350.00, 6, 702, 6);
