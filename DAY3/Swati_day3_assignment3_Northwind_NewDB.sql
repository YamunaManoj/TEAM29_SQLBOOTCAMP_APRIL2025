SELECT E.last_name || '' ||E.first_name as fullname,O.order_id 
FROM employees E 
INNER JOIN orders O 
ON E.employee_id = O.employee_id;