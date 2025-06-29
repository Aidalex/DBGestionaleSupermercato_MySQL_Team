SELECT * FROM vendicosedb.Sales		-- Si è aggiunto anche il campo salesDate come PK, ogni giorno gli scontrini ripartono dal primo numero.
WHERE salesDate  = '2025-02-24'
ORDER BY salesID DESC;								



-- ANALISI PER SUPERMERCATO

-- Categoria di articoli maggiormente richiesta per negozio giornaliera.

WITH CategorySales AS (														
    SELECT S.storeID, CP.categoryName, SUM(S.quantity) AS totalQuantity
    FROM Sales AS S
    JOIN category_product AS CP ON CP.ID = S.productID
    WHERE S.salesDate = '2025-02-24'
    GROUP BY S.storeID, CP.categoryID)
SELECT CS.storeID, CS.categoryName, CS.totalQuantity
FROM CategorySales AS CS
JOIN (
    SELECT storeID, MAX(totalQuantity) AS maxQuantity
    FROM CategorySales
    GROUP BY storeID) AS MaxSales ON CS.storeID = MaxSales.storeID AND CS.totalQuantity = MaxSales.maxQuantity
ORDER BY CS.storeID, CS.totalQuantity DESC;

-- -----------------------
-- FATTURATO per negozio (per i 9 negozi) giornaliero.
SELECT ST.storeName, SUM(S.totalPrice) AS totalAmount FROM Stores AS ST
JOIN Sales AS S ON ST.ID = S.storeID
WHERE S.salesDate = '2025-02-24' 					       	-- CURDATE()
GROUP BY ST.ID;
																											
-- VISTA GIORNALIERA - Numero di vendite totali per prodotto di ogni negozio.			    -- *
CREATE VIEW daily_total_sales AS
SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity				
FROM Sales	
WHERE salesDate = CURDATE()						
GROUP BY storeID, productID
ORDER BY storeID, totalQuantity DESC;

SELECT * FROM daily_total_sales; 
 
 
-- VISTA GIORNALIERA -- Quantità totale di prodotto venduti per negozio. - Conta il totale quantità anche su salesID uguale, ma lineID diversa. --> per la 'daily_flag'
CREATE VIEW daily_product_sales AS															-- **
SELECT storeID, productID, SUM(quantity) AS totalQuantity				
FROM Sales	
WHERE salesDate = CURDATE()						
GROUP BY storeID, productID										  -- si potrebbe dare un limite -> HAVING > 14 (sicuramente staremmo arrivando al limite, e quindi in 'daily_flag ho già valori filtrati).
ORDER BY storeID, totalQuantity DESC;

SELECT*FROM daily_product_sales;								  -- in data odierna (28-02-2025) ci sono state 67 vendite: (si può filtrare con un WHERE storeID = ... )													
  
 -- EXPLAIN
EXPLAIN
SELECT storeID, productID, SUM(quantity) AS totalQuantity				
FROM Sales	
WHERE salesDate = CURDATE() 		
GROUP BY storeID, productID
HAVING storeID = 1			
ORDER BY storeID, totalQuantity DESC;							   -- -> ALL 
  
 -- VIEW product_sales del '2025-02-24' -- Quantità totale di prodotto venduti per negozio.
CREATE VIEW product_sales_24 AS
SELECT storeID, productID, SUM(quantity) AS totalQuantity				
FROM Sales	
WHERE salesDate = '2025-02-24'						
GROUP BY storeID, productID;							        	-- 153 vendite 				


SELECT * FROM product_sales_24;

-- VIEW del '2025-02-25'
CREATE VIEW product_sales_25 AS
SELECT storeID, productID, SUM(quantity) AS totalQuantity				
FROM Sales	
WHERE salesDate = '2025-02-25'						
GROUP BY storeID, productID;

 SELECT * FROM product_sales_25;

	


-- -------- Quantità di vendite per negozio e per prodotto.

SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity
FROM Sales
WHERE storeID = 1 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;

SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity				
FROM Sales
WHERE storeID = 2 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;


SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity				
FROM Sales
WHERE storeID = 3 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;


SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity			
FROM Sales
WHERE storeID = 4 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;

SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity				
FROM Sales
WHERE storeID = 5 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;


SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity				
FROM Sales
WHERE storeID = 6 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;


SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity				
FROM Sales
WHERE storeID = 7 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;

SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity				
FROM Sales
WHERE storeID = 8 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;


SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity			
FROM Sales
WHERE storeID = 9 AND salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY productID;

SELECT storeID, COUNT(salesID) AS totalSales, productID, SUM(quantity) AS totalQuantity					-- Per negozio, q.tà DESC
FROM Sales
WHERE salesDate = '2025-02-24' 			-- CURDATE()
GROUP BY storeID, productID
ORDER BY storeID, productID, totalQuantity DESC;


