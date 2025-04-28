- Day 4 Assignment

-- 1. List customers and products they ordered with order date

select c.company_name, o.order_id, p.product_name, od.quantity, o.order_date
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id;


-- 2. Show order with customer, employee, shipper and product (even if missing)

select o.order_id, c.company_name, concat(e.first_name, ' ', e.last_name) as employee_name,
s.company_name as shipper_name, p.product_name
from products p
left join order_details od on p.product_id = od.product_id
left join orders o on od.order_id = o.order_id
left join customers c on o.customer_id = c.customer_id
left join employees e on o.employee_id = e.employee_id
left join shippers s on o.ship_via = s.shipper_id;


-- 3. Show all order details and products (even if not ordered)

select od.order_id, od.product_id, od.quantity, p.product_name
from products p
left join order_details od on p.product_id = od.product_id
order by od.order_id nulls first;

-- 4. List all categories and products (include empty ones)

select p.product_name, c.category_name
from products p
full join categories c on p.category_id = c.category_id;


-- 5. Show all possible combinations of products and categories

select p.product_name, c.category_name
from products p
cross join categories c;


-- 6. Employees with the same manager

select concat(e1.first_name, ' ', e1.last_name) as employee_name,
concat(e2.first_name, ' ', e2.last_name) as manager_name
from employees e1
join employees e2 on e1.reports_to = e2.employee_id
where e1.employee_id != e2.employee_id;


-- 7. Customers with no shipping method selected

select c.customer_id, c.company_name, o.order_id, o.ship_via
from customers c
left join orders o on c.customer_id = o.customer_id
where o.ship_via is null;

