CREATE OR REPLACE FUNCTION get_stock_value_by_category(p_category_id INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    v_stock_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO v_stock_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN COALESCE(v_stock_value, 0.00); -- Return 0 if no products found
END;
$$ LANGUAGE plpgsql;

SELECT get_stock_value_by_category(1);

DO $$
DECLARE
    cur_products CURSOR FOR
        SELECT product_id, product_name, unit_price FROM products;

    rec_product RECORD;
BEGIN
    OPEN cur_products;

    LOOP
        FETCH cur_products INTO rec_product;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'Product ID: %, Name: %, Price: %',
            rec_product.product_id, rec_product.product_name, rec_product.unit_price;
    END LOOP;

    CLOSE cur_products;
END;
$$;