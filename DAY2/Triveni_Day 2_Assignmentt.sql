ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR(255);
ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;
select * from employees;
UPDATE employees
 SET linkedin_profile = 'linkedin.com/'||employeename
 WHERE linkedin_profile IS NULL;
ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;
ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);
ALTER TABLE employees
DROP COLUMN linkedin_profile;
SELECT FirstName, LastName, Title
FROM Employees;
SELECT
  split_part(employeeName, ' ', 1) AS first_name,
  split_part(employeeName, ' ', 2) AS last_name,
  title
FROM employees;
SELECT DISTINCT
  unitPrice
FROM products;
SELECT *
FROM customers
ORDER BY companyName ASC;
SELECT
  productName,
  unitPrice AS price_in_usd
FROM products;
SELECT *
FROM Customers
WHERE Country = 'Germany';
SELECT *
FROM Customers
WHERE Country IN ('France', 'Spain');
SELECT *
FROM Orders
WHERE EXTRACT(YEAR FROM OrderDate) = 2014
  AND (Freight > 50 OR ShippedDate IS NOT NULL);
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 15;
SELECT
  employeeName,
  title
FROM employees;
SELECT *
FROM Employees
WHERE Country = 'USA' AND Title = 'Sales Representative';
SELECT *
FROM Products
WHERE Discontinued = FALSE AND UnitPrice > 30;
SELECT *
FROM Orders
LIMIT 10;
SELECT *
FROM Orders
OFFSET 10 LIMIT 10;
SELECT *
FROM Employees
WHERE Title IN ('Sales Representative', 'Owner');
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-12-31';
SELECT *
FROM Products
WHERE CategoryID NOT IN (1, 2, 3);
SELECT *
FROM Customers
WHERE CompanyName LIKE 'A%';

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight)
VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);
UPDATE Products
SET UnitPrice = UnitPrice * 1.10
WHERE CategoryID = 2;











