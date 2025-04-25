CREATE TABLE categories(
categoryID INT PRIMARY KEY,
categoryName VARCHAR(50) NOT NULL,
description TEXT
);

CREATE TABLE Product(
productID INT PRIMARY KEY,
productName VARCHAR(50) ,
quantityPerUnit text,
unitPrice float,
discontinued float,
categoryID int,
FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

CREATE TABLE customers (
    customerID CHAR(5) PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL,
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    city VARCHAR(100),   
    country VARCHAR(100)
);

CREATE TABLE shippers(
shippersID INT PRIMARY KEY,
shippersName VARCHAR(50)
);

CREATE TABLE Employee(
employeeID INT PRIMARY KEY,
employeeName VARCHAR(50) ,
title Varchar(50) ,
city varchar (25) ,
country varchar(10) ,
reportsto int
);

create table orders(
orderid int primary key,
customerid varchar(10),
employeeid int,
order_date date,
requiredate date,
shippeddate date,
shippersid int,
freight float,
foreign key (customerid) references customers(customerid),
foreign key (employeeid) references employee(employeeid),
foreign key (shippersid) references shippers(shippersid)
);

CREATE TABLE order_details (
    orderID INTEGER,
    productID INTEGER,
    unitPrice DECIMAL(10,2) NOT NULL,
    quantity INTEGER NOT NULL,
    discount REAL,
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(OrderID),
    FOREIGN KEY (productID) REFERENCES product(ProductID)
);