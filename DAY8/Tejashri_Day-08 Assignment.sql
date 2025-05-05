SELECT productID,productName,unitPrice
FROM products
WHERE unitPrice<10
ORDER BY unitPrice;



CREATE VIEW vw_updatetable_products as
SELECT productID,productName,unitPrice
FROM products;


UPDATE vw_updatetable_products 
SET unitPrice=unitPrice * 1.1
WHERE unitPrice < 10;

SELECT productID,productName,unitPrice 
from products
WHERE unitPrice < 10
order by unitPrice;


CREATE VIEW Employee_table as 
select e.Employee_id,
e.Employee_full_name,
e.Title,
t.Territory_id,
t.Territory_description,
r.region_description
from employees e
join employee_Territories et on e.Employee_id=et.Employee_id
join Territories t on et.Territory_id=t.Territory_id
join region r on t.region_id=r.region_id;

select * from Employee_table;


WITH recursive cte_Employeehierarchy as 
(select employeeID,employeeName,reportsTo,0 as level

from employees e

where 
reportsTo is null
union all

select 

e.employeeID,e.employeeName,e.reportsTo,eh.level+1

from employees e
join cte_Employeehierarchy eh
on eh.employeeID=e.reportsTo
)



select level,employeeID,employeeName
from cte_Employeehierarchy
order by 
level,employeeID;


select employeeID, employeeName,level




































