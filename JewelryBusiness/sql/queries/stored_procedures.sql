-- File: stored_procedures.sql
-- Description: Defines stored procedures for JewelryBusiness database
-- Tested on MySQL 8.0.27

USE JewelryBusiness;

-- Procedure: UpdateStockAfterOrder
-- Description: Updates product stock after an order is placed
DELIMITER //
CREATE PROCEDURE UpdateStockAfterOrder(IN order_id INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE prod_id INT;
    DECLARE qty INT;
    DECLARE cur CURSOR FOR 
        SELECT ProductID, Quantity 
        FROM OrderDetails 
        WHERE OrderID = order_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO prod_id, qty;
        IF done THEN
            LEAVE read_loop;
        END IF;
        UPDATE Products 
        SET StockQuantity = StockQuantity - qty
        WHERE ProductID = prod_id AND StockQuantity >= qty;
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for product';
        END IF;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- Procedure: GenerateMonthlySalesReport
-- Description: Generates sales report for a specific year and month
DELIMITER //
CREATE PROCEDURE GenerateMonthlySalesReport(IN year INT, IN month INT)
BEGIN
    SELECT 
        p.ProductID,
        p.ProductName,
        p.Category,
        SUM(od.Quantity) AS TotalQuantitySold,
        SUM(od.TotalPrice) AS TotalRevenue
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE YEAR(o.OrderDate) = year 
        AND MONTH(o.OrderDate) = month
        AND o.Status IN ('Completed', 'Shipped')
    GROUP BY p.ProductID, p.ProductName, p.Category
    ORDER BY TotalRevenue DESC;
END //
DELIMITER ;