--1) Update the categoryName From “Beverages” to "Drinks" in the categories table.
UPDATE categories 
SET categoryname = 'Drinks'  
WHERE categoryname = 'Beverages';
SELECT * FROM categories;
 
--2)Insert into shipper new record (give any values) Delete that new record from shippers table.
INSERT INTO shippers (shippersid, shippersname)
VALUES (4, 'Bulk Shipping');
SELECT * FROM shippers;
DELETE FROM shippers 
WHERE shippersid = 4;

/*3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)*/
ALTER TABLE product
DROP CONSTRAINT IF EXISTS product_categoryid_fkey;

ALTER TABLE product
ADD CONSTRAINT product_categoryid_fkey
FOREIGN KEY (categoryid)
REFERENCES categories(categoryid)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories 
SET categoryid = 1001
WHERE categoryid = 1;
SELECT * FROM categories WHERE categoryid = 1001;
SELECT * FROM product WHERE categoryid = 1001;

ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS order_details_productid_fkey;

ALTER TABLE order_details
ADD CONSTRAINT order_details_productid_fkey
FOREIGN KEY (productid)
REFERENCES product(productid)
ON UPDATE CASCADE
ON DELETE CASCADE;


DELETE FROM categories
WHERE categoryid = 3;
SELECT * FROM product WHERE categoryid = 3;

--4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should
--be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
 
ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey;

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON DELETE SET NULL; 

DELETE FROM customers 
WHERE customerid = 'VINET';
SELECT * FROM customers WHERE customerid = 'VINET';
SELECT * FROM orders WHERE customerid = 'VINET';

--5)Insert the following data to Products using UPSERT:
/*product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, 
--discontinued = 0, categoryID=3*/

INSERT INTO product (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', 1, 13, 0, 5)
ON CONFLICT (productid)
DO UPDATE 
SET productname = 'Wheat bread',
	quantityperunit = '1',
	unitprice = 13,
	discontinued = 0,
	categoryid = 5;

/*product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, 
discontinued = 0, categoryID=5*/

INSERT INTO product (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (101, 'White bread', '5 boxes', 13, 0, 5)
ON CONFLICT (productid)
DO UPDATE 
SET productname = 'White bread',
	quantityperunit = '5 boxes',
	unitprice = 13,
	discontinued = 0,
	categoryid = 5;

/*product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
(this should update the quantityperunit for product_id = 100)*/

INSERT INTO product (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '10 boxes', 13, 0, 5)
ON CONFLICT (productid)
DO UPDATE 
SET productname = 'Wheat bread',
	quantityperunit = '10 boxes',
	unitprice = 13,
	discontinued = 0,
	categoryid = 5;
	
SELECT * FROM product 
WHERE productid IN(100, 101);

/*6)      Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:*/

CREATE TABLE updated_products(
productID INT PRIMARY KEY,
productName VARCHAR(50) ,
quantityPerUnit text,
unitPrice float,
discontinued int,
categoryID int);

INSERT INTO updated_products(productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES (100,'Wheat bread',	10, 20, 1, 3),
		(101,'White bread',	'5 boxes', 19.99, 0, 3),
		(102,'Midnight Mango Fizz',	'24 - 12 oz bottles',19,0,	1),
		(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);

SELECT * FROM updated_products;

MERGE INTO product p
USING (
		VALUES (100,'Wheat bread',	10, 20, 1, 3),
		(101,'White bread',	'5 boxes', 19.99, 0, 3),
		(102,'Midnight Mango Fizz',	'24 - 12 oz bottles',19,0,	1),
		(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2)
		)
AS updated_products (productID ,productName, quantityPerUnit, unitPrice, discontinued, categoryID)
ON p.productid = updated_product.productID
WHEN MATCHED AND updated_products = 1 THEN
DELETE
WHEN MATCHED AND updated_products = 0 THEN
UPDATE SET
unitprice = updated_products.unitprice,
discontinued = updated_products.discontinued
WHEN NOT MATCHED updated_products.discontinued = 0 THEN
INSERT productid, productname, quanitytperunit, unitprice, discontinued, categoryid
VALUES (updated_products.productid,updated_products.productname, updated_products.quantityperunit, updated_products.unitprice, updated_products.discontinued, updated_products.categoryid);


/*MERGE INTO product AS p
USING (
    VALUES 
        (100, 'Wheat bread', '10', 20, 1, 5),
        (101, 'White bread', '5 boxes', 19.99, 0, 5),
        (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
        (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2)
) AS u(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
ON p.productid = u.productid

-- When a match is found and the new row is marked discontinued
WHEN MATCHED AND u.discontinued = 1 THEN
    DELETE

-- When a match is found and the new row is active
WHEN MATCHED AND u.discontinued = 0 THEN
    UPDATE SET 
        unitprice = u.unitprice,
        discontinued = u.discontinued,
        quantityperunit = u.quantityperunit,
        productname = u.productname,
        categoryid = u.categoryid

-- When there is no match and the row is active
WHEN NOT MATCHED AND u.discontinued = 0 THEN
    INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
    VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid);*/
 
 /*Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 

If there are matching products and updated_products .discontinued =1 then delete 
 
 Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

