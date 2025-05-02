/* 1.Create view vw_updatable_products.
Try updating the view with the below query and see if the product table also gets updated.Update query:
UPDATE updatable_products 
SET unit_price = unit_price * 1.1 
WHERE units_in_stock < 10;
*/

Select product_id, 
product_name,
		unit_price,
		units_in_stock
From products 
Where units_in_stock < 10 
order by unit_price;


Create View vw_updatable_products As
Select product_id,
		product_name,
		unit_price,
		units_in_stock
From products;

Update vw_updatable_products 
Set unit_price = unit_price * 1.1 
Where units_in_stock < 10;


Select * 
From vw_updatable_products 
Where units_in_stock < 10 
order by unit_price;

Select product_id, 
product_name,
		unit_price,
		units_in_stock
From products 
Where units_in_stock < 10 
order by unit_price;

--Drop View vw_updatable_products;

/* 2.Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/
-- select * from products;

SELECT * FROM products WHERE category_id = 1 order by unit_price;

Begin;
Update products
Set unit_price = unit_price * 1.10
Where category_id = 1;

SELECT * FROM products WHERE category_id = 1 order by unit_price;

Rollback;

SELECT * FROM products WHERE category_id = 1 order by unit_price;

Commit;


/* 3.Create a regular view which will have the details below (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description*/

-- select * from employees;
-- select * from territories;
-- select * from employee_territories;
--Drop View vw_Employee_details;


Create View vw_Employee_details As
Select 
 	e.Employee_id,
	CONCAT(e.first_name, ' ' , e.last_name) As Employee_full_name,
	e.Title,
	t.Territory_id,
	t.territory_description,
	r.region_description
From employees e
Join employee_territories et On e.employee_id = et.employee_id
Join territories t on et.territory_id = t.territory_id
Join region r on  t.region_id = r.region_id;

select * from vw_Employee_details;



/* 4.Create a recursive CTE based on Employee Hierarchy*/
--Select employee_id, first_name, reports_to From employees;

With Recursive cte_employee_hierarchy
AS(
Select 
	employee_id,
	first_name,
	last_name,
	reports_to,
	0 As Level
From employees e
Where reports_to Is Null

Union All

Select 
	e.employee_id,
	e.first_name,
	e.last_name,
	e.reports_to,
	eh.level+1
From employees e
Join cte_employee_hierarchy eh
On eh.employee_id = e.reports_to
)

Select Level, employee_id, concat(first_name, ' ' , last_name) as employee_name
From cte_employee_hierarchy 
Order By level, employee_id;
