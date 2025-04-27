CREATE TABLE categories (
    categoryID INT PRIMARY KEY,
    categoryName VARCHAR(100),
    description TEXT
);

CREATE TABLE customers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(100),
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE employees (
    employeeID INT PRIMARY KEY,
    employeeName VARCHAR(100),
    title VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    reportsTo INT
);

CREATE TABLE shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(100)
);

CREATE TABLE orders (
    orderID INT PRIMARY KEY,
    customerID VARCHAR(10),
    employeeID INT,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INT,
    freight DECIMAL(10, 2),
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);

CREATE TABLE products (
    productID INT PRIMARY KEY,
    productName VARCHAR(100),
    quantityPerUnit VARCHAR(100),
    unitPrice DECIMAL(10, 2),
    discontinued BOOLEAN,
    categoryID INT,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

CREATE TABLE order_details (
    orderID INT,
    productID INT,
    unitPrice DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(4, 2),
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);
select * from database2;
select * from database 2;
select * from customers;
select * from database 2;
select * from categories;
select * from orders;
