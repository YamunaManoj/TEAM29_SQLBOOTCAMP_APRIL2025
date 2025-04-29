/*1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100*/

SELECT 
    EXTRACT(YEAR FROM order_date) AS OrderYear,
    EXTRACT(QUARTER FROM order_date) AS OrderQuarter,
    COUNT(order_id) AS OrderCount,
    ROUND(AVG(freight)::numeric,2) AS AvgFreightCost
FROM 
    orders
WHERE 
    freight > 100
GROUP BY 
    OrderYear,
    OrderQuarter
ORDER BY 
    OrderYear,
    OrderQuarter;

/*2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/

SELECT 
    ship_region,
    COUNT(order_id) AS order_count,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM 
    Orders
WHERE 
    ship_region IS NOT NULL
GROUP BY 
    ship_region
HAVING 
    COUNT(order_id) >= 5
ORDER BY 
    order_count DESC;

 
/*3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)*/
--UNION
SELECT title
FROM employees

UNION

SELECT contact_title
FROM customers;
--UNION ALL
SELECT title
FROM employees

UNION ALL

SELECT contact_title
FROM customers;

/*4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/ 

select category_id, units_in_stock as instock
from products
where units_in_stock >0 

INTERSECT

select category_id, units_in_stock as instock
from products
where discontinued = 0 
order by instock;

/*Find orders that have no discounted items (Display the  order_id, EXCEPT)*/

select order_id 
from orders 

Except

select distinct order_id
from order_details
where discount = 1;

