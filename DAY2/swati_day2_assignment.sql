--1)      Alter Table:
 --Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
 Alter table employee
 ADD COLUMN linkedin_profile varchar(100);
 --SELECT linkedin_profile FROM employee;
 
--Change the linkedin_profile column data type from VARCHAR to TEXT.
ALTER TABLE employee
ALTER COLUMN linkedin_profile
SET DATA TYPE text;

-- Add unique, not null constraint to linkedin_profile
--> updating the column with default value first
UPDATE employee
SET linkedin_profile = CONCAT('https://linkedin.com/in/user_', employeeid);
--> adding not null constraint to the updated column
ALTER TABLE employee
ALTER COLUMN linkedin_profile SET NOT NULL;
--> adding unique constraint 
ALTER TABLE employee
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

--Drop column linkedin_profile
ALTER TABLE employee
DROP COLUMN linkedin_profile;

-- 2)Querying (Select)
-- Retrieve the first name, last name, and title of all employees
 SELECT
 split_part(employeename, ' ', 1) AS first_name,
 substring(employeename FROM position(' ' IN employeename) + 1) AS last_name,
 title
FROM employee;

--Find all unique unit prices of products
SELECT DISTINCT unitprice 
FROM product;

--List all customers sorted by company name in ascending order
SELECT * FROM customers
ORDER BY companyname ASC;

-- Display product name and unit price, but rename the unit_price column as price_in_usd
SELECT productname, unitprice, unitprice AS price_in_usd
FROM product;

--3)      Filtering
--Get all customers from Germany.
SELECT * FROM customers 
WHERE country = 'Germany';

--Find all customers from France or Spain
SELECT * FROM customers 
WHERE country IN ('France', 'Spain');

--Retrieve all orders placed in 1997 (based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
SELECT * FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 1997
AND (freight > 50 OR shippeddate IS NOT NULL);

--4)      Filtering
-- Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
SELECT productid, productname, unitprice FROM product
WHERE unitprice > 15;

-- List all employees who are located in the USA and have the title "Sales Representative".
SELECT * From employee
WHERE country = 'USA' AND title = 'Sales Representative';

-- Retrieve all products that are not discontinued and priced greater than 30.
SELECT* FROM product
WHERE discontinued = 1 AND unitprice > 30;

--5)      LIMIT/FETCH
--Retrieve the first 10 orders from the orders table.
SELECT * FROM orders
LIMIT 10;

--Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
SELECT * FROM orders
ORDER BY orderid
OFFSET 10 ROWS
LIMIT 10;

--6)      Filtering (IN, BETWEEN)
--List all customers who are either Sales Representative, Owner
SELECT * FROM customers 
WHERE contacttitle IN ('Sales Representative', 'Owner');

--Retrieve orders placed between January 1, 2013, and December 31, 2013.
SELECT *FROM orders
WHERE order_date BETWEEN '1/1/2013' and '12/31/2013';

--7)      Filtering
--List all products whose category_id is not 1, 2, or 3.
SELECT * FROM product
WHERE categoryid NOT IN ('1','2','3');

--Find customers whose company name starts with "A".
SELECT * FROM customers
WHERE contactname LIKE'A%';

--8)       INSERT into orders table:
/*Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50*/
INSERT INTO orders(orderid,customerid,employeeid,order_date,requiredate,shippeddate,shippersid,freight)
VALUES (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);
 SELECT* FROM orders where orderid = 11078;
 
 --9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.
--(HINT: unit_price =unit_price * 1.10)
UPDATE product 
SET unitprice = unitprice* 1.10
WHERE categoryid = 2;
SELECT unitprice FROM product WHERE categoryid  = 2;

