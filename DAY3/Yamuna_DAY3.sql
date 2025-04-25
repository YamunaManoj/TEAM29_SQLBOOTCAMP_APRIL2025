
--------------------------------------------/* Yamuna Day-3 Assignment*/-------------------------------------------------


-------/* 1.Update the categoryName From “Beverages” to "Drinks" in the categories table */-----------------

update categories
set categoryName = 'Drinks'
where categoryName = 'Beverages';


select * from categories order by 1;

------/* 2. Insert into shipper new record (give any values) Delete that new record from shippers table */----
Insert into shippers
values(4, 'United States Postal Service');


select * from shippers;

-------/*2.2/DELETING*/-------------------------------------------------

Delete from shippers 
where "shipperID" = 4;


select * from shippers;

---------/* 3) Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.
Delete the categoryID= “3” from categories. 
Verify that the corresponding records are deleted automatically from products.
(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE for order_details(productid) )) */

--/* update cascade */-----   [categories-->products]

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


--/*delete cascade*/----- [categories-->products]
select * from categories where categoryID = 3;

select * from products  where categoryID = 3;


Alter Table order_details
Drop Constraint If Exists order_details_productid_fkey;


Alter Table order_details
Add constraint order_details_productid_fkey
Foreign Key(productID)
References products(productID)
On Update Cascade
On Delete Cascade;


Delete from categories
where categoryID = 3;


select * from categories where categoryID = 3;
select * from products  where categoryID = 3;



------/* 4) Delete the customer = “VINET” from customers*/---- 
Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/  
Insert into customers
values('VINET', 'Vins et alcohols Chevalier', 'Paul Henriot' , 'Accounting Manager', 'Reims', 'France')

-- Insert into orders 
--(orderid,customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight)
--values
--(10248, 'VINET', 5, '2013-07-04' , '2013-08-01', '2013-07-16', 3, 32.38),
--(10274, 'VINET', 6, '2013-08-06' , '2013-09-06', '2013-08-16', 3, 6.01),
--(10295, 'VINET', 2, '2013-09-02' , '2013-09-30', '2013-09-10', 3, 1.15),
--(10737, 'VINET', 2, '2014-11-11' , '2014-12-09', '2014-11-18', 3, 7.79),
--(10739, 'VINET', 3, '2014-11-12' , '2014-12-10', '2014-11-17', 3, 11.08);

Update orders
set customerid = 'VINET' where orderid in (10248,10274,10295,10737,10739);

ALTER TABLE orders
ALTER COLUMN customerID DROP NOT NULL;

select * from customers where customerID = 'VINET';
select * from orders where customerID = 'VINET';

-*/delete cascade [customers ---> orders]

Alter Table orders
Drop Constraint If Exists orders_customerid_fkey;

Alter Table orders
Add constraint orders_customerid_fkey
Foreign Key(customerID)
References customers(customerID)
On Delete Set Null;

Delete from customers
where customerID = 'VINET';

select * from customers where customerID = 'VINET';

select * from orders where customerID is Null;

---/* 5) Insert the following data to Products using UPSERT*/-----
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
(this should update the quantityperunit for product_id = 100) */

insert into categories
values(3, 'COnfections', 'Desserts, candies, and sweet breads');

select * from categories order by 1;
select * from products;
--upsert

Insert into products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
values
(100,'Wheat Bread', 1, 13,'0' , 3);

Insert Into products(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
Values(101,'White Bread', 5, 13,'0' , 3)
On Conflict(productid)
Do Update
Set productname = EXCLUDED.productname,
   quantityperunit = EXCLUDED.quantityperunit,
   unitprice = EXCLUDED.unitprice,
   discontinued = EXCLUDED.discontinued,
   categoryid = EXCLUDED.categoryid;


Insert Into products(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
Values(100,'Wheat Bread', 10, 13,'0' , 3)
On Conflict(productid)
Do Update
Set productname = EXCLUDED.productname,
   quantityperunit = EXCLUDED.quantityperunit;
   
select * from products;

------/* 6) Write a MERGE query*/--------

------*/ first insert the deleted row again/*-----------------

insert into categories
values(1, 'Beverages','Soft drinks, coffees, teas, beers, and ales' )

select * from categories order by 1;

-- create updated_products table
CREATE TABLE updated_products (
    productID INTEGER PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
	quantityPerUnit VARCHAR(100),
    UnitPrice DECIMAL(10,2),
	discontinued BOOLEAN NOT NULL,
    categoryID INTEGER,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

-- insert values into the new table
Insert Into updated_products(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
Values
(100,'Wheat Bread', 10, 20,'1' , 3),
(101,'White Bread', '15 boxes' , 19.9,'0' , 3),
(102,'Midnight Mango Fizz', '24 - 12 oz bottles', 19,'0' , 1),
(103,'Savory Fire Sauce', '12 - 550 ml bottles', 10,'0' , 2);


select * from updated_products;
-- Update the price and discontinued status for from below table ‘updated_products’ only if
-- there are matching products and updated_products .discontinued =0
-- If there are matching products and updated_products .discontinued =1 then delete
-- Insert any new products from updated_products that don’t exist in products only if
-- updated_products .discontinued =0.

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
select * from customers;
select * from employees;
select * from order_details;
select * from orders;
select * from products;
select * from shippers;
