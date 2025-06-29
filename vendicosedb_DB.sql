CREATE DATABASE vendicosedb;											  -- Apertura dei negozi il 24-02-2025.
USE vendicosedb;

CREATE TABLE Category ( 												  -- 20 categorie
	ID INT AUTO_INCREMENT PRIMARY KEY, 
	categoryName VARCHAR(30) NOT NULL,
    restockLevel INT 													  -- Minimo di scorte che dovrebbe essere mantenuto per ogni categoria di prodotto. Se (stock - vendite) < di restockLevel, allora 'Ordina'  --> si può creare una vista (*riga 555).
); 


CREATE TABLE Product ( 													  -- 100 prodotti
	ID INT AUTO_INCREMENT PRIMARY KEY, 
	productName VARCHAR(45) NOT NULL, 
    descrizione VARCHAR(35),
    maxUnitSalesPrice DECIMAL(8,2),										  
	categoryID INT, 													  -- Inserita una colonna 'maxQuantity' --> q.tà massima che si può vendere per prodotto?
    FOREIGN KEY(categoryID) REFERENCES Category(ID)
);

CREATE TABLE Warehouses (												  -- 3 magazzini
	ID INT AUTO_INCREMENT PRIMARY KEY,
	warehouseName VARCHAR(45) NOT NULL,
    location VARCHAR(30)
);

CREATE TABLE Stores (												      -- 9 supermercati ognuno dei quali ha gli stessi prodotti.
	ID INT AUTO_INCREMENT PRIMARY KEY,										
    storeName VARCHAR(45) NOT NULL,
    location VARCHAR(30),
    warehouseID INT,													 
    FOREIGN KEY(warehouseID) REFERENCES Warehouses(ID)
);

CREATE TABLE Stocklevels (												  -- "Inventario"
	productID INT,
    categoryID INT,
    warehouseID INT,													 
    stock INT,															  -- Disponibilità fisica di ogni giorno all'apertura. Ogni magazzino deve rifornire i 3 supermercati in base allo stock (fissato per categoria) SET stock = (restockLevel + 10);			
    PRIMARY KEY(productID, categoryID, warehouseID),
    FOREIGN KEY(productID) REFERENCES Product(ID),
    FOREIGN KEY(categoryID) REFERENCES Category(ID),
    FOREIGN KEY(warehouseID) REFERENCES Warehouses(ID)
);

CREATE TABLE Sales (
	storeID INT,
    salesID INT,														  -- Numero dello scontrino
	lineID INT,
	productID INT,
    quantity INT,														  -- Inserimento del vincolo CHECK (quantity <= maxQuantity);
    totalPrice DECIMAL(8,2),											  -- Inserita una colonna 'unitPrice' e 'discountedPercentage'
    PRIMARY KEY(storeID, salesID, lineID),
	FOREIGN KEY(storeID) REFERENCES Stores(ID),
    FOREIGN KEY(productID) REFERENCES Product(ID)
);


INSERT INTO Category (categoryName, restockLevel) VALUES				  -- Creata una Vista "Product-Category-restockLevel"
('Fruits and Vegetables', 50),
('Meat and Poultry', 30),
('Fish and Seafood', 20),
('Dairy and Eggs', 40),
('Cold Cuts and Deli', 35),
('Bread and Bakery', 25),
('Pasta, Rice, and Cereals', 60),
('Canned Legumes and Vegetables', 45),
('Oils and Condiments', 30),
('Sauces and Dressings', 40),
('Snacks and Chips', 70),
('Sweets and Chocolate', 55),
('Non-Alcoholic Beverages', 80),
('Water and Fruit Juices', 75),
('Coffee, Tea, and Infusions', 40),
('Beer and Alcoholic Beverages', 50),
('Personal Care Products', 35),
('Household Cleaning Products', 60),
('Pet Supplies', 25),
('Paper and Disposable Products', 30);

SELECT*FROM Category;

