DROP TABLE IF EXISTS inventory;

CREATE TABLE inventory (
product_id SERIAL PRIMARY KEY,
product_name VARCHAR(100),
quantity INT
);

INSERT INTO inventory (product_name, quantity)
VALUES
('Product A', 10),
('Product B', 5),
('Product C', 0);

CREATE OR REPLACE PROCEDURE check_stock(
IN p_id INT,
IN p_qty INT
)
LANGUAGE plpgsql
AS $$
DECLARE current_qty INT;
BEGIN
SELECT quantity INTO current_qty
FROM inventory
WHERE product_id = p_id;

```
IF current_qty IS NULL THEN
    RAISE EXCEPTION 'Sản phẩm không tồn tại';
ELSIF current_qty < p_qty THEN
    RAISE EXCEPTION 'Không đủ hàng trong kho';
END IF;
```

END;
$$;

CALL check_stock(1, 5);
CALL check_stock(2, 10);
