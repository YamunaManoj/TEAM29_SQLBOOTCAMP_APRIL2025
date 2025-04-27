select * from categories;
UPDATE Categories
SET category_name = 'Drinks'
WHERE category_name = 'Beverages';
Select * from categories order by 1;
INSERT INTO shippers (shipper_iD, company_name, phone)
VALUES (8, 'Fast Delivery Co.', '555-0123');
select * from shippers;
DELETE FROM Shippers
WHERE shipper_id = 4;
ALTER TABLE Products
DROP CONSTRAINT IF EXISTS products_categoryid_fkey;
ALTER TABLE Products
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY (category_iD)
REFERENCES categories(category_iD)
ON UPDATE CASCADE
ON DELETE CASCADE;
update categories
set category_id = 1001
where category_id = 1;


ALTER TABLE products
DROP CONSTRAINT fk_products_categories;  


ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id)
REFERENCES categories(category_id)
ON UPDATE CASCADE
ON DELETE CASCADE;
UPDATE categories
SET category_id = 1001
WHERE category_id = 1;

ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS fk_order_details_products;  

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id)
REFERENCES products(product_id)
ON DELETE CASCADE;


DELETE FROM products
WHERE category_id = 3;
DELETE FROM categories
WHERE category_id = 3;

select * from categories where category_id = 3;
Select * from products where category_id = 3;

ALTER TABLE Orders
DROP CONSTRAINT IF EXISTS fk_orders_customers;  

select * from customers where customer_id = 'VINET';
Select * from orders where customer_id = 'VINET';
ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE SET NULL;
DELETE FROM Customers
where customer_id = 'VINET';
Select * from customers where customer_id = 'VINET';
Select * from orders where customer_id = 'VINET';

SELECT * FROM Orders
WHERE customer_id IS NULL;
SELECT * FROM categories WHERE category_id = 3;

INSERT INTO categories (category_id, category_name)
VALUES (3, 'Bread Products');  

INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'Wheat bread', '1', 13, 0, 3)
ON CONFLICT (product_id) DO UPDATE 
SET quantity_per_unit = EXCLUDED.quantity_per_unit;


INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (101, 'White bread', '5 boxes', 13, 0, 3);


INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'Wheat bread', '10 boxes', 13, 0, 3)
ON CONFLICT (product_id) DO UPDATE 
SET quantity_per_unit = EXCLUDED.quantity_per_unit;

select * from products;

insert into categories 
values(1, 'Beverages','Soft drinks, coffees, teas, beers, and ales' );
select * from categories order by 1; 
CREATE TABLE updated_products ( 
product_id INTEGER PRIMARY KEY, 
product_name VARCHAR(100) NOT NULL, 
quantity_per_unit VARCHAR(100), 
unit_price DECIMAL(10,2), 
discontinued BOOLEAN NOT NULL, 
category_id INTEGER, 
FOREIGN KEY (category_id) REFERENCES categories(category_id));
select * from updated_products;

Insert Into updated_products(productid, productname, quantityperunit, 
unitprice, discontinued, categoryid) 
Values 
(100,'Wheat Bread', 10, 20,'1' , 3), 
(101,'White Bread', '15 boxes' , 19.9,'0' , 3), 
(102,'Midnight Mango Fizz', '24 - 12 oz bottles', 19,'0' , 1), 
(103,'Savory Fire Sauce', '12 - 550 ml bottles', 10,'0' , 2);

Merge Into products p 
Using ( 
Values  
(100,'Wheat Bread', '10', 20,1 , 3), 
(101,'White Bread', '15 boxes' , 19.9,0 , 3), 
(102,'Midnight Mango Fizz', '24 - 12 oz bottles', 19,0 , 1), 
(103,'Savory Fire Sauce', '12 - 550 ml bottles', 10,0 , 2) 
) As incoming(productid, productname, quantityperunit, unitprice, discontinued, 
categoryid) 
On p.product_id = incoming.productid 
When Matched And incoming.discontinued = 0 Then  
Update Set 
product_name= incoming.productname, 
unit_price = incoming.unitprice 
When Matched And incoming.discontinued = 1 Then  
Delete 
When Not Matched And incoming.discontinued = 0 Then 
Insert(product_id, product_name, quantity_per_unit, unit_price, discontinued, 
category_id) 
Values(incoming.productid, incoming.productname, incoming.quantityperunit, 
incoming.unitprice, incoming.discontinued, incoming.categoryid);
Select * from products where product_id in(100,101,102,103); 
select o.order_id, o.employee_id, concat(e.first_name, ' ', e.last_name) as Fullname from orders o inner join employees e on o.employee_id = e.employee_id;







