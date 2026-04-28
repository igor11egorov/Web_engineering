USE northwind;

-- UNION используется, когда нужно получить колонки с ОДИНАКОВЫМИ именами из разных таблиц
SELECT first_name, last_name, 'employee' AS status FROM employees
UNION ALL
SELECT first_name, last_name, 'customer' AS status FROM customers;

SELECT first_name, last_name, 'employee' AS status FROM employees
UNION 
SELECT first_name, last_name, 'customer' AS status FROM customers;

SELECT first_name, last_name, 'employee' AS status FROM employees WHERE city = 'Seattle'
UNION ALL
SELECT first_name, last_name, 'customer' AS status FROM customers WHERE city = 'Seattle';

-- JOIN соединяет таблицы
SELECT customer_id, order_date, shipped_date, first_name, last_name 
FROM orders 
JOIN customers ON orders.customer_id = customers.id;

-- Если колонка с определенным названием есть и в одной и в другой таблице, то необходимо указать из какой таблицы
SELECT orders.id, customer_id, order_date, shipped_date, first_name, last_name 
FROM orders 
JOIN customers ON orders.customer_id = customers.id;

-- Псевдонимы для таблиц можно делать
SELECT o.id, customer_id, order_date, shipped_date, first_name, last_name 
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.id;

-- Для нескольких таблиц
SELECT orders.id, order_date, shipped_date, 
customer_id, customers.first_name AS customers_first_name, customers.last_name AS customers_last_name, 
employee_id, employees.first_name AS employees_first_name, employees.last_name AS employees_last_name
FROM orders 
JOIN customers ON orders.customer_id = customers.id
JOIN employees ON orders.employee_id = employees.id;