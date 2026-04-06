DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
emp_name VARCHAR(100),
job_level INT,
salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary)
VALUES
('Alice', 1, 1000),
('Bob', 2, 2000),
('Charlie', 3, 3000);

CREATE OR REPLACE PROCEDURE adjust_salary(
IN p_emp_id INT,
OUT p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE current_salary NUMERIC;
DECLARE lvl INT;
BEGIN
SELECT salary, job_level
INTO current_salary, lvl
FROM employees
WHERE emp_id = p_emp_id;

```
IF current_salary IS NULL THEN
    RAISE EXCEPTION 'Nhân viên không tồn tại';
END IF;

IF lvl = 1 THEN
    p_new_salary := current_salary * 1.05;
ELSIF lvl = 2 THEN
    p_new_salary := current_salary * 1.10;
ELSIF lvl = 3 THEN
    p_new_salary := current_salary * 1.15;
ELSE
    p_new_salary := current_salary;
END IF;

UPDATE employees
SET salary = p_new_salary
WHERE emp_id = p_emp_id;
```

END;
$$;

CALL adjust_salary(3, NULL);
