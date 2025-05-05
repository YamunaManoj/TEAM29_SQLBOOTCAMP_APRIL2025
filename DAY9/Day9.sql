--1. AFTER UPDATE Trigger to Track Product Price Changes
--Step 1: Create the product_price_audit table

CREATE TABLE IF NOT EXISTS product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
--Step 2: Create the trigger function

CREATE OR REPLACE FUNCTION fn_track_price_change()
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
--Step 3: Create the trigger (fires after unit_price update)

CREATE TRIGGER trg_after_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION fn_track_price_change();
--Step 4: Test the trigger by updating a product's price

-- Pick an existing product_id
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 1;
-- Now check the audit log:


SELECT * FROM product_price_audit ORDER BY change_date DESC;

--2. Stored Procedure to Assign Tasks to Employees
--Step 1: Create the employee_tasks table

CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);
--Step 2: Create the stored procedure

CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert new task
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);
    
    -- Count total tasks for the employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Output message
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;
--Step 3: Call the procedure and test

CALL assign_task(1, 'Review Reports');
-- Check the result:


SELECT * FROM employee_tasks WHERE employee_id = 1;




