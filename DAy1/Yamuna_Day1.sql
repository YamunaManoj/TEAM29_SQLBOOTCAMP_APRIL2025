

--------/*Categories Table*/------

CREATE TABLE categories
(category_Id INTEGER PRIMARY KEY,
category_Name VARCHAR(60) NOT NULL,
description TEXT)

----customer_Id - Acts as a primary key-----

--------/*employee Table*/----

CREATE TABLE employees
(employee_id INTEGER PRIMARY KEY,
employee_name VARCHAR(60) NOT NULL,
title VARCHAR(50),city  VARCHAR(70),
country VARCHAR(60),reportto INTEGER,
FOREIGH KEY (reportTo)REFERENCES employees(employee))



----employee_id - Acts as a primary key-----


-----/*customer table */----

CREATE TABLE customers
(customer_id CHAR(40) PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,contact_anme VARCHAR(45),
contact_title VARCHAR(30),city VARCHAR(40),
country VARCHAR(50))


----customer_id - Acts as a primary key-----



---/* Shippers Table*/-----

CREATE TABLE shippers
(shipperID INTEGER PRIMARY KEY, 
companyName VARCHAR(100) NOT NULL)



----shipperID - Acts as a primary key-----



-----/*Order Table*/----
CREATE TABLE ORDERS
(order_id INTEGER PRIMARY KEY,
customer_id CHAR(30),employee_id INTEGER,
order_date DATE,required_date DATE,shipped_date DATE,
shipper_id INTEGER freight DECIMAL(10,2),
FOREIGN KEY (customer_id)REFERENCES customers(customer_id),
FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
FOREIGN KEY(shipper_id) REFERENCES (shipper_id)


----order_id - Acts as a primary key-----



------------/*order_details*/-------------



CREATE TABLE order_details
(order_id INTEGER,product_id INTEGER,
unit_price DECIMAL(10,2) NOT NULL,quantity INTEGER NOT NULL, 
discount REAL,
PRIMARY KEY(order_id, product_id),
FOREIGN KEY(order_id)REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id))



-----/*Product*/-----



CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
	quantityPerUnit VARCHAR(100),
    UnitPrice DECIMAL(10,2),
	discontinued BOOLEAN NOT NULL,
    category_id INTEGER,
    FOREIGN KEY (categoryID) REFERENCES categories(category_id)
);



----product_id - Acts as a primary key-----



Constraints: 
-- 1. Primary Key to uniquely identifies each row.
-- 2. Foreign Key to maintains relationships between tables.


