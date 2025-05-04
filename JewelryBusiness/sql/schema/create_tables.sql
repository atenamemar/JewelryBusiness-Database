-- File: create_tables.sql
-- Description: Defines tables and indexes for JewelryBusiness database
-- Tested on MySQL 8.0.27

USE JewelryBusiness;

-- Table to store customer information
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL COMMENT 'Customer first name',
    LastName VARCHAR(50) NOT NULL COMMENT 'Customer last name',
    Email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Customer email address',
    Phone VARCHAR(20) COMMENT 'Customer contact number (mobile or landline)',
    Address TEXT COMMENT 'Customer address',
    City VARCHAR(50) COMMENT 'Customer city',
    Country VARCHAR(50) NOT NULL COMMENT 'Customer country',
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Account creation timestamp',
    CHECK (Email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
) COMMENT 'Stores customer details for the jewelry business';

CREATE INDEX idx_customer_email ON Customers(Email);

-- Table to store employee information
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL COMMENT 'Employee first name',
    LastName VARCHAR(50) NOT NULL COMMENT 'Employee last name',
    Email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Employee email address',
    Phone VARCHAR(20) COMMENT 'Employee contact number',
    HireDate DATE NOT NULL COMMENT 'Employee hire date',
    Position VARCHAR(50) NOT NULL COMMENT 'Employee job position'
) COMMENT 'Stores employee details for the jewelry business';

CREATE INDEX idx_employee_email ON Employees(Email);

-- Table to store supplier information
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL COMMENT 'Supplier company name',
    ContactName VARCHAR(100) NOT NULL COMMENT 'Supplier contact person',
    Email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Supplier email address',
    Phone VARCHAR(20) COMMENT 'Supplier contact number',
    Country VARCHAR(50) NOT NULL COMMENT 'Supplier country'
) COMMENT 'Stores supplier details for sourcing jewelry materials';

CREATE INDEX idx_supplier_email ON Suppliers(Email);

-- Table to store product information
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL COMMENT 'Product name (e.g., Diamond Ring)',
    Description TEXT COMMENT 'Product description',
    Category ENUM('Ring', 'Necklace', 'Bracelet', 'Earrings', 'Other') NOT NULL COMMENT 'Product category',
    Material VARCHAR(50) NOT NULL COMMENT 'Material (e.g., Gold, Silver)',
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 100 AND Price <= 100000) COMMENT 'Product price in USD',
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0) COMMENT 'Available stock',
    SupplierID INT NOT NULL COMMENT 'Supplier providing the product',
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Product creation timestamp',
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
) COMMENT 'Stores jewelry product details';

CREATE INDEX idx_product_category ON Products(Category);
CREATE INDEX idx_product_supplier ON Products(SupplierID);

-- Table to store order information
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL COMMENT 'Customer placing the order',
    EmployeeID INT NOT NULL COMMENT 'Employee handling the order',
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Order placement timestamp',
    Status ENUM('Pending', 'Completed', 'Cancelled', 'Shipped') NOT NULL DEFAULT 'Pending' COMMENT 'Order status',
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0) COMMENT 'Total order amount in USD',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
) COMMENT 'Stores customer order details';

CREATE INDEX idx_order_date ON Orders(OrderDate);
CREATE INDEX idx_order_customer ON Orders(CustomerID);

-- Table to store order details
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL COMMENT 'Associated order',
    ProductID INT NOT NULL COMMENT 'Ordered product',
    Quantity INT NOT NULL CHECK (Quantity > 0 AND Quantity <= 100) COMMENT 'Quantity ordered',
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0) COMMENT 'Price per unit in USD',
    TotalPrice DECIMAL(10,2) GENERATED ALWAYS AS (Quantity * UnitPrice) STORED COMMENT 'Total price for this item',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
) COMMENT 'Stores details of products in each order';

CREATE INDEX idx_orderdetail_order ON OrderDetails(OrderID);
CREATE INDEX idx_orderdetail_product ON OrderDetails(ProductID);

-- Table to store payment information
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL COMMENT 'Associated order',
    CustomerID INT NOT NULL COMMENT 'Customer making the payment',
    EmployeeID INT NOT NULL COMMENT 'Employee processing the payment',
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Payment timestamp',
    PaymentMethod ENUM('Credit Card', 'Bank Transfer', 'Online Payment') NOT NULL COMMENT 'Payment method',
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount >= 0) COMMENT 'Payment amount in USD',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
) COMMENT 'Stores payment transactions';

CREATE INDEX idx_payment_date ON Payments(PaymentDate);
CREATE INDEX idx_payment_customer ON Payments(CustomerID);