SELECT 
    E.employee_id, 
    E.first_name, 
    E.last_name, 
    COUNT(O.order_id) AS total_orders,
    RANK() OVER (ORDER BY COUNT(O.order_id) DESC) AS rank
FROM 
    Employees E
LEFT JOIN 
    Orders O ON E.employee_id = O.employee_id
GROUP BY 
    E.employee_id
ORDER BY 
    total_orders DESC;

SELECT 
    order_id, 
    customer_id, 
    order_date, 
    freight,
    LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight,
    LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight
FROM 
    Orders
ORDER BY 
    customer_id, 
    order_date;

WITH PriceCategories AS (
    SELECT 
        product_id,
        product_name,
        unit_price,
        CASE 
            WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
        END AS price_category
    FROM 
        Products
)
SELECT 
    price_category,
    COUNT(product_id) AS product_count,
    ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM 
    PriceCategories
GROUP BY 
    price_category
ORDER BY 
    price_category;

	
