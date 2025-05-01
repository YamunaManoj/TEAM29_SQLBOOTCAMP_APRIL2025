
-----------------------------------DAY 7 ASSIGNMENT-------------------------------------

/* 1.Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/ 

select * from employees;
select * from orders;
select * from products;

select 
	  E.employee_id, 
	  count(*) as total_sales, 
	  Rank() over(order by count(order_id) desc) as sales_rank
from orders O
join employees E on O.employee_id = E.employee_id
group by E.employee_id
order by 2 desc;


/* 2.Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
 Use lead(freight) and lag(freight). */
 
select order_id, customer_id, order_date,freight,
lag(freight) over (partition by customer_id order by freight) as previous_order_freight,
lead(freight) over (partition by customer_id order by freight) as next_order_freight
from orders;
 
select order_id, customer_id, order_date,freight,
lag(freight) over (partition by customer_id order by order_id) as previous_order_freight,
lead(freight) over (partition by customer_id order by order_id) as next_order_freight
from orders;
 

/* 3.Show products and their price categories, product count in each category, avg price:
(HINT: ·Create a CTE which should have price_category definition:
        WHEN unit_price < 20 THEN 'Low Price'
        WHEN unit_price < 50 THEN 'Medium Price'
        ELSE 'High Price'
·In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/


With cte_price_category As(
select product_id,product_name, unit_price,
case
	WHEN unit_price < 20 THEN 'Low Price'
    WHEN unit_price < 50 THEN 'Medium Price'
    ELSE 'High Price'
end as price_category
from products
)

--main query
select price_category, 
count(*) as product_count, 
ROUND(AVG(unit_price)::numeric, 2) as avg_price
from cte_price_category
group by price_category
order by price_category;