INSERT INTO Product (productName, descrizione, maxUnitSalesPrice, categoryID) VALUES
('Apple', 'Fresh red apples', 2.50, 1),														-- Fruits and Vegetables (ID 1)
('Banana', 'Ripe yellow bananas', 1.80, 1),
('Carrot', 'Organic carrots', 1.20, 1),
('Tomato', 'Cherry tomatoes', 2.00, 1),
('Lettuce', 'Green lettuce head', 1.50, 1),
('Chicken Breast', '500g pack', 7.50, 2),													-- Meat and Poultry (ID 2)
('Ground Beef', '500g pack', 9.00, 2),
('Pork Chops', '4 pieces', 8.00, 2),
('Turkey Slices', '250g pack', 6.50, 2),
('Sausages', '6 pieces', 5.80, 2),
('Salmon Fillet', '250g portion', 15.00, 3),												-- Fish and Seafood (ID 3)
('Tuna Steak', '200g portion', 12.50, 3),
('Shrimps', '500g pack', 14.00, 3),
('Cod Fillet', '300g portion', 10.00, 3),
('Mussels', '1kg bag', 8.50, 3),				
('Milk', '1L bottle', 1.50, 4),																-- Dairy and Eggs (ID 4)							
('Butter', '250g block', 2.50, 4),
('Cheddar Cheese', '200g wedge', 4.80, 4),
('Greek Yogurt', '150g cup', 3.20, 4),
('Dozen Eggs', '12 eggs', 3.50, 4),
('Ham', '200g pack', 4.50, 5),																-- Cold Cuts and Deli (ID 5)
('Salami', '150g pack', 5.00, 5),
('Prosciutto', '100g pack', 6.80, 5),
('Mortadella', '200g pack', 4.20, 5),
('Turkey Breast Slices', '250g pack', 5.50, 5),
('Baguette', '300g piece', 2.00, 6),														-- Bread and Bakery (ID 6)
('Whole Wheat Bread', '500g loaf', 2.80, 6),
('Croissant', '80g piece', 1.50, 6),							
('Muffin', '100g piece', 2.20, 6),
('Ciabatta', '350g piece', 2.50, 6),
('Spaghetti', '500g pack', 2.50, 7),														-- Pasta, Rice, and Cereals (ID 7)
('Basmati Rice', '1kg bag', 3.80, 7),
('Cornflakes', '500g box', 4.00, 7),						-- prodotto doppio = paccheri
('Quinoa', '500g bag', 5.00, 7),
('Oatmeal', '500g pack', 3.20, 7),
('Canned Chickpeas', '400g can', 1.50, 8),													-- Canned Legumes and Vegetables (ID 8)
('Canned Lentils', '400g can', 1.80, 8),
('Canned Tomatoes', '500g can', 2.00, 8),
('Canned Corn', '300g can', 1.70, 8),
('Canned Peas', '400g can', 1.60, 8),
('Potato Chips', '150g bag', 2.50, 9),														-- Snacks and Chips (ID 9)
('Tortilla Chips', '200g bag', 3.00, 9),
('Salted Peanuts', '250g pack', 2.80, 9),
('Mixed Nuts', '300g pack', 4.50, 9),
('Pretzels', '200g bag', 2.20, 9),
('Tomato Sauce', '500g jar', 2.50, 10),														-- Sauces and Dressings (ID 10)
('Mayonnaise', '250g bottle', 3.00, 10),
('Ketchup', '500ml bottle', 2.20, 10),
('Mustard', '250g jar', 1.80, 10),
('Soy Sauce', '300ml bottle', 3.20, 10),
('Chocolate Cake', '500g cake', 8.00, 11),													-- Bakery and Pastry (ID 11)
('Apple Pie', '600g pie', 7.50, 11),
('Croissant', '80g piece', 1.80, 11),							-- prodotto doppio	= cheescake	
('Donuts', '4 pieces', 3.50, 11),
('Pound Cake', '500g loaf', 6.00, 11),
('Dark Chocolate', '100g bar', 2.80, 12),													-- Sweets and Chocolate (ID 12)
('Milk Chocolate', '100g bar', 2.50, 12),
('Hazelnut Spread', '400g jar', 4.50, 12),
('Gummy Bears', '200g pack', 2.20, 12),
('Marshmallows', '250g bag', 2.30, 12),
('Orange Juice', '1L carton', 3.00, 13),													-- Non-Alcoholic Beverages (ID 13)
('Cola', '2L bottle', 2.80, 13),
('Lemon Iced Tea', '1.5L bottle', 2.50, 13),
('Sparkling Water', '1L bottle', 1.80, 13),
('Apple Juice', '1L carton', 3.00, 13),
('Mineral Water', '1.5L bottle', 1.50, 14),													-- Water and Fruit Juices (ID 14)
('Spring Water', '2L bottle', 1.80, 14),
('Peach Juice', '1L carton', 2.90, 14),
('Pineapple Juice', '1L carton', 3.20, 14),
('Grapefruit Juice', '1L carton', 3.00, 14),
('Ground Coffee', '250g pack', 4.80, 15),													-- Coffee, Tea, and Infusions (ID 15)
('Instant Coffee', '200g jar', 5.50, 15),
('Green Tea', '20 bags', 3.20, 15),
('Chamomile Tea', '20 bags', 2.50, 15),
('Black Tea', '20 bags', 3.00, 15),
('Lager Beer', '500ml bottle', 2.50, 16),													-- Beer and Alcoholic Beverages (ID 16)
('IPA Beer', '500ml bottle', 3.50, 16),
('Stout Beer', '500ml bottle', 3.80, 16),
('Whiskey', '750ml bottle', 25.00, 16),
('Rum', '700ml bottle', 20.00, 16),
('Red Wine', '750ml bottle', 12.00, 17),													-- Wine and Liquors (ID 17)
('White Wine', '750ml bottle', 10.00, 17),
('Rosé Wine', '750ml bottle', 11.00, 17),
('Champagne', '750ml bottle', 30.00, 17),
('Limoncello', '500ml bottle', 15.00, 17),
('Muesli', '500g pack', 4.50, 18),															-- Breakfast and Cereals (ID 18)
('Granola', '400g pack', 4.80, 18),
('Cornflakes', '500g box', 3.80, 18),
('Oat Flakes', '500g bag', 3.20, 18),
('Chocolate Cereal', '500g box', 4.00, 18),
('Baby Formula', '400g can', 15.00, 19),													-- Baby Products (ID 19)
('Baby Wipes', '80 wipes pack', 4.00, 19),
('Diapers', '30 pcs pack', 12.50, 19),
('Baby Shampoo', '250ml bottle', 5.50, 19),
('Baby Food Jar', '125g jar', 2.00, 19),
('Frozen Peas', '1kg bag', 3.50, 20),														-- Frozen Foods (ID 20)
('Frozen Pizza', '400g box', 4.80, 20),
('Vanilla Ice Cream', '500ml tub', 5.00, 20),
('Frozen Chicken Nuggets', '500g pack', 6.50, 20),
('Frozen Mixed Berries', '500g bag', 4.20, 20);

SELECT*FROM Product;

INSERT INTO Warehouses (warehouseName, location) VALUES
('Central Distribution Center', 'Milano'),
('Essential Goods Warehouse', 'Roma'),
('Beverage & Food Distribution', 'Bari');


INSERT INTO Stores (storeName, location, address, email, warehouseID) VALUES
('Superstore', 'Bergamo', 'Via Roma, 15', 'superstore.bergamo@gmail.com', 1),				-- "Central Distribution Center" (Milano)
('Central Market', 'Torino', 'Corso Francia, 120', 'centralmarket.torino@hotmail.com', 1),
('Local Market', 'Verona', 'Piazza Bra, 8', 'localmarket.verona@live.com', 1),
('Grand Market', 'Pescara', 'Viale Marconi, 50', 'grandmarket.pescara@gmail.com', 2),		-- "Essential Goods Warehouse" (Roma)
('Food Center', 'Perugia', 'Via Fontivegge, 25', 'foodcenter.perugia@alice.com', 2),
('Viva Food', 'Viterbo', 'Corso Italia, 32', 'vivafood.viterbo@gmail.com', 2),
('Hypermarket', 'Lecce', 'Via Trinchese, 88', 'hypermarket.lecce@gmail.com', 3),			-- "Beverage & Food Distribution" (Bari)
('Grocery Hub', 'Foggia', 'Piazza Cavour, 5', 'groceryhub.foggia@outlook.com', 3),
('Gusto Puro', 'Tropea', 'Via Marina, 21', 'gustopuro.tropea@libero.com', 3);



START TRANSACTION;
ALTER TABLE Warehouses
ADD COLUMN address VARCHAR(50),
ADD COLUMN email VARCHAR(40);
SELECT*FROM Warehouses;

UPDATE Warehouses SET
address = 'Via della Libertà, 10', email = 'cdc.milano@gmail.com' 
WHERE ID = 1;

UPDATE Warehouses SET
address = 'Via della Pace, 22', email = 'egw.roma@live.com' 
WHERE ID = 2;

UPDATE Warehouses SET
address = 'Viale delle Stelle, 100', email = 'bfd.bari@libero.com' 
WHERE ID = 3;

START TRANSACTION;
ALTER TABLE Stores
ADD COLUMN address VARCHAR(50) AFTER location,
ADD COLUMN email VARCHAR(40) AFTER address;
SELECT*FROM Stores;

