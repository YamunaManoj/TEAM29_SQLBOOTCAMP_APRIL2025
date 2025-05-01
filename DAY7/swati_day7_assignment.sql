/* 1.Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/ 

SELECT * FROM employees;
SELECT * FROM orders;
SELECT * FROM products;

SELECT
	  E.employee_id, 
	  COUNT (*) AS total_sales, 
	  Rank() over(order by count(order_id) desc) AS sales_rank
FROM orders O
JOIN employees E on O.employee_id = E.employee_id
GROUP BY E.employee_id
ORDER BY 2 DESC;

/* 2.Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
 Use lead(freight) and lag(freight). */
 
SELECT order_id, customer_id, order_date,freight,
LAG(freight) OVER (partition by customer_id order by freight)AS previous_order_freight,
LEAD(freight) OVER (partition by customer_id order by freight) AS next_order_freight
FROM orders;

/* 3.Show products and their price categories, product count in each category, avg price:
(HINT: ·Create a CTE which should have price_category definition:
        WHEN unit_price < 20 THEN 'Low Price'
        WHEN unit_price < 50 THEN 'Medium Price'
        ELSE 'High Price'
·In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/

WITH cte_price_category As(
SELECT product_id,product_name, unit_price,
CASE
	WHEN unit_price < 20 THEN 'Low Price'
    WHEN unit_price < 50 THEN 'Medium Price'
    ELSE 'High Price'
END AS price_category
FROM products
)
--main query
SELECT price_category, 
COUNT (*) AS product_count, 
ROUND(AVG(unit_price)::numeric, 2) as avg_price
FROM cte_price_category
GROUP BY price_category
ORDER BY price_category;