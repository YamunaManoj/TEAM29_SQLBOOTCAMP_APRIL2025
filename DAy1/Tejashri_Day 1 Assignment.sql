CREATE TABLE categories(
   categoryID Integer PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL, 
	description VARCHAR(255)
);


CREATE TABLE Customers (
    customerID CHAR(5) PRIMARY KEY,
   CompanyName VARCHAR (100),
   ContactName VARCHAR(100), 
    ContactTitle VARCHAR(100),
	City VARCHAR(100) ,
	 Country VARCHAR(100) 
);

CREATE TABLE shippers(
shipperID Integer PRIMARY KEY,
companyName VARCHAR(100) 
);


CREATE TABLE employees(
employeeID Integer PRIMARY KEY,
employeeName VARCHAR(100), 
title VARCHAR(100),
city VARCHAR(100), 
country VARCHAR(100),
reportsTo Integer,
FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

CREATE TABLE orders(
orderID Integer PRIMARY KEY,
customerID CHAR(5),
employeeID INT,
orderDate DATE,
requiredDate DATE,
shippedDate DATE,
shipperID INT,
freight DECIMAL (10,2),
FOREIGN KEY (customerID)REFERENCES Customers(customerID),
FOREIGN KEY (employeeID)REFERENCES employees(employeeID),
FOREIGN KEY (shipperID)REFERENCES shippers(shipperID) 
);


CREATE TABLE order_details(
orderID Integer,
productID INT,
unitPrice DECIMAL(10,2)NOT NULL,
quantity int,
discount REAL,
PRIMARY KEY (orderID,productID),
FOREIGN KEY (orderID)REFERENCES orders(orderID)
);


CREATE TABLE products(
productID Integer PRIMARY KEY,
productName VARCHAR(100),
quantityPerUnit VARCHAR(100),
unitPrice DECIMAL(10,2),
discontinued BOOLEAN NOT NULL,
categoryID INT,
FOREIGN KEY (categoryID)REFERENCES categories(categoryID)
);






