SELECT*FROM Category;


-- Nel popolamento delle tabelle c'è stato un problema con le categorie, si sostiuiscono con i nomi corretti.
UPDATE Category SET categoryName = 'Bakery and Pastry' WHERE ID = 11;							
UPDATE Category SET categoryName = 'Snacks and Chips' WHERE ID = 9;
UPDATE Category SET categoryName = 'Wine and Liquors' WHERE ID = 17;
UPDATE Category SET categoryName = 'Breakfast and Cereals' WHERE ID = 18;
UPDATE Category SET categoryName = 'Baby Products' WHERE ID = 19;
UPDATE Category SET categoryName = 'Frozen Foods' WHERE ID = 20;



INSERT INTO Sales (storeID, salesID, lineID, productID, quantity, totalPrice) VALUES					-- DB della logistica di Vendicose 
(1, 101, 1, 1, 5, 12.50),																				
(1, 101, 2, 2, 3, 5.40),
(1, 102, 1, 3, 7, 8.40),
(2, 103, 1, 4, 4, 8.00),
(2, 103, 2, 5, 6, 9.00),
(2, 104, 1, 6, 2, 15.00),
(3, 105, 1, 7, 3, 27.00),
(3, 105, 2, 8, 5, 40.00),
(3, 106, 1, 9, 4, 16.00),
(4, 107, 1, 10, 6, 15.00),
(4, 107, 2, 11, 8, 24.00),
(4, 108, 1, 12, 2, 5.60),
(5, 109, 1, 13, 1, 7.50),
(5, 109, 2, 14, 3, 9.60),
(5, 110, 1, 15, 4, 12.80),
(6, 111, 1, 16, 5, 17.50),
(6, 111, 2, 17, 6, 24.00),
(6, 112, 1, 18, 7, 35.60),
(7, 113, 1, 19, 3, 6.00),
(7, 113, 2, 20, 5, 18.50),
(7, 114, 1, 1, 8, 20.00),
(8, 115, 1, 2, 10, 18.00),
(8, 115, 2, 3, 4, 4.80),
(8, 116, 1, 4, 6, 12.00),
(9, 117, 1, 5, 3, 6.00),
(9, 117, 2, 6, 2, 10.00),
(9, 118, 1, 7, 7, 52.50),
(1, 119, 1, 8, 1, 6.50),
(1, 119, 2, 9, 4, 8.80),
(1, 120, 1, 10, 5, 12.50),
(2, 121, 1, 11, 3, 6.60),
(2, 121, 2, 12, 8, 24.00),
(2, 122, 1, 13, 2, 6.00),
(3, 123, 1, 14, 5, 15.40),
(3, 123, 2, 15, 7, 35.00),
(3, 124, 1, 16, 9, 22.50),
(4, 125, 1, 17, 4, 19.20),
(4, 125, 2, 18, 2, 6.40),
(4, 126, 1, 19, 6, 15.00),
(5, 127, 1, 20, 3, 9.60),
(1, 128, 1, 1, 4, 10.00),
(1, 128, 2, 2, 6, 10.80),
(1, 129, 1, 3, 2, 4.40),
(2, 130, 1, 4, 8, 16.00),
(2, 130, 2, 5, 3, 4.50),
(2, 131, 1, 6, 7, 52.50),
(3, 132, 1, 7, 5, 37.50),
(3, 132, 2, 8, 4, 16.00),
(3, 133, 1, 9, 6, 24.00),
(4, 134, 1, 10, 2, 5.00),
(4, 134, 2, 11, 5, 20.00),
(4, 135, 1, 12, 4, 10.40),
(5, 136, 1, 13, 9, 67.50),
(5, 136, 2, 14, 3, 9.00),
(5, 137, 1, 15, 2, 5.60),
(6, 138, 1, 16, 6, 21.00),
(6, 138, 2, 17, 4, 16.00),
(6, 139, 1, 18, 7, 26.40),
(7, 140, 1, 19, 2, 4.80),
(7, 140, 2, 20, 3, 8.40),
(7, 141, 1, 1, 10, 25.00),
(8, 142, 1, 2, 4, 9.60),
(8, 142, 2, 3, 6, 14.40),
(8, 143, 1, 4, 2, 4.00),
(9, 144, 1, 5, 3, 9.00),
(9, 144, 2, 6, 1, 5.00),
(9, 145, 1, 7, 4, 12.00),
(1, 146, 1, 8, 7, 14.00),
(1, 146, 2, 9, 2, 4.40),
(1, 147, 1, 10, 5, 12.50),
(2, 148, 1, 11, 4, 11.20),
(2, 148, 2, 12, 8, 24.00),
(2, 149, 1, 13, 3, 9.00),
(3, 150, 1, 14, 6, 21.60),
(3, 150, 2, 15, 4, 18.00),
(3, 151, 1, 16, 5, 25.00),
(4, 152, 1, 17, 7, 19.60),
(4, 152, 2, 18, 2, 4.80),
(1, 153, 1, 20, 3, 4.50),
(1, 153, 2, 21, 5, 15.00),
(1, 154, 1, 22, 2, 3.60),
(2, 155, 1, 23, 6, 18.00),
(2, 155, 2, 24, 4, 7.60),
(2, 156, 1, 25, 5, 15.00),
(3, 157, 1, 26, 3, 9.00),
(3, 157, 2, 27, 7, 12.60),
(3, 158, 1, 28, 4, 8.80),
(4, 159, 1, 29, 8, 24.00),
(4, 159, 2, 30, 6, 13.80),
(4, 160, 1, 31, 5, 10.00),
(5, 161, 1, 32, 3, 6.00),
(5, 161, 2, 33, 2, 7.50),
(5, 162, 1, 34, 4, 10.80),
(6, 163, 1, 35, 1, 2.80),
(6, 163, 2, 36, 7, 15.40),
(6, 164, 1, 37, 6, 18.00),
(7, 165, 1, 38, 8, 16.00),
(7, 165, 2, 39, 3, 9.60),
(7, 166, 1, 40, 4, 12.00),
(8, 167, 1, 41, 2, 6.40),
(8, 167, 2, 42, 5, 10.00),
(8, 168, 1, 43, 6, 21.60),
(9, 169, 1, 44, 7, 21.00),
(9, 169, 2, 45, 2, 6.00),
(9, 170, 1, 46, 8, 24.00),
(1, 171, 1, 47, 3, 4.50),
(1, 171, 2, 48, 6, 15.60),
(1, 172, 1, 49, 5, 10.00),
(2, 173, 1, 50, 2, 6.40),
(2, 173, 2, 51, 3, 9.60),
(2, 174, 1, 52, 7, 17.50),
(3, 175, 1, 53, 4, 12.00),
(3, 175, 2, 54, 6, 18.00),
(3, 176, 1, 55, 5, 20.00),
(4, 177, 1, 56, 3, 6.90),
(4, 177, 2, 57, 8, 20.00),
(4, 178, 1, 58, 2, 5.20),
(5, 179, 1, 59, 5, 15.00),
(5, 179, 2, 60, 3, 9.00),
(5, 180, 1, 61, 4, 12.00),
(1, 181, 1, 61, 4, 12.00),
(1, 181, 2, 62, 3, 8.40),
(1, 182, 1, 63, 2, 6.40),
(2, 183, 1, 64, 5, 12.50),
(2, 183, 2, 65, 6, 19.20),
(3, 184, 1, 61, 7, 28.00),
(3, 184, 2, 62, 4, 10.80),
(4, 185, 1, 63, 2, 6.00),
(4, 185, 2, 64, 5, 12.50),
(5, 186, 1, 65, 8, 24.00),
(5, 186, 2, 61, 3, 9.00),
(6, 187, 1, 62, 4, 12.80),
(6, 187, 2, 63, 7, 21.00),
(7, 188, 1, 64, 3, 9.00),
(7, 188, 2, 65, 5, 16.00),
(8, 189, 1, 61, 6, 18.00),
(8, 189, 2, 62, 2, 5.60),
(9, 190, 1, 63, 4, 12.00),
(9, 190, 2, 64, 5, 15.00),
(9, 191, 1, 65, 3, 9.00),
(1, 192, 1, 66, 5, 15.00),
(1, 192, 2, 67, 6, 18.00),
(1, 193, 1, 68, 4, 16.00),
(1, 193, 2, 69, 3, 9.60),
(2, 194, 1, 70, 8, 24.00),
(2, 194, 2, 71, 7, 20.10),
(2, 195, 1, 72, 5, 15.00),
(3, 196, 1, 73, 6, 18.00),
(3, 196, 2, 74, 3, 9.00),
(3, 197, 1, 75, 7, 21.00),
(4, 198, 1, 76, 4, 12.00),
(4, 198, 2, 77, 8, 24.00),
(4, 199, 1, 78, 6, 18.00),
(5, 200, 1, 79, 2, 6.00),
(5, 200, 2, 80, 5, 12.50),
(5, 201, 1, 81, 3, 9.60),
(6, 202, 1, 82, 4, 12.00),
(6, 202, 2, 83, 5, 14.00),
(6, 203, 1, 84, 2, 6.80),
(7, 204, 1, 85, 7, 21.00),
(7, 204, 2, 86, 3, 9.00),
(7, 205, 1, 87, 5, 15.00),
(8, 206, 1, 88, 8, 24.00),
(8, 206, 2, 89, 4, 12.00),
(8, 207, 1, 90, 6, 18.00),
(9, 208, 1, 91, 3, 9.60),
(9, 208, 2, 92, 5, 15.00),
(9, 209, 1, 93, 4, 12.80),
(1, 210, 1, 94, 7, 21.00),
(1, 210, 2, 95, 2, 6.00),
(1, 211, 1, 96, 3, 9.00),
(2, 212, 1, 97, 5, 15.00),
(2, 212, 2, 98, 4, 12.80),
(2, 213, 1, 99, 6, 18.00),
(3, 214, 1, 97, 8, 24.00),
(3, 214, 2, 66, 4, 12.00),
(3, 215, 1, 67, 7, 21.00),
(4, 216, 1, 68, 2, 6.40),
(4, 216, 2, 69, 6, 18.00),
(4, 217, 1, 70, 5, 15.00),
(5, 218, 1, 71, 8, 24.00),
(5, 218, 2, 72, 4, 12.00),
(5, 219, 1, 73, 3, 9.00),
(6, 220, 1, 74, 2, 6.00),
(6, 220, 2, 75, 7, 21.00),
(6, 221, 1, 76, 5, 15.00),
(7, 222, 1, 77, 6, 18.00),
(7, 222, 2, 78, 3, 9.00),
(7, 223, 1, 79, 8, 24.00),
(8, 224, 1, 80, 5, 15.00),
(8, 224, 2, 81, 4, 12.00);



