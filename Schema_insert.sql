-- --------------------- --------------------- --------------------- --------------------- --------------------- ---------------------
-- SCHEMA 'INSERT INTO' per ogni entità se si vuole aggiungere ulteriori record. Per l'aggiornamento del DB.

-- Category
INSERT INTO Category (categoryName, restockLevel) VALUES	
(),
();
-- 

-- Product
INSERT INTO Product (productName, descrizione, maxUnitSalesPrice, maxQuantity, categoryID) VALUES
(),
();
-- 

-- Warehouses
INSERT INTO Warehouses (warehouseName, location, address, email) VALUES
(),
();
-- 

-- Stores
INSERT INTO Stores (storeName, location, address, email, warehouseID) VALUES
(),
();
-- 

-- Sales * 
INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, discountedPercentage, quantity, totalPrice) VALUES
(),
();
-- 

-- StockLeves  - quando verrà aggiunto un prodotto per un certo Warehouse -> verrà eseguito un controllo grazie al Trigger: dove lo stock non può essere < dello stockLevel (di Categor).
INSERT INTO Stocklevels (productID, warehouseID, stock) VALUES
(),
();
-- 