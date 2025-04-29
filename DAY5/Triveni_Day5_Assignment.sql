/* Day5 - Assignment */
/* 1. GROUP BY with WHERE - Orders by Year and Quarter. Display order year, quarter, order count, avg freight cost only for those orders where freight cost > 100 */


select 
	extract(year from order_date) as order_year, 
	extract(quarter from order_date) as order_quarter,
	count(*) as order_count,
	round(cast(avg(freight) as numeric), 2) as average_freight_cost
from 
	orders
where 
	freight > 100
group by 
	order_year,
	order_quarter
order by 
	order_year,
	order_quarter;


/* 2. GROUP BY with HAVING - High Volume Ship Regions.Display ship region, no of orders in each region, min and max freight cost. Filter regions where no of orders >= 5*/

select ship_region, count(*) as num_orders, min(freight), max(freight)
from orders
group by ship_region
having count(*) >= 5
order by num_orders desc;



/* 3. Get all title designations across employees and customers ( Try UNION & UNION ALL)*/


select title from employees 
UNION
select contact_title from customers;

select title from employees 
UNION ALL
select contact_title from customers;


/* 4. Find categories that have both discontinued and in-stock products. (Display category_id, instock means units_in_stock > 0, Intersect)*/

select category_id, units_in_stock as instock
from products
where units_in_stock >0 
INTERSECT
select category_id, units_in_stock as instock
from products
where discontinued = 0 
order by instock;


/* 5. Find orders that have no discounted items (Display the  order_id, EXCEPT)*/

select order_id 
from orders 
Except
select distinct order_id
from order_details
where discount = 1;

