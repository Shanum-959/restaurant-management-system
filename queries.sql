-- ============================================================
-- Restaurant Management System - Queries
-- ============================================================
-- Run schema.sql first to create and populate the database.
-- This file contains analysis queries: basic SELECTs, JOINs,
-- and nested/correlated subqueries.
-- ============================================================

USE RMS;

-- To retrieve a list of all customers along with the items they ordered
SELECT c.Name, o.Ordered_Item, o.Price_Per_Item
FROM Customer c
JOIN Orders o ON c.Customer_ID = o.Customer_ID;

-- To find all orders handled by a specific waiter
SELECT o.Order_ID, o.Ordered_Item, o.Price_Per_Item
FROM Orders o
JOIN Waiter w ON o.Waiter_ID = w.Waiter_ID
WHERE w.Waiter_ID = 501;  -- Replace 501 with the specific waiter ID

-- To check the bill details of a particular customer
SELECT b.Bill_ID, b.Total_Amount, b.Deal_Discount
FROM Bill b
WHERE b.Customer_ID = 1;  -- Replace 1 with the specific customer ID

-- To retrieve all menu items that have a deal attached
SELECT m.Item_Name, m.Price, m.Deals
FROM Menu m
WHERE m.Deals IS NOT NULL;

-- Show all dining tables managed by a specific waiter
SELECT Table_No, Shape, Seats
FROM Dining_Tables
WHERE Waiter_ID = 501;

-- List all employees who work as Chefs
SELECT Employee_ID, Name, Role
FROM Employee
WHERE Role = 'Chef';

-- INNER JOIN - Show waiter names with the tables they serve
SELECT Waiter.Name, Dining_Tables.Table_No
FROM Waiter
INNER JOIN Dining_Tables ON Waiter.Waiter_ID = Dining_Tables.Waiter_ID;

-- LEFT JOIN - Show all customers and their orders (including customers with no orders)
SELECT Customer.Name, Orders.Ordered_Item
FROM Customer
LEFT JOIN Orders ON Customer.Customer_ID = Orders.Customer_ID;

-- RIGHT JOIN - Show all bills and the customers who paid them
SELECT Customer.Name, Bill.Total_Amount
FROM Customer
RIGHT JOIN Bill ON Customer.Customer_ID = Bill.Customer_ID;

-- Nested Subquery (4+ Tables): Customers whose order amount is above average and who have a bill cleared by an accountant
SELECT c.Name
FROM Customer c
WHERE c.Customer_ID IN (
    SELECT o.Customer_ID
    FROM Orders o
    JOIN Bill b ON o.Order_ID = b.Order_ID
    JOIN Accountant a ON b.Accountant_ID = a.Accountant_ID
    WHERE o.Price_Per_Item > (
        SELECT AVG(Price_Per_Item) FROM Orders
    )
);

-- Correlated Subquery (4+ Tables): Customers whose bill discount is greater than 0 and whose order was taken by a waiter assigned to a dining table
SELECT c.Name
FROM Customer c
WHERE EXISTS (
    SELECT 1
    FROM Bill b
    JOIN Orders o ON b.Order_ID = o.Order_ID
    JOIN Waiter w ON o.Waiter_ID = w.Waiter_ID
    JOIN Dining_Tables d ON w.Waiter_ID = d.Waiter_ID
    WHERE b.Customer_ID = c.Customer_ID
      AND b.Deal_Discount > 0
);
