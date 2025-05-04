-- File: views.sql
-- Description: Defines views for JewelryBusiness database
-- Tested on MySQL 8.0.27

USE JewelryBusiness;

-- View: CustomerOrderSummary
-- Description: Summarizes customer orders with total spent and order status
CREATE OR REPLACE VIEW CustomerOrderSummary AS
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CASE WHEN o.Status IN ('Completed', 'Shipped') THEN o.TotalAmount ELSE 0 END) AS TotalSpent,
    SUM(CASE WHEN o.Status = 'Pending' THEN 1 ELSE 0 END) AS PendingOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, CustomerName, c.Email;

-- View: ProductStockStatus
-- Description: Shows product stock levels and supplier details
CREATE OR REPLACE VIEW ProductStockStatus AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.StockQuantity,
    CASE 
        WHEN p.StockQuantity < 5 THEN 'Critical'
        WHEN p.StockQuantity < 10 THEN 'Low'
        ELSE 'Sufficient'
    END AS StockStatus,
    s.SupplierName,
    s.Email AS SupplierEmail
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID;