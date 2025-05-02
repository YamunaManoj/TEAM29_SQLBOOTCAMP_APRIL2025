select * from employees;
select * from orders;

select e.employeeID,
count(*)as total_sale,
rank() over (order by count (orderID) desc) as sales_rank
from orders o
join employees e on O.employeeID= e.employeeID
group by e.employeeID
order by 2 desc;

select orderID,customerID,orderDate,
lag(freight) over(partition by customerID order by orderID)as previous_freight,
lead(freight)over (partition by customerID order by orderID)as next_freight
from orders;


with cte_price_category as
(select unitPrice,
case
WHEN unitPrice< 20 THEN 'Low Price'
            WHEN unitPrice < 50 THEN 'Medium Price'
            ELSE 'High Price'
end
from products)



select cte_price_category,
count (*) as product_count,
ROUND(AVG(unitPrice)::numeric, 2) as avg_price
from cte_price_category
group by cte_price_category
order by cte_price_category;























