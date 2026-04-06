DROP TABLE IF EXISTS products;

CREATE TABLE products (
id SERIAL PRIMARY KEY,
name VARCHAR(100),
price NUMERIC,
discount_percent INT
);

INSERT INTO products (name, price, discount_percent)
VALUES
('Product A', 1000, 10),
('Product B', 2000, 60),
('Product C', 1500, 30);

CREATE OR REPLACE PROCEDURE calculate_discount(
IN p_id INT,
OUT p_final_price NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE p_price NUMERIC;
DECLARE p_discount INT;
BEGIN
SELECT price, discount_percent
INTO p_price, p_discount
FROM products
WHERE id = p_id;

```
IF p_price IS NULL THEN
    RAISE EXCEPTION 'Sản phẩm không tồn tại';
END IF;

p_discount := CASE 
    WHEN p_discount > 50 THEN 50
    ELSE p_discount
END;

p_final_price := p_price - (p_price * p_discount / 100);

UPDATE products
SET price = p_final_price
WHERE id = p_id;
```

END;
$$;

CALL calculate_discount(2, NULL);
