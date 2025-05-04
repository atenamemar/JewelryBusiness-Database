-- File: analytical_queries.sql
-- Description: Analytical queries for JewelryBusiness database
-- Tested on MySQL 8.0.27

USE JewelryBusiness;

-- Report 1: Monthly Sales Report
-- Description: Shows total sales amount and number of orders per month
SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    COUNT(o.OrderID) AS OrderCount,
    SUM(o.TotalAmount) AS TotalSales,
    COUNT(DISTINCT o.CustomerID) AS UniqueCustomers
FROM Orders o
WHERE o.Status IN ('Completed', 'Shipped')
GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
ORDER BY Month;

-- Report 2: Top Selling Products
-- Description: Lists products with highest sales quantity and revenue
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.TotalPrice) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.Status IN ('Completed', 'Shipped')
GROUP BY p.ProductID, p.ProductName, p.Category
ORDER BY TotalQuantitySold DESC, TotalRevenue DESC
LIMIT 5;

-- Report 3: Low Stock Inventory
-- Description: Lists products with stock quantity below a threshold (e.g., 10)
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.StockQuantity,
    s.SupplierName,
    s.Email AS SupplierEmail
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.StockQuantity < 10
ORDER BY p.StockQuantity ASC;

-- Report 4: Top Customers
-- Description: Lists customers with highest purchase amounts and order counts
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.Email,
    COUNT(o.OrderID) AS OrderCount,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status IN ('Completed', 'Shipped')
GROUP BY c.CustomerID, CustomerName, c.Email
ORDER BY TotalSpent DESC, OrderCount DESC
LIMIT 5;