                                                                YAMUNA  Day2 ASSIGNMENTS

1) Alter Table:

   •	Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.

ALTER TABLE if exists employees 

ADD COLUMN linkedIn_profile VARCHAR(50) 

  		 •	Change the linkedin_profile column data type from VARCHAR to TEXT.

ALTER TABLE employees ALTER COLUMN linkedin_profile SET DATA TYPE text


		● Add unique, not null constraint to linkedin_profile

Alter table employees Add Constraint distinct_name UNIQUE (linkedin_profile);

Alter table employees Alter column linkedin_profile Set Not Null;



		● Drop column linkedin_profile

ALTER TABLE employees DROP COLUMN linkedin_profile

		2)    Querying (Select)

		•	Retrieve the employee name and title of all employees

select split_part("employeeName", ' ', 1) as first_name,
              split_part("employeeName", ' ', 2) as last_name, title from employees;


			  •	Find all unique unit prices of products
			  
select distinct "unitPrice" from products order by 1;


•	List all customers sorted by company name in ascending order

SELECT "customerID","customerName" FROM customers ORDER BY 2


● Display product name and unit price, but rename the unit_price column as price_in_usd 

select "productName", "unitPrice" as price_in_usd from products;



3) Filtering 

● Get all customers from Germany. 

Select "customerID" from customers where "country" = 'Germany';



● Find all customers from France or Spain 

select "customerID" from customers where "country" = 'France' or "country" ='Spain';

● Retrieve all orders placed in 2014 (based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)

(Hint: EXTRACT(YEAR FROM order_date))

 select * from orders where extract("Year" from "orderDate") = '2014’ and ("freight" > 50 or "shippedDate" is Not Null);


4) Filtering

/*● Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.

select "productID", "productName", "unitPrice" from products where "unitPrice" > 15 order by "unitPrice";


● List all employees who are in the USA and have the title "Sales Representative".

 select * from employees where "country" = 'USA' and "title" = 'Sales Representative'



● Retrieve all products that are not discontinued and priced greater than 30. 

select * from products where "discontinued" = ‘0’ and "unitPrice" > 30;



5) LIMIT/FETCH

 ● Retrieve the first 10 orders from the orders table. 
 
select * from orders limit 10;


● Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20). select * from orders limit 10 offset 10;



6) Filtering (IN, BETWEEN) ● List all customers who are either Sales Representative or Owner 


select * from customers where "contactTitle" = 'Sales Representative' or "contactTitle" ='Owner' order by "contactTitle";





● Retrieve orders placed between January 1, 2013, and December 31, 2013. 

select * from orders where "orderDate" between '2013-01-1' and '2013-12-31';




7) Filtering ● List all products whose category_id is not 1, 2, or 3.

 select * from products where "categoryID" not in (1, 2, 3) order by "categoryID";




● Find customers whose company name starts with "A".

 select * from customers where "companyName" like 'A%';


INSERT into orders table: Task:
 Add a new order to the orders table with the following details: 
Order ID: 11078
 Customer ID: ALFKI
 Employee ID: 5 Order Date: 2025-04-23
 Required Date: 2025-04-30 
Shipped Date: 2025-04-25
 shipperID:2 
Freight: 45.50
 Insert into orders values(11078,'ALFKI', 5, '2025-04-23', '2025-04-30','2025-04-25', 2, 45.50) 



select * from orders order by 1 desc;


9) Increase(Update) the unit price of all products in category_id =2 by 10%.(HINT: unit_price =unit_price * 1.10)

select * from products where "categoryID" =2;







