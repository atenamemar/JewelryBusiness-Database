-- File: triggers.sql
-- Description: Defines triggers for JewelryBusiness database
-- Tested on MySQL 8.0.27

USE JewelryBusiness;

-- Triggers to ensure HireDate is not in the future
DELIMITER $$

CREATE TRIGGER trg_check_hiredate_insert
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF NEW.HireDate > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'HireDate cannot be in the future.';
    END IF;
END$$

CREATE TRIGGER trg_check_hiredate_update
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    IF NEW.HireDate > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'HireDate cannot be in the future.';
    END IF;
END$$

DELIMITER ;

-- Table to log price changes
CREATE TABLE IF NOT EXISTS PriceChangeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    OldPrice DECIMAL(10,2),
    NewPrice DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
) COMMENT 'Logs changes to product prices';

-- Trigger: LogPriceChange
-- Description: Logs changes to product prices
DELIMITER //
CREATE TRIGGER LogPriceChange
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.Price != NEW.Price THEN
        INSERT INTO PriceChangeLog (ProductID, OldPrice, NewPrice)
        VALUES (OLD.ProductID, OLD.Price, NEW.Price);
    END IF;
END //
DELIMITER ;

-- Trigger: ValidateOrderStatus
-- Description: Ensures TotalAmount is not zero for Completed/Shipped orders
DELIMITER //
CREATE TRIGGER ValidateOrderStatus
BEFORE UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF NEW.Status IN ('Completed', 'Shipped') AND NEW.TotalAmount = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot mark order as Completed or Shipped with zero TotalAmount';
    END IF;
END //
DELIMITER ;