-- Tabella Stockleveles -- "Inventario"
INSERT INTO Stocklevels (productID, categoryID, warehouseID, stock) VALUES
(1, 1, 1, 50), (1, 1, 2, 30), (1, 1, 3, 40),  -- Apple												-- Fruits and Vegetables (ID 1)
(2, 1, 1, 60), (2, 1, 2, 20), (2, 1, 3, 50),  -- Banana
(3, 1, 1, 40), (3, 1, 2, 35), (3, 1, 3, 45),  -- Carrot
(4, 1, 1, 55), (4, 1, 2, 25), (4, 1, 3, 35),  -- Tomato
(5, 1, 1, 30), (5, 1, 2, 40), (5, 1, 3, 50),  -- Lettuce
(6, 2, 1, 25), (6, 2, 2, 30), (6, 2, 3, 35),  -- Chicken Breast										-- Meat and Poultry (ID 2)
(7, 2, 1, 20), (7, 2, 2, 40), (7, 2, 3, 30),  -- Ground Beef
(8, 2, 1, 30), (8, 2, 2, 25), (8, 2, 3, 40),  -- Pork Chops
(9, 2, 1, 35), (9, 2, 2, 30), (9, 2, 3, 25),  -- Turkey Slices
(10, 2, 1, 40), (10, 2, 2, 20), (10, 2, 3, 30), -- Sausages
(11, 3, 1, 15), (11, 3, 2, 20), (11, 3, 3, 25), -- Salmon Fillet									-- Fish and Seafood (ID 3)
(12, 3, 1, 20), (12, 3, 2, 15), (12, 3, 3, 30), -- Tuna Steak
(13, 3, 1, 25), (13, 3, 2, 20), (13, 3, 3, 15), -- Shrimps
(14, 3, 1, 30), (14, 3, 2, 25), (14, 3, 3, 20), -- Cod Fillet
(15, 3, 1, 20), (15, 3, 2, 30), (15, 3, 3, 25), -- Mussels
(16, 4, 1, 50), (16, 4, 2, 40), (16, 4, 3, 60), -- Milk												-- Dairy and Eggs (ID 4)
(17, 4, 1, 40), (17, 4, 2, 50), (17, 4, 3, 30), -- Butter
(18, 4, 1, 30), (18, 4, 2, 40), (18, 4, 3, 50), -- Cheddar Cheese
(19, 4, 1, 50), (19, 4, 2, 30), (19, 4, 3, 40), -- Greek Yogurt
(20, 4, 1, 60), (20, 4, 2, 50), (20, 4, 3, 40), -- Dozen Eggs
(21, 5, 1, 35), (21, 5, 2, 25), (21, 5, 3, 30), -- Ham												-- Cold Cuts and Deli (ID 5)
(22, 5, 1, 30), (22, 5, 2, 35), (22, 5, 3, 25), -- Salami
(23, 5, 1, 25), (23, 5, 2, 30), (23, 5, 3, 35), -- Prosciutto
(24, 5, 1, 30), (24, 5, 2, 25), (24, 5, 3, 40), -- Mortadella
(25, 5, 1, 40), (25, 5, 2, 30), (25, 5, 3, 25), -- Turkey Breast Slices
(26, 6, 1, 50), (26, 6, 2, 40), (26, 6, 3, 60), -- Baguette											-- Bread and Bakery (ID 6)
(27, 6, 1, 40), (27, 6, 2, 50), (27, 6, 3, 30), -- Whole Wheat Bread
(28, 6, 1, 30), (28, 6, 2, 40), (28, 6, 3, 50), -- Croissant
(29, 6, 1, 50), (29, 6, 2, 30), (29, 6, 3, 40), -- Muffin
(30, 6, 1, 60), (30, 6, 2, 50), (30, 6, 3, 40), -- Ciabatta
(31, 7, 1, 70), (31, 7, 2, 60), (31, 7, 3, 80), -- Spaghetti										-- Pasta, Rice, and Cereals (ID 7)
(32, 7, 1, 60), (32, 7, 2, 70), (32, 7, 3, 50), -- Basmati Rice
(33, 7, 1, 50), (33, 7, 2, 60), (33, 7, 3, 70), -- (Cornflakes)X Paccheri
(34, 7, 1, 70), (34, 7, 2, 50), (34, 7, 3, 60), -- Quinoa
(35, 7, 1, 80), (35, 7, 2, 70), (35, 7, 3, 60), -- Oatmeal
(36, 8, 1, 45), (36, 8, 2, 55), (36, 8, 3, 65), -- Canned Chickpeas									-- Canned Legumes and Vegetables (ID 8)
(37, 8, 1, 55), (37, 8, 2, 45), (37, 8, 3, 75), -- Canned Lentils
(38, 8, 1, 65), (38, 8, 2, 55), (38, 8, 3, 45), -- Canned Tomatoes
(39, 8, 1, 75), (39, 8, 2, 65), (39, 8, 3, 55), -- Canned Corn
(40, 8, 1, 45), (40, 8, 2, 75), (40, 8, 3, 65), -- Canned Peas
(41, 9, 1, 80), (41, 9, 2, 70), (41, 9, 3, 90), -- Potato Chips										-- Snacks and Chips (ID 9)
(42, 9, 1, 70), (42, 9, 2, 80), (42, 9, 3, 60), -- Tortilla Chips
(43, 9, 1, 60), (43, 9, 2, 70), (43, 9, 3, 80), -- Salted Peanuts
(44, 9, 1, 80), (44, 9, 2, 60), (44, 9, 3, 70), -- Mixed Nuts
(45, 9, 1, 90), (45, 9, 2, 80), (45, 9, 3, 70), -- Pretzels
(46, 10, 1, 50), (46, 10, 2, 60), (46, 10, 3, 70), -- Tomato Sauce
(47, 10, 1, 60), (47, 10, 2, 50), (47, 10, 3, 80), -- Mayonnaise
(48, 10, 1, 70), (48, 10, 2, 60), (48, 10, 3, 50), -- Ketchup
(49, 10, 1, 80), (49, 10, 2, 70), (49, 10, 3, 60), -- Mustard
(50, 10, 1, 50), (50, 10, 2, 80), (50, 10, 3, 70), -- Soy Sauce
(51, 11, 1, 30), (51, 11, 2, 40), (51, 11, 3, 50), -- Chocolate Cake								-- Bakery and Pastry (ID 11)
(52, 11, 1, 40), (52, 11, 2, 30), (52, 11, 3, 60), -- Apple Pie
(53, 11, 1, 50), (53, 11, 2, 40), (53, 11, 3, 30), -- (Croissant)X Cheescake
(54, 11, 1, 60), (54, 11, 2, 50), (54, 11, 3, 40), -- Donuts
(55, 11, 1, 30), (55, 11, 2, 60), (55, 11, 3, 50), -- Pound Cake
(56, 12, 1, 70), (56, 12, 2, 60), (56, 12, 3, 80), -- Dark Chocolate								-- Sweets and Chocolate (ID 12)
(57, 12, 1, 60), (57, 12, 2, 70), (57, 12, 3, 50), -- Milk Chocolate
(58, 12, 1, 50), (58, 12, 2, 60), (58, 12, 3, 70), -- Hazelnut Spread
(59, 12, 1, 70), (59, 12, 2, 50), (59, 12, 3, 60), -- Gummy Bears
(60, 12, 1, 80), (60, 12, 2, 70), (60, 12, 3, 60), -- Marshmallows
(61, 13, 1, 90), (61, 13, 2, 80), (61, 13, 3, 70), -- Orange Juice									-- Non-Alcoholic Beverages (ID 13)
(62, 13, 1, 80), (62, 13, 2, 90), (62, 13, 3, 60), -- Cola
(63, 13, 1, 70), (63, 13, 2, 80), (63, 13, 3, 90), -- Lemon Iced Tea
(64, 13, 1, 60), (64, 13, 2, 70), (64, 13, 3, 80), -- Sparkling Water
(65, 13, 1, 90), (65, 13, 2, 60), (65, 13, 3, 70), -- Apple Juice
(66, 14, 1, 80), (66, 14, 2, 70), (66, 14, 3, 90), -- Mineral Water									-- Water and Fruit Juices (ID 14)
(67, 14, 1, 70), (67, 14, 2, 80), (67, 14, 3, 60), -- Spring Water
(68, 14, 1, 60), (68, 14, 2, 70), (68, 14, 3, 80), -- Peach Juice
(69, 14, 1, 80), (69, 14, 2, 60), (69, 14, 3, 70), -- Pineapple Juice
(70, 14, 1, 90), (70, 14, 2, 80), (70, 14, 3, 60), -- Grapefruit Juice
(71, 15, 1, 50), (71, 15, 2, 60), (71, 15, 3, 70), -- Ground Coffee									-- Coffee, Tea, and Infusions (ID 15)
(72, 15, 1, 60), (72, 15, 2, 50), (72, 15, 3, 80), -- Instant Coffee
(73, 15, 1, 70), (73, 15, 2, 60), (73, 15, 3, 50), -- Green Tea
(74, 15, 1, 80), (74, 15, 2, 70), (74, 15, 3, 60), -- Chamomile Tea
(75, 15, 1, 50), (75, 15, 2, 80), (75, 15, 3, 70), -- Black Tea
(76, 16, 1, 40), (76, 16, 2, 50), (76, 16, 3, 60), -- Lager Beer									-- Beer and Alcoholic Beverages (ID 16)
(77, 16, 1, 50), (77, 16, 2, 40), (77, 16, 3, 70), -- IPA Beer
(78, 16, 1, 60), (78, 16, 2, 50), (78, 16, 3, 40), -- Stout Beer
(79, 16, 1, 70), (79, 16, 2, 60), (79, 16, 3, 50), -- Whiskey
(80, 16, 1, 40), (80, 16, 2, 70), (80, 16, 3, 60), -- Rum
(81, 17, 1, 30), (81, 17, 2, 40), (81, 17, 3, 50), -- Red Wine										-- Wine and Liquors (ID 17)
(82, 17, 1, 40), (82, 17, 2, 30), (82, 17, 3, 60), -- White Wine
(83, 17, 1, 50), (83, 17, 2, 40), (83, 17, 3, 30), -- Rosé Wine
(84, 17, 1, 60), (84, 17, 2, 50), (84, 17, 3, 40), -- Champagne
(85, 17, 1, 30), (85, 17, 2, 60), (85, 17, 3, 50), -- Limoncello
(86, 18, 1, 70), (86, 18, 2, 60), (86, 18, 3, 80), -- Muesli										-- Breakfast and Cereals (ID 18)
(87, 18, 1, 60), (87, 18, 2, 70), (87, 18, 3, 50), -- Granola
(88, 18, 1, 50), (88, 18, 2, 60), (88, 18, 3, 70), -- Cornflakes
(89, 18, 1, 70), (89, 18, 2, 50), (89, 18, 3, 60), -- Oat Flakes
(90, 18, 1, 80), (90, 18, 2, 70), (90, 18, 3, 60), -- Chocolate Cereal
(91, 19, 1, 40), (91, 19, 2, 50), (91, 19, 3, 60), -- Baby Formula									-- Baby Products (ID 19)
(92, 19, 1, 50), (92, 19, 2, 40), (92, 19, 3, 70), -- Baby Wipes
(93, 19, 1, 60), (93, 19, 2, 50), (93, 19, 3, 40), -- Diapers
(94, 19, 1, 70), (94, 19, 2, 60), (94, 19, 3, 50), -- Baby Shampoo
(95, 19, 1, 40), (95, 19, 2, 70), (95, 19, 3, 60), -- Baby Food Jar
(96, 20, 1, 30), (96, 20, 2, 40), (96, 20, 3, 50), -- Frozen Peas									-- Frozen Foods (ID 20)
(97, 20, 1, 40), (97, 20, 2, 30), (97, 20, 3, 60), -- Frozen Pizza
(98, 20, 1, 50), (98, 20, 2, 40), (98, 20, 3, 30), -- Vanilla Ice Cream
(99, 20, 1, 60), (99, 20, 2, 50), (99, 20, 3, 40), -- Frozen Chicken Nuggets
(100, 20, 1, 30), (100, 20, 2, 60), (100, 20, 3, 50); -- Frozen Mixed Berries
--  Valore di stock assegnato casualmente tra 0 e 100 per ogni combinazione di prodotto, categoria e magazzino.

SELECT*FROM Stocklevels;

SHOW CREATE TABLE Stocklevels;
BEGIN;
ALTER TABLE Stocklevels DROP COLUMN categoryID;
COMMIT;

-- --------------------- --------------------- --------------------- --------------------- --------------------- ---------------------
-- Sono stati restituiti dei PRODOTTI DOPPI.
-- Croissant:
-- ('Croissant', '80g piece', 1.50, 6) -- Bread and Bakery (ID 6)
-- ('Croissant', '80g piece', 1.80, 11) -- Bakery and Pastry (ID 11).  -- Cheescake ID 53
-- Cornflakes:
-- ('Cornflakes', '500g box', 4.00, 7) -- Pasta, Rice, and Cereals (ID 7).  -- Paccheri ID = 33;
-- ('Cornflakes', '500g box', 3.80, 18) -- Breakfast and Cereals (ID 18)

SELECT ID, productName, categoryID FROM Product WHERE productName LIKE 'Apple%';
-- 
-- Si sostiuiscono con ulteriori prodotti.
UPDATE Product SET productName = 'Cheescake' WHERE ID = 53;							
UPDATE Product SET productName = 'Paccheri' WHERE ID = 33;

-- ESEMPIO di funnzionamento del sistema: aggiungiamo una vendita -
INSERT INTO Sales (storeID, salesID, lineID, productID, quantity, totalPrice) VALUES
(1, 225, 1, 1, 10, 25);

-- Aggiungiamo un CHECK della quantità massima che si può vendere per Prodotto su ogni vendita.
ALTER TABLE Product ADD COLUMN maxQuantity INT AFTER maxUnitSalesPrice;

-- Si popola la colonna maxQuantity di Product.
UPDATE Product SET maxQuantity = 15;
SELECT*FROM Product;


-- Aggiungiamo Trigger per controllare la quantità max dei prodotti venduti in Sales.
START TRANSACTION;
DELIMITER //

CREATE TRIGGER check_quantity_before_insert
BEFORE INSERT ON Sales
FOR EACH ROW
BEGIN
    DECLARE max_qty INT;

    -- Si ottiene il valore di maxQuantity dalla tabella Product
    SELECT maxQuantity INTO max_qty FROM Product
    WHERE ID = NEW.productID;
    -- Si controlla se la quantità inserita supera maxQuantity
    IF NEW.quantity > max_qty THEN									-- max_qty = maxQuantity di Product
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La quantità inserita supera la quantità massima consentita per questo prodotto.';
    END IF;
END;

//

DELIMITER ;

INSERT INTO Sales (storeID, salesID, lineID, productID, quantity, totalPrice) VALUES					-- Restituisce ERRORE (Perchè q.tà > di 15)
(1, 226, 1, 1, 16, 25);
INSERT INTO Sales (storeID, salesID, lineID, productID, quantity, totalPrice) VALUES					-- Vendita inserita (q.tà <= 15)
(3, 226, 1, 1, 15, 25);
COMMIT;



-- Si aggiunge alla tabella Sales la colonna 'unitPrice'
ALTER TABLE Sales ADD COLUMN unitPrice DECIMAL(8,2) AFTER productID;

UPDATE Sales AS S
JOIN Product AS P ON S.productID = P.ID
SET S.unitPrice = P.maxUnitSalesPrice;

-- Si aggiunge anche una colonna Sc/ per situazioni future.
START TRANSACTION;
ALTER TABLE Sales ADD COLUMN discountedPercentage DECIMAL(5,4) AFTER unitPrice; 	
ALTER TABLE Sales MODIFY discountedPercentage DECIMAL(3,2);				
UPDATE Sales SET totalPrice = (unitPrice*quantity*(1-IFNULL(discountedPercentage, 0)));					-- (Prezzo * (1-discountedPercentage))

INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, discountedPercentage, quantity) VALUES					
(1, 116, 1, '2025-02-25', 1, 2.50, 0.5000, 2);

INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, discountedPercentage, quantity) VALUES					
(1, 230, 1, '2025-02-24', 2, 1.80, 0.70, 5);


SELECT*FROM Sales;
COMMIT;

-- Si aggiunge alla tabella Sales la colonna  'salesDate' (le date dovranno essere distribuite nei vari negozi per gli stessi giorni)
ALTER TABLE Sales ADD COLUMN salesDate DATE AFTER lineID;
START TRANSACTION;
UPDATE Sales
SET salesDate = '2025-02-24';
SELECT*FROM Sales;
COMMIT;

START TRANSACTION;
UPDATE StockLevels AS SL
JOIN Product AS P ON P.ID = SL.productID 
JOIN Category AS C ON C.ID = P.categoryID 
SET stock = (restockLevel + 10);			

SELECT P.ID, C.restockLevel, SL.stock 
FROM StockLevels AS SL
JOIN Product AS P ON P.ID = SL.productID 
JOIN Category AS C ON C.ID = P.categoryID;
COMMIT;


-- Aggiungiamo altre vendite in altre date --
INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, quantity, totalPrice) VALUES
(1, 101, 1, '2025-02-25', 5, 2.50, 3, 7.50),   -- Lettuce
(2, 102, 1, '2025-02-25', 12, 8.00, 2, 16.00), -- Tuna Steak
(3, 103, 1, '2025-02-25', 20, 3.00, 5, 15.00), -- Dozen Eggs
(1, 104, 2, '2025-02-25', 35, 4.50, 4, 18.00), -- Oatmeal
(2, 105, 2, '2025-02-25', 45, 2.00, 10, 20.00), -- Pretzels
(3, 106, 2, '2025-02-25', 56, 5.00, 3, 15.00), -- Dark Chocolate
(1, 107, 3, '2025-02-25', 61, 1.50, 6, 9.00),  -- Orange Juice
(2, 108, 3, '2025-02-25', 70, 2.00, 4, 8.00),  -- Grapefruit Juice
(3, 109, 3, '2025-02-25', 76, 3.50, 2, 7.00),  -- Lager Beer
(1, 110, 4, '2025-02-25', 90, 6.00, 1, 6.00),  -- Chocolate Cereal
-- Vendita 110 con 3 prodotti
(1, 110, 1, '2025-02-25', 3, 1.20, 5, 6.00),   -- Carrot
(1, 110, 2, '2025-02-25', 7, 5.00, 2, 10.00),  -- Ground Beef
(1, 110, 3, '2025-02-25', 15, 4.00, 3, 12.00), -- Mussels
-- Vendita 111 con 2 prodotti
(2, 111, 1, '2025-02-25', 22, 3.50, 4, 14.00), -- Salami
(2, 111, 2, '2025-02-25', 30, 2.50, 6, 15.00), -- Ciabatta
-- Vendita 112 con 3 prodotti
(3, 112, 1, '2025-02-25', 37, 1.80, 5, 9.00),  -- Canned Lentils
(3, 112, 2, '2025-02-25', 44, 3.00, 3, 9.00),  -- Mixed Nuts
(3, 112, 3, '2025-02-25', 50, 2.00, 5, 10.00), -- Soy Sauce
-- Vendita 113 con 2 prodotti
(1, 113, 1, '2025-02-25', 55, 4.50, 2, 9.00),  -- Pound Cake
(1, 113, 2, '2025-02-25', 60, 3.00, 4, 12.00), -- Marshmallows
-- Vendita 114 con 3 prodotti
(2, 114, 1, '2025-02-25', 65, 1.50, 6, 9.00),  -- Apple Juice
(2, 114, 2, '2025-02-25', 70, 2.00, 3, 6.00),  -- Grapefruit Juice
(2, 114, 3, '2025-02-25', 75, 2.50, 4, 10.00), -- Black Tea
-- Vendita 115 con 2 prodotti
(3, 115, 1, '2025-02-25', 80, 4.00, 2, 8.00),  -- Rum
(3, 115, 2, '2025-02-25', 85, 3.50, 3, 10.50); -- Limoncello


-- Mancanti per line ID 
INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, quantity, totalPrice) VALUES
(1, 104, 1, '2025-02-25', 44, 4.50, 4, 18.00),
(2, 105, 1, '2025-02-25', 4, 2.00, 10, 20.00),
(3, 106, 1, '2025-02-25', 34, 5.00, 3, 15.00),
(1, 107, 1, '2025-02-25', 36, 1.50, 6, 9.00),
(1, 107, 2, '2025-02-25', 5, 1.50, 6, 9.00), 
(2, 108, 1, '2025-02-25', 60, 2.30, 4, 9.20),
(2, 108, 2, '2025-02-25', 64, 1.80, 4, 7.20),
(3, 109, 1, '2025-02-25', 54, 3.50, 2, 7.00), 
(3, 109, 2, '2025-02-25', 17, 2.50, 2, 5.00);


-- Si aggiunge un trigger per il controllo dello 'stock' nell'entità Stocklevels. Il controllo verrebbe eseguito qualora si aggiungesse un nuovo prodotto con il suo livello di stock in un magazzino.
START TRANSACTION;
DELIMITER //

CREATE TRIGGER check_stock_before_insert
BEFORE INSERT ON StockLevels
FOR EACH ROW
BEGIN
    DECLARE max_stock INT;
    -- Si Ottiene il valore di restockLevel dalla tabella Category
    SELECT restockLevel INTO max_stock
    FROM Category JOIN Product ON Product.categoryID = Category.ID
    WHERE Product.ID = NEW.productID;					 					    -- deve essere Product.ID -> per capire da quale tabella deriva
    -- Si controlla se lo stock inserito supera il restockLevel
    IF NEW.stock < max_stock THEN												-- max_stock = restockLevel di Category
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lo stock inserito è inferiore al restocklevel consensito per questo prodotto.';
    END IF;
END;

//

DELIMITER ;

DROP TRIGGER IF EXISTS check_stock_before_insert;		

-- Prova di inserimento dati con stock < di restockLevel.
INSERT INTO Product (productName, descrizione, maxUnitSalesPrice, maxQuantity, categoryID) VALUES
('Cherry', 'Fresh red cherries', '1.20', '15', '1');
INSERT INTO Stocklevels (productID, warehouseID, stock) VALUES
(101, 1, 30);																		-- Restituisce ERRORE (Perchè stock è < di restockLevel)
DELETE FROM Product WHERE ID = 101;

SHOW TRIGGERS;


-- ------------ Altre vendite con data odierna (2025-02-25).
INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, quantity, totalPrice) VALUES
(1, 101, 1, '2025-02-28', 3, 1.20, 2, 2.40),
(1, 101, 2, '2025-02-28', 7, 7.50, 1, 7.50),
(1, 101, 3, '2025-02-28', 12, 15.00, 1, 15.00),
(3, 102, 1, '2025-02-28', 5, 1.50, 3, 4.50),
(3, 102, 2, '2025-02-28', 9, 6.50, 2, 13.00),
(3, 102, 3, '2025-02-28', 14, 8.50, 1, 8.50),
(2, 103, 1, '2025-02-28', 16, 1.50, 4, 6.00),
(2, 103, 2, '2025-02-28', 18, 4.80, 1, 4.80),
(2, 103, 3, '2025-02-28', 20, 3.50, 2, 7.00),
(8, 104, 1, '2025-02-28', 22, 5.00, 1, 5.00),
(8, 104, 2, '2025-02-28', 25, 2.50, 3, 7.50),
(8, 104, 3, '2025-02-28', 28, 2.20, 2, 4.40),
(4, 105, 1, '2025-02-28', 30, 3.20, 1, 3.20),
(4, 105, 2, '2025-02-28', 33, 4.50, 1, 4.50),
(4, 105, 3, '2025-02-28', 35, 2.30, 3, 6.90),
(6, 106, 1, '2025-02-28', 37, 3.00, 2, 6.00),
(6, 106, 2, '2025-02-28', 40, 1.80, 4, 7.20),
(6, 106, 3, '2025-02-28', 42, 2.90, 1, 2.90),
(5, 107, 1, '2025-02-28', 44, 3.20, 1, 3.20),
(5, 107, 2, '2025-02-28', 46, 5.50, 1, 5.50),
(5, 107, 3, '2025-02-28', 48, 2.50, 2, 5.00),
(9, 108, 1, '2025-02-28', 50, 3.00, 1, 3.00),
(9, 108, 2, '2025-02-28', 52, 3.50, 2, 7.00),
(9, 108, 3, '2025-02-28', 54, 3.80, 1, 3.80),
(6, 109, 1, '2025-02-28', 56, 25.00, 1, 25.00),
(6, 109, 2, '2025-02-28', 58, 20.00, 1, 20.00),
(6, 109, 3, '2025-02-28', 60, 12.00, 1, 12.00),
(3, 110, 1, '2025-02-28', 62, 10.00, 1, 10.00),
(3, 110, 2, '2025-02-28', 64, 11.00, 1, 11.00),
(3, 110, 3, '2025-02-28', 66, 30.00, 1, 30.00),
(7, 111, 1, '2025-02-28', 68, 15.00, 1, 15.00),
(7, 111, 2, '2025-02-28', 70, 4.50, 2, 9.00),
(7, 111, 3, '2025-02-28', 72, 4.80, 1, 4.80),
(1, 112, 1, '2025-02-28', 74, 3.80, 1, 3.80),
(1, 112, 2, '2025-02-28', 76, 3.20, 2, 6.40),
(1, 112, 3, '2025-02-28', 78, 4.00, 1, 4.00),
(4, 113, 1, '2025-02-28', 80, 15.00, 1, 15.00),
(4, 113, 2, '2025-02-28', 82, 4.00, 3, 12.00),
(4, 113, 3, '2025-02-28', 84, 12.50, 1, 12.50),
(8, 114, 1, '2025-02-28', 86, 5.50, 1, 5.50),
(8, 114, 2, '2025-02-28', 88, 2.00, 4, 8.00),
(8, 114, 3, '2025-02-28', 90, 3.50, 2, 7.00),
(7, 115, 1, '2025-02-28', 92, 4.80, 1, 4.80),
(7, 115, 2, '2025-02-28', 94, 5.00, 1, 5.00),
(7, 115, 3, '2025-02-28', 96, 6.50, 1, 6.50),
(2, 116, 1, '2025-02-28', 98, 4.20, 2, 8.40),
(2, 116, 2, '2025-02-28', 100, 3.50, 1, 3.50),
(3, 117, 1, '2025-02-28', 2, 1.80, 3, 5.40),
(3, 117, 2, '2025-02-28', 6, 9.00, 1, 9.00),
(3, 117, 3, '2025-02-28', 10, 5.80, 2, 11.60),
(2, 118, 1, '2025-02-28', 13, 14.00, 1, 14.00),
(2, 118, 2, '2025-02-28', 17, 2.50, 4, 10.00),
(2, 118, 3, '2025-02-28', 19, 3.20, 1, 3.20),
(1, 119, 1, '2025-02-28', 21, 4.50, 2, 9.00),
(1, 119, 2, '2025-02-28', 24, 2.80, 3, 8.40),
(1, 119, 3, '2025-02-28', 27, 1.80, 2, 3.60),
(8, 120, 1, '2025-02-28', 29, 5.00, 1, 5.00),
(8, 120, 2, '2025-02-28', 31, 1.50, 4, 6.00),
(8, 120, 3, '2025-02-28', 34, 2.20, 2, 4.40),
(7, 121, 1, '2025-02-28', 36, 2.30, 3, 6.90),
(7, 121, 2, '2025-02-28', 38, 3.00, 1, 3.00),
(7, 121, 3, '2025-02-28', 41, 1.80, 2, 3.60),
(6, 122, 1, '2025-02-28', 43, 3.20, 1, 3.20),
(6, 122, 2, '2025-02-28', 45, 5.50, 1, 5.50),
(6, 122, 3, '2025-02-28', 47, 2.50, 2, 5.00),
(9, 123, 1, '2025-02-28', 49, 3.00, 1, 3.00),
(9, 123, 2, '2025-02-28', 51, 3.50, 2, 7.00);
INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, quantity, totalPrice) VALUES
(1, 124, 1, '2025-02-28', 3, 1.20, 2, 2.40),
(1, 124, 2, '2025-02-28', 7, 7.50, 1, 7.50);
INSERT INTO Sales (storeID, salesID, lineID, salesDate, productID, unitPrice, quantity, totalPrice) VALUES
(1, 124, 3, '2025-02-28', 7, 7.50, 1, 7.50);


