DROP TABLE IF EXISTS order_detail;

CREATE TABLE order_detail (
id SERIAL PRIMARY KEY,
order_id INT,
product_name VARCHAR(100),
quantity INT,
unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
(1, 'Product A', 2, 100000),
(1, 'Product B', 3, 100000),
(2, 'Product C', 1, 200000),
(2, 'Product D', 2, 150000);

CREATE OR REPLACE PROCEDURE calculate_order_total(
IN order_id_input INT,
OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
SELECT SUM(quantity * unit_price)
INTO total
FROM order_detail
WHERE order_id = order_id_input;

```
IF total IS NULL THEN
    total := 0;
END IF;
```

END;
$$;

CALL calculate_order_total(1, NULL);
CALL calculate_order_total(2, NULL);

CREATE OR REPLACE FUNCTION calculate_order_total_func(order_id_input INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE total NUMERIC;
BEGIN
SELECT SUM(quantity * unit_price)
INTO total
FROM order_detail
WHERE order_id = order_id_input;

```
RETURN COALESCE(total, 0);
```

END;
$$;

SELECT calculate_order_total_func(1);
