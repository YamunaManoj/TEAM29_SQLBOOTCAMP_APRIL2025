ALTER TABLE  employees
ADD COLUMN linkedin_profile VARCHAR (100);


ALTER TABLE employees
ALTER COLUMN linkedin_profile
SET DATA TYPE TEXT;


ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

ALTER TABLE employees
ADD CONSTRAINT UNIQUE_linkedin_profile UNIQUE (linkedin_profile);

ALTER TABLE employees
DROP COLUMN linkedin_profile;

SELECT employeeName,title
FROM employees;

SELECT DISTINCT unitPrice FROM Products;


SELECT productName, unitPrice AS price_in_usd
FROM Products;

SELECT * FROM customers
ORDER BY companyName ASC;

SELECT * FROM customers
WHERE country = 'Germany';


SELECT * FROM customers
WHERE country = 'France' OR country ='Spain';

SELECT productID,productName,unitPrice
FROM products
WHERE unitPrice>15;

SELECT * FROM employees
WHERE country='USA' AND title='Sales Representative';

SELECT * FROM products
WHERE discontinued= 'FALUSE' AND unitPrice>30;

SELECT * FROM orders
LIMIT 10;


SELECT * FROM Orders 
ORDER BY orderID ASC 
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

SELECT * FROM customers
WHERE contactTitle BETWEEN 'Sales Representative' AND 'Owner';

SELECT * FROM orders
WHERE orderDate BETWEEN '2023-01-01' AND '2023-12-31';


SELECT * FROM products
WHERE categoryID NOT IN (1,2,3);


SELECT * FROM customers
WHERE companyName LIKE 'A%';

INSERT INTO orders (orderID,customerID,employeeID,orderDate,requiredDate,shippedDate,shipperID,freight)
VALUES (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

SELECT * FROM products;

UPDATE products
SET products.unit_price =products.unit_price * 1.10
WHERE categoryID=2;

















