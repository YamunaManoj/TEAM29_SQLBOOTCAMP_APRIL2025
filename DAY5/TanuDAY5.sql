Orders by Year and Quarter (Freight > 100)

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(freight)::NUMERIC, 2) AS avg_freight_cost
FROM 
    orders
WHERE 
    freight > 100
GROUP BY 
    order_year, order_quarter
ORDER BY 
    order_year, order_quarter;

2. High Volume Ship Regions (Orders >= 5)

SELECT 
    ship_region,
    COUNT(order_id) AS order_count,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM 
    orders
WHERE 
    ship_region IS NOT NULL
GROUP BY 
    ship_region
HAVING 
    COUNT(order_id) >= 5
ORDER BY 
    order_count DESC;

3.All Title Designations (UNION vs UNION ALL)

Using UNION (removes duplicates):

SELECT title FROM employees
UNION
SELECT contact_title FROM customers;

Using UNION ALL (keeps duplicates):

sql
CopyEdit

SELECT title FROM employees
UNION ALL
SELECT contact_title FROM customers;

4. Categories with Both Discontinued and In-Stock Products

SELECT category_id, units_in_stock AS in_stock
FROM products
WHERE units_in_stock > 0

INTERSECT

SELECT category_id, units_in_stock AS in_stock
FROM products
WHERE discontinued = 0
ORDER BY in_stock;

5. Orders with No Discounted Items

SELECT order_id
FROM orders

EXCEPT

SELECT DISTINCT order_id
FROM order_details
WHERE discount = 1;


