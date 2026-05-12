CREATE DATABASE 281125_wdm_teacher;

USE 281125_wdm_teacher;

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    hire_date DATE DEFAULT(CURRENT_DATE) NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK (salary > 0),
    email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO employees (first_name, last_name, birthdate, salary, email) 
VALUES('Bohdan', 'Liamzin', '1986-01-03', 5000, 'bogdan@gmail.com');

DELETE FROM employees WHERE id = 2;

INSERT INTO employees (first_name, last_name, birthdate, salary, email) 
VALUES('Kirillo', 'Molch', '1995-07-12', 5000, 'kirr@gmail.com'),
('Kirylo', 'Schevchnko', '1995-04-14', 3000, 'kir@gmail.com');

UPDATE employees SET salary = 4000, email = 'bogdan.lyamzin@gmail.com' WHERE id = 1;

UPDATE employees SET salary = 3500 WHERE salary < 3500 AND id > 0;

SET SQL_SAFE_UPDATES = 0;

UPDATE employees SET salary = 3700 WHERE salary < 3700;

SET SQL_SAFE_UPDATES = 1;

UPDATE employees SET salary = salary * 1.1 WHERE id > 0;

DELETE FROM employees WHERE id > 0;

TRUNCATE TABLE employees;

CREATE TABLE employees_short_info AS SELECT id, first_name, last_name FROM employees;

CREATE VIEW employees_short_info AS SELECT id, first_name, last_name FROM employees;

DELETE FROM employees WHERE id = 14;