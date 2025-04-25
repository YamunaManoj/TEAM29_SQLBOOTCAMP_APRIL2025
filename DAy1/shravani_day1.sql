-- Constraints: 
-- 1. Primary Key to uniquely identifies each row.
-- 2. Foreign Key to maintains relationships between tables.
-- 3. NOT NULL	to ensures required fields are filled.
-- 4. Composite PK	to enforces multi-column uniqueness.


CREATE TABLE categories (
    categoryID INTEGER PRIMARY KEY,
    categoryName VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE customers (
    customerID CHAR(5) PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL,
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    city VARCHAR(100),   
    country VARCHAR(100)
);

CREATE TABLE employees (
    employeeID INTEGER PRIMARY KEY,
    employeeName VARCHAR(50) NOT NULL,    
    title VARCHAR(50), 
    city VARCHAR(100),   
    country VARCHAR(100),    
    reportsTo INTEGER,
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);


CREATE TABLE shippers (
    shipperID INTEGER PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL    
);


CREATE TABLE orders (
    orderID INTEGER PRIMARY KEY,
    customerID CHAR(5),
    employeeID INTEGER,
    orderDate DATE,
	requiredDate DATE,
    shippedDate DATE,
    shipperID INTEGER,
    freight DECIMAL(10,2),
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);


CREATE TABLE products (
    productID INTEGER PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
	quantityPerUnit VARCHAR(100),
    UnitPrice DECIMAL(10,2),
	discontinued BOOLEAN NOT NULL,
    categoryID INTEGER,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);


CREATE TABLE order_details (
    orderID INTEGER,
    productID INTEGER,
    unitPrice DECIMAL(10,2) NOT NULL,
    quantity INTEGER NOT NULL,
    discount REAL,
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(OrderID),
    FOREIGN KEY (productID) REFERENCES products(ProductID)
);
