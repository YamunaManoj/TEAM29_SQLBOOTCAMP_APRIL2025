select
EXTRACT (YEAR FROM orderDate) as Order_year,
EXTRACT (Quarter FROM orderDate) as Quarter,
count (*)as order_count,
round (avg(freight)::numeric,2)as avg_freight
from orders

where 
freight > 100

group by 
order_year,
Quarter,

ORDER BY 
Order_year,
Quarter;


select contactTitle
from customers

UNION 

select title
from employees

select contactTitle
from customers

UNION ALL 

select title
from employees


SELECT categoryID,instock AS units_in_stock 
FROM products
WHERE units_in_stock > 0

INTERSECT

SELECT categoryID,instock AS units_in_stock 
FROM products
WHERE discontinued = 0
ORDER BY instock;





SELECT orderID
FROM orders

EXCEPT 

SELECT DISTINCT orderID
FROM order_details
WHERE discount=1;




























