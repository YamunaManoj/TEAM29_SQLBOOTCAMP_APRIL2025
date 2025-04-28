select c.companyName as customers, o.orderID, p.productName, n.quantity, o.orderDate
from customers c
inner join orders o  on c.customerID = o.customerID
inner join order_details n on o.orderID = n.orderID
inner join products p on n.productID = p.productID;



SELECT 
o.orderID, c.companyName as customer,e.first_name||''|| e.last_name AS employee,
s.companyName AS shipper,p.productName,od.quantity
from orders o 
left join customers c on o.customerID=c.customerID
left join employees e on o.employeeID=e.employeeID
left join shippers s on o.shipperID = s.shipperID
left join order_details od on o.orderID=od.orderID
left join products s on od.productID=p.productID;



select p.productName,od.quantity,od.orderID
from order_details od
right join products p on od.productID=p.productID;

select c.categoryName,p.productID
from categories c
full outer join products p on c.categoryID=p.categoryID;


select p.productID,p.productName,c.description
from products p
cross join categories c;


select 
e1.employeeName AS employee_name,
e2.reportsTo AS manager_name
from employees e1
left join employees e2 on e1.reportsTo=e2.employeeid;

select c.customerID,c.contactName,o.shipperID
from customers c
left join orders o on o.customerID=c.customerID
where o.shipperID is null;

















