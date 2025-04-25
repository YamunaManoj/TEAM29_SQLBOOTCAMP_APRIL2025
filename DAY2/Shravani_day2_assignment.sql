---------------------------------------------------- Day-2 Assignment-------------------------------------------------
select * from categories;
select * from customers;
select * from employees;
select * from order_details;
select * from orders;
select * from products;
select * from shippers;

-- 1. Alter Table
/* a. Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.*/
Alter table if exists employees
Add column linkedin_profile varchar(100);

/* check the employees table */
select * from employees; 

/* b. Change the linkedin_profile column data type from VARCHAR to TEXT.*/
Alter table employees
Alter column linkedin_profile Set Data Type TEXT;

/* check the employees table*/
select * from employees; 

/* c. Add unique, not null constraint to linkedin_profile*/
Alter table employees 
Add Constraint distinct_name UNIQUE (linkedin_profile); 



Alter table employees
Alter column linkedin_profile Set Not Null;

/* check the employees table*/
select * from employees; 

/* d. Drop column linkedin_profile*/
Alter table employees
Drop column linkedin_profile;

/* check the employees table */
select * from employees; 

--2.Querying (Select)
/* a. Retrieve the first name, last name, and title of all employees */
select
    split_part("employeeName", ' ', 1) as first_name,
    split_part("employeeName", ' ', 2) as last_name,
    title
from employees;

select "employeeName", "title" from employees;

/* b. Find all unique unit prices of products. */
select distinct "unitPrice" 
from products
order by 1;

/* c. List all customers sorted by company name in ascending order. */
select "customerID", "companyName" 
from customers 
order by 2;

/* d. Display product name and unit price, but rename the unit_price column as price_in_usd. */
select "productName", "unitPrice" as price_in_usd
from products;

-- 3. Filtering
/* a. Get all customers from Germany. */
select "customerID" 
from customers
where "country" = 'Germany';

/* b. Find all customers from France or Spain. */
select "customerID" 
from customers
where "country" = 'France' or "country" ='Spain';

/* c. Retrieve all orders placed in 2014 (based on order_date), and either have freight greater than 50 
or the shipped date available (i.e., non-NULL) (Hint: EXTRACT(YEAR FROM order_date)) */
select * from orders
where extract("Year" from "orderDate") = '2014' and 
("freight" > 50 or "shippedDate" is Not Null);

-- 4. Filtering
/* a. Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15. */
select "productID", "productName", "unitPrice"
from products
where "unitPrice" > 15 
order by "unitPrice";

/* b. List all employees who are located in the USA and have the title "Sales Representative".*/
select * from employees 
where "country" = 'USA' and "title" = 'Sales Representative';

/* c. Retrieve all products that are not discontinued and priced greater than 30. */
select * from products
where "discontinued" = 0 and "unitPrice" > 30;

-- 5.LIMIT/FETCH

/* a. Retrieve the first 10 orders from the orders table. */
select * from orders
limit 10;

/* b. Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20). */
select * from orders
limit 10 offset 10;


-- 6. Filtering (IN, BETWEEN)
/* a. List all customers who are either Sales Representative, Owner*/
select * from customers
where "contactTitle" = 'Sales Representative'  or "contactTitle" ='Owner'
order by "contactTitle";

/* b. Retrieve orders placed between January 1, 2013, and December 31, 2013. */
select * from orders
where "orderDate" between '2013-01-1' and '2013-12-31';

-- 7. Filtering
/* a. List all products whose category_id is not 1, 2, or 3.*/
select * from products
where "categoryID" not in (1, 2, 3)
order by "categoryID";

/* b. Find customers whose company name starts with "A".*/
select * from customers
where "companyName" like 'A%';

-- 8. INSERT into orders table:
Insert into orders
values(11078,'ALFKI', 5, '2025-04-23', '2025-04-30','2025-04-25', 2, 45.50)

select * from orders
order by 1 desc;

-- 9. Increase(Update) the unit price of all products in category_id =2 by 10%.(HINT: unit_price =unit_price * 1.10)
select * from products where "categoryID" =2;
update products set "unitPrice" = "unitPrice" * 1.10 where "categoryID" = 2;
select * from products where "categoryID" =2;

