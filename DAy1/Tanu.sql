--------Categories-----------

CREATE TABLE categories(
categoryID SERIAL PRIMARY KEY,
categoryName VARCHAR(200)NOT NULL UNIQUE,
description TEXT
)

--SERIAL--Auto-incrementing primary key using a sequence.
--NOT NULL--Column should not have null Value
--UNIQUE-- Column should not have Repetative value

SELECT * FROM categories

---------Customers-------------
create table customers(
customerID char(5) primary key,
companyName varchar(200),
contactName varchar(200),
contactTitle varchar(200),
city varchar(200),
country varchar(200)
)

--customerID PRIMARY KEY-Acts as a primary key.

SELECT * FROM customers;

-------employees-------
CREATE TABLE employees(
employeeID INT primary key ,
employeeName TEXT NOT NULL,
title TEXT,
city TEXT,
country TEXT,
reportsTo INT,
Foreign key (reportsTo )REFERENCES employees(employeeID)
)
--employeeID PRIMARY KEY- Acts as a primary key.
--employeeName NOT NULL - Column should not have null Value
--FOREIGN KEY(reportsTo)REFERENCES- self-referencing foreign key

select *from employees;
//Self referencing foreign key to employees table to employee ID


---------orders------------
CREATE TABLE orders(
OrderID INT primary key,
CustomerID char(5) references customers(customerID),
employeeID INT references employees(employeeID)  ,
orderDate date,
requiredDate date,
shippedDate date,
shipperID INT references shippers(shipperID),
freight decimal(10,2)
)
--orderID primary key- Act as Primary key
--customerID, employeeID, shipperID: Foreign keys to their respective tables

select *from orders;

-----order details---------

CREATE TABLE order_details(
OrderID INT references orders(ORDERID),
ProductID INT references products(productID),
unitPrice decimal(10,2),
quantity int,
discount decimal(10,2),
primary key(orderID ,productID)
)

-- orderID ,productID : Foreign keys to their respective tables
--PRIMARY KEY -Ensures that each product appears only once per order


select *from order_details;

--------products-----------

create table products(
productID serial primary key,
productName text not null,
quantityPerUnit text,
unitPrice decimal(10,2),
discontinued boolean,
categoryID int references categories(categoryID )
)

--productID  primary key - Act as primary key
--productName -NOT NULL - Not acctpting null values

select *from products;
----------Shippers-----------

CREATE TABLE shippers(
shipperID SERIAL primary key,
companyName TEXT not null
)
--shipperID : primary key - Act as primary key
--companyName :NOT NULL - Not acctpting null values
select *from shippers;
-----------------------------------
