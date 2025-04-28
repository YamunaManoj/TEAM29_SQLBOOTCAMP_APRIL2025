--1.List all customers and the products they ordered with the order date.(Inner join)

select c.company_name as customers, o.order_id, p.product_name, od.quantity, o.order_date
from customers c
inner join orders o  on c.customer_id = o.customer_id
inner join order_details od on o.order_id = od.order_id
inner join products p on od.product_id = p.product_id;


/*2.Show each order with customer, employee, shipper, and 
product info — even if some parts are missing. (Left Join)*/

select o.order_id, 
c.company_name as customer, 
concat(e.first_name, ' ', e.last_name) as employee_name,
s.company_name as shipper, p.product_name
from products p 
left join order_details od on p.product_id = od.product_id
left join orders o on od.order_id = o.order_id
left join customers c on o.customer_id = c.customer_id
left join employees e on o.employee_id = e.employee_id
left join shippers s on o.ship_via = s.shipper_id;

select o.order_id, c.company_name as customer, 
concat(e.first_name, ' ', e.last_name) as employee_name,
s.company_name as shipper, p.product_name
from orders o 
left join customers c on o.customer_id = c.customer_id
left join employees e on o.employee_id = e.employee_id
left join shippers s on o.ship_via = s.shipper_id
left join order_details od on o.order_id = od.order_id
left join products p on od.product_id = p.product_id
order by 1 Nulls First;

/* 3.Show all order details and products 
(include all products even if they were never ordered). (Right Join)*/

select od.order_id, od.product_id, od.quantity, p.product_name
from order_details od
right join products p on od.product_id =p.product_id 
order by 1 Nulls First;

/* 4.List all product categories and their products — 
including categories that have no products, 
and products that are not assigned to any category.(Outer Join)*/

select p.product_name, ca.category_name
from products p 
full outer join categories ca on ca.category_id = p.category_id;


--5.Show all possible product and category combinations (Cross join).

select p.product_name, ca.category_name
from products p 
cross join categories ca;


--6.Show all employees who have the same manager(Self join).

select concat(E1.first_name, ' ' , E1.last_name) as employee_name,
	   concat(E2.first_name, ' ' , E2.last_name) as manager_name
	   from employees E1
	   inner join employees E2 on E1.reports_to =E2.employee_id
	   where E1.employee_id!= E2.employee_id;


--7.List all customers who have not selected a shipping method.

select cu.customer_id, cu.company_name as Customers, o.order_id, o.ship_via
from customers cu
left join orders o on cu.customer_id = o.customer_id
where o.ship_via is Null;
