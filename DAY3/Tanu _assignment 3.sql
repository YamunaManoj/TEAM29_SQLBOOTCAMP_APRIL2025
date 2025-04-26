-- 1) Update "Beverages" to "Drinks" in categories table
UPDATE categories
SET categoryname = 'Drinks'
WHERE categoryname = 'Beverages';

SELECT * FROM categories;

-- 2) Insert a new shipper and then delete it
INSERT INTO shippers (shippersid, shippersname)
VALUES (4, 'Bulk Shipping');

SELECT * FROM shippers;

DELETE FROM shippers
WHERE shippersid = 4;

-- 3) Update categoryID 1 to 1001 and cascade changes to products
--    Also delete categoryID 3 and verify cascade delete
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

-- 4) Delete customer "VINET" and set customerID to NULL in orders
ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_customerid_fkey;

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON DELETE SET NULL;

DELETE FROM customers
WHERE customerid = 'VINET';

SELECT * FROM customers WHERE customerid = 'VINET';
SELECT * FROM orders WHERE customerid IS NULL;

-- 5) UPSERT into product table
-- Insert or Update Wheat bread (productid=100)
INSERT INTO product (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '1', 13, 0, 5)
ON CONFLICT (productid)
DO UPDATE SET
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryid = EXCLUDED.categoryid;

-- Insert or Update White bread (productid=101)
INSERT INTO product (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (101, 'White bread', '5 boxes', 13, 0, 5)
ON CONFLICT (productid)
DO UPDATE SET
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryid = EXCLUDED.categoryid;

-- Update quantityperunit for productid=100
INSERT INTO product (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '10 boxes', 13, 0, 5)
ON CONFLICT (productid)
DO UPDATE SET
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryid = EXCLUDED.categoryid;

SELECT * FROM product
WHERE productid IN (100, 101);

-- 6) MERGE using temp table "updated_products"
-- Create temp table
CREATE TABLE updated_products (
    productid INT PRIMARY KEY,
    productname VARCHAR(50),
    quantityperunit TEXT,
    unitprice FLOAT,
    discontinued INT,
    categoryid INT
);

-- Insert values into temp table
INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES 
    (100, 'Wheat bread', '10', 20, 1, 3),
    (101, 'White bread', '5 boxes', 19.99, 0, 3),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);

SELECT * FROM updated_products;

-- Perform the MERGE operation
MERGE INTO product AS p
USING updated_products AS u
ON p.productid = u.productid

WHEN MATCHED AND u.discontinued = 1 THEN
    DELETE

WHEN MATCHED AND u.discontinued = 0 THEN
    UPDATE SET
        p.productname = u.productname,
        p.quantityperunit = u.quantityperunit,
        p.unitprice = u.unitprice,
        p.discontinued = u.discontinued,
        p.categoryid = u.categoryid

WHEN NOT MATCHED BY TARGET AND u.discontinued = 0 THEN
    INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
    VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid);
