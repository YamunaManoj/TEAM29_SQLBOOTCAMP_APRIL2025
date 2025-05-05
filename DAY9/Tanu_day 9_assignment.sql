1. Track Product Price Changes with Trigger
 Step 1: Create the Audit Table
CREATE TABLE IF NOT EXISTS product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
Step 2: Create the Trigger Function
CREATE OR REPLACE FUNCTION product_price_audit_function()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
Step 3: Create the Trigger on products Table
CREATE TRIGGER product_price_audit_trigger
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION product_price_audit_function();

Step 4: Test the Trigger
1. Check Current Product Info

SELECT * FROM products WHERE product_id = 1;

2. Update Product Price (Increase by 10%)

UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 1;

3. Check Updated Product Info
SELECT * FROM products WHERE product_id = 1;

4. Check the Audit Table for Recorded Change
SELECT * FROM product_price_audit;




2. Assign Tasks to Employees Using a Stored Procedure
 Step 1: Create the employee_tasks Table
CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);
Step 2: Define the Stored Procedure
CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the new task for the employee
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

    -- Count all tasks for that employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Output a notice
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;

Step 3: Call the Procedure
CALL assign_task(1, 'Review Reports');
✅ Step 4: Confirm Task Assignment
SELECT * FROM employee_tasks;

