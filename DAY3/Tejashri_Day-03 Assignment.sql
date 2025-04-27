update categories
set categoryName = 'Drinks'
where categoryName = 'Beverages';

SELECT * FROM categories;


INSERT INTO shippers (shipperID,companyName)
VALUES (4,'Express Packages');

SELECT * FROM shippers;

Delete from shippers 
where shipperID = '4';


Alter Table products
Drop Constraint If Exists products_categoryid_fkey;

Alter Table products
Add constraint products_categoryid_fkey
Foreign Key(categoryID)
References categories(categoryID)
On Update Cascade
On Delete Cascade;



update categories
set categoryID = 1001
where categoryID = 1;


select * from categories where categoryID = 1001;
select * from products  where categoryID = 1001;

Insert into customers
values('VNET', 'ABC Company', 'Rao' , 'Manager', 'New York', 'USA')


INSERT INTO orders (orderID,customerID,employeeID,orderDate,requiredDate,shippedDate,shipperID,freight)
VALUES (10239,'VNET',2,'2015-07-04','2015-08-05', '2015-09-16', 2, 32.38),
(10237,'VNET',5,'2018-06-04' ,'2017-03-05','2012-03-16', 2, 38.48),
(10240,'VNET',6,'2018-06-04' ,'2016-02-12','2012-08-22', 2, 54.08)


UPDATE orders
SET customerid = 'VNET' where orderid in (10239,10237,10240)


ALTER TABLE orders
ALTER COLUMN customerID DROP NOT NULL;

SELECT * FROM customers WHERE customerID = 'VNET';
SELECT * FROM orders WHERE customerID = 'VNET';





ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_customerID_fkey;

ALTER TABLE orders
Add CONSTRAINT orders_customerid_fkey
Foreign Key(customerID)
References customers(customerID)
On Delete Set Null;

DELETE from customers
WHERE customerid='VNET';


SELECT * FROM customers where customerID = 'VNET';

select * from orders where customerID is Null;


INSERT INTO Products (ProductID, productName, quantityPerUnit, unitPrice,discontinued,categoryID), 
VALUES (100, 'Wheat bread',1,13,0,3),
(101, '= White bread',5,13,0,3)
ON CONFLICT (ProductID) 
DO UPDATE SET 
    productName = EXCLUDED.productName, 
    unitPrice = EXCLUDED.unitPrice, 
    quantityPerUnit = EXCLUDED.quantityPerUnit,
VALUES(100,'Wheat Bread, 1, 13,0,3);


INSERT INTO Products (ProductID, productName, quantityPerUnit, unitPrice,discontinued,categoryID)
VALUES(101,'White Bread', 5,13,'0',3)
ON CONFLICT (ProductID) 
DO UPDATE SET 
productName = EXCLUDED.productName, 
quantityPerUnit = EXCLUDED.quantityPerUnit, 
unitPrice = EXCLUDED. unitPrice,
discontinued = EXCLUDED.discontinued,
categoryid = EXCLUDED.categoryid;

INSERT INTO Products (ProductID, productName, quantityPerUnit, unitPrice,discontinued,categoryID)
VALUES(100,'Wheat Bread', 1,13,'0',3)
ON CONFLICT (ProductID) 
DO UPDATE SET 
productName = EXCLUDED.productName, 
quantityPerUnit = EXCLUDED.quantityPerUnit, 
unitPrice = EXCLUDED. unitPrice,
discontinued = EXCLUDED.discontinued,
categoryid = EXCLUDED.categoryid;

SELECT * FROM products;

INSERT INTO categories
values(1, 'Beverages','Soft drinks, coffees, teas, beers, and ales')

select * from categories order by 1;

CREATE TABLE updated_products (
    productID INTEGER PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
	quantityPerUnit VARCHAR(100),
    UnitPrice DECIMAL(10,2),
	discontinued BOOLEAN NOT NULL,
    categoryID INTEGER,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

Insert Into updated_products(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
Values
(100,'Wheat Bread', 10, 20,'1',3),
(101,'White Bread', '15 boxes',19.9,'0',3),
(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,'0',1),
(103,'Savory Fire Sauce','12 - 550 ml bottles', 10,'0',2);


Merge Into products p
Using (
	Values 
		(100,'Wheat Bread', '10', 20,true , 3),
		(101,'White Bread', '15 boxes' , 19.9,false , 3),
		(102,'Midnight Mango Fizz', '24 - 12 oz bottles', 19,false , 1),
		(103,'Savory Fire Sauce', '12 - 550 ml bottles', 10,false , 2)
) As incoming(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
On p.productid = incoming.productid
When Matched And incoming.discontinued = false Then 
	Update Set
	    productname= incoming.productname,
		unitprice = incoming.unitprice
When Matched And incoming.discontinued = true Then	
	Delete
When Not Matched And incoming.discontinued = false Then
	Insert(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
	Values(incoming.productid, incoming.productname, incoming.quantityperunit, incoming.unitprice, incoming.discontinued, incoming.categoryid);



select * from products where productid in(100,101,102,103);

select * from categories;


































