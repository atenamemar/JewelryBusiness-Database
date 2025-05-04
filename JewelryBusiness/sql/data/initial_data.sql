-- File: initial_data.sql
-- Description: Inserts initial data into JewelryBusiness database tables
-- Tested on MySQL 8.0.27

USE JewelryBusiness;

-- Insert 5 records into Suppliers
INSERT INTO Suppliers (SupplierName, ContactName, Email, Phone, Country) VALUES
('GemCo International', 'Ahmed Khan', 'ahmed.khan@gemco.com', '+971501234101', 'UAE'),
('PureGold Ltd', 'Sophie Laurent', 'sophie.laurent@puregold.com', '+33123456101', 'France'),
('DiamondSource', 'Rahul Patel', 'rahul.patel@diamondsource.com', '+919876543101', 'India'),
('SilverCraft', 'Hiroshi Tanaka', 'hiroshi.tanaka@silvercraft.com', '+81312345101', 'Japan'),
('LuxMaterials', 'John Smith', 'john.smith@luxmaterials.com', '+12025550101', 'USA');

-- Insert 5 records into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, Country) VALUES
('Ali', 'Rezaei', 'ali.rezaei@gmail.com', '+989121234501', '123 Azadi St', 'Tehran', 'Iran'),
('Zahra', 'Mohammadi', 'zahra.mohammadi@gmail.com', '+989121234502', '456 Saadi Ave', 'Shiraz', 'Iran'),
('Fatima', 'Ali', 'fatima.ali@gmail.com', '+971501234501', '789 Sheikh Zayed Rd', 'Dubai', 'UAE'),
('Marie', 'Lefevre', 'marie.lefevre@gmail.com', '+33123456501', '101 Champs-Élysées', 'Paris', 'France'),
('Rahul', 'Sharma', 'rahul.sharma@gmail.com', '+919876543501', '321 MG Road', 'Mumbai', 'India');

-- Insert 5 records into Employees
INSERT INTO Employees (FirstName, LastName, Email, Phone, HireDate, Position) VALUES
('Reza', 'Ghasemi', 'reza.ghasemi@jewelry.com', '+989121234601', '2018-01-01', 'Sales Manager'),
('Shiva', 'Ebrahimi', 'shiva.ebrahimi@jewelry.com', '+989121234602', '2018-02-01', 'Designer'),
('Layla', 'Ibrahim', 'layla.ibrahim@jewelry.com', '+971501234601', '2018-03-01', 'Accountant'),
('Antoine', 'Leroy', 'antoine.leroy@jewelry.com', '+33123456601', '2018-04-01', 'Sales Representative'),
('Ravi', 'Kumar', 'ravi.kumar@jewelry.com', '+919876543601', '2018-05-01', 'Store Manager');

-- Insert 5 records into Products
INSERT INTO Products (ProductName, Description, Category, Material, Price, StockQuantity, SupplierID) VALUES
('Diamond Solitaire Ring', '18K white gold ring with 1-carat diamond', 'Ring', 'White Gold', 5000.00, 10, 1),
('Emerald Necklace', '14K yellow gold necklace with emerald pendant', 'Necklace', 'Yellow Gold', 3000.00, 15, 2),
('Silver Bracelet', 'Sterling silver charm bracelet', 'Bracelet', 'Silver', 500.00, 20, 4),
('Sapphire Earrings', '18K white gold earrings with blue sapphires', 'Earrings', 'White Gold', 2000.00, 8, 3),
('Gold Wedding Band', '22K yellow gold wedding band', 'Ring', 'Yellow Gold', 1000.00, 25, 5);

-- Insert 5 records into Orders
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, Status, TotalAmount) VALUES
(1, 1, '2023-01-01 10:00:00', 'Completed', 5500.00),
(2, 2, '2023-01-02 11:15:00', 'Shipped', 3000.00),
(3, 3, '2023-01-03 12:30:00', 'Pending', 2000.00),
(4, 4, '2023-01-04 13:45:00', 'Completed', 5000.00),
(5, 5, '2023-01-05 15:00:00', 'Shipped', 1000.00);

-- Insert 6 records into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 5000.00), -- Diamond Solitaire Ring
(1, 3, 1, 500.00),  -- Silver Bracelet
(2, 2, 1, 3000.00), -- Emerald Necklace
(3, 4, 1, 2000.00), -- Sapphire Earrings
(4, 1, 1, 5000.00), -- Diamond Solitaire Ring
(5, 5, 1, 1000.00); -- Gold Wedding Band

-- Insert 5 records into Payments
INSERT INTO Payments (OrderID, CustomerID, EmployeeID, PaymentDate, PaymentMethod, Amount) VALUES
(1, 1, 1, '2023-01-01 10:30:00', 'Credit Card', 5500.00),
(2, 2, 2, '2023-01-02 11:45:00', 'Online Payment', 3000.00),
(3, 3, 3, '2023-01-03 13:00:00', 'Bank Transfer', 2000.00),
(4, 4, 4, '2023-01-04 14:15:00', 'Credit Card', 5000.00),
(5, 5, 5, '2023-01-05 15:30:00', 'Online Payment', 1000.00);