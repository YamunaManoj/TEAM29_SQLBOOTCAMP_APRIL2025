SELECT 
    product_name,
    CASE 
        WHEN units_in_stock = 0 THEN 'Out of Stock'
        WHEN units_in_stock < 20 THEN 'Low Stock'
        ELSE 'In Stock' 
    END AS stock_status
FROM 
    Products;
	SELECT 
    product_name, 
    unit_price 
FROM 
    Products 
WHERE 
    category_id = (SELECT category_id FROM Categories WHERE category_name = 'Beverages')
	order by 1;
SELECT 
    product_name, 
    unit_price 
FROM 
    Products 
WHERE 
    category_id = (SELECT category_id FROM Categories WHERE category_name = 'Drinks')
	order by 1;
SELECT 
    order_id, 
    order_date, 
    freight, 
    employee_id 
FROM 
    Orders 
WHERE 
    employee_id = (
        SELECT 
            employee_id 
        FROM 
            (SELECT 
                employee_id, 
                COUNT(order_id) AS total_orders 
             FROM 
                Orders 
             GROUP BY 
                employee_id 
             ORDER BY 
                total_orders DESC 
             LIMIT 1) AS subquery
    );
	select order_id, ship_country, freight
from orders
where ship_country != 'USA'
and freight > any(select freight from orders where ship_country = 'USA'
order by freight desc)
order by freight desc;

	select order_id, ship_country, freight
from orders
where ship_country != 'USA'
and freight > all(select freight from orders where ship_country = 'USA')
order by freight desc;