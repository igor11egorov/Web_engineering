USE northwind;

SELECT id, order_id, product_id FROM order_details WHERE quantity >= 100;
SELECT id, order_date FROM orders WHERE order_date >= '2006-01-01' AND order_date <= '2006-01-31';

-- COUNT выводит количество строк, где нет NULL
SELECT COUNT(*) AS total_january_orders FROM orders WHERE order_date >= '2006-01-01' AND order_date <= '2006-01-31';
SELECT COUNT(*) AS total_orders FROM orders; -- 48
SELECT COUNT(shipped_date) AS total_orders FROM orders; -- 39
SELECT id, quantity, unit_price, discount, (quantity * unit_price * (1 - discount)) AS total_price FROM order_details;
SELECT SUM(quantity) AS total_qantity FROM order_details;
SELECT SUM(quantity * unit_price * (1 - discount)) AS total_order_price FROM order_details;
SELECT COUNT(*) AS total_product FROM order_details; -- 58
SELECT COUNT(DISTINCT product_id) AS total_products_ordered FROM order_details; -- 24

-- AVG выводит среднее значение
SELECT AVG(discount) AS avg_discount FROM order_details;
SELECT AVG(quantity * unit_price * (1 - discount)) AS avg_total_price FROM order_details;
SELECT MAX(discount) as max_discount FROM order_details;
SELECT MIN(discount) as min_discount FROM order_details;

-- Для таблицы products:
SELECT * FROM products; -- 45
-- Задание 1: Посчитайте, у скольки товаров есть minimum_reorder_quantity.
SELECT COUNT(minimum_reorder_quantity) AS total_products_minimum_reorder_quantity FROM products; -- 30
-- Задание 2: Посчитайте сколько у товаров разных категорий.
SELECT COUNT(DISTINCT category) total_uniq_category FROM products; -- 16
-- Задание 3: Найдите общее количество товаров на складе.
SELECT SUM(unit_in_stock) as total_unit FROM products; -- 7826
-- Задание 4: Найдите среднюю закупочную цену товаров и среднюю розничную цену.
SELECT AVG(standard_cost) AS avg_standard_cost, AVG(list_price) AS avg_list_price FROM products; -- 11.68.., 15.84..
-- Задание 5: Найдите минимальную и максимальную розничную цены.
SELECT MIN(list_price) AS min_list_price, MAX(list_price) AS max_list_price FROM products; -- 1.2, 81.0

-- GROUP_CONCAT выводит все значения в одну строку через запятую
SELECT GROUP_CONCAT(DISTINCT category) AS all_uniq_category FROM products;

-- GROUP BY сначала делит на подтаблицы, потом применяется COUNT
-- нужно выводить через SELECT ту колонку, по которой группируем (здесь - city). Для понимания
SELECT city, COUNT(id) AS total_city_customers FROM customers GROUP BY city; 
SELECT state_province, COUNT(id) AS total_state_customers FROM customers GROUP BY state_province;

SELECT job_title, COUNT(id) AS total_employees 
FROM employees 
GROUP BY job_title 
ORDER BY total_employees ASC;

SELECT order_id, 
COUNT(*) AS total_positions 
FROM order_details 
GROUP BY order_id
ORDER BY total_positions DESC;

SELECT id, order_id,
quantity * unit_price * (1 - discount) AS total_position_price
FROM order_details;

SELECT order_id, 
COUNT(*) AS total_positions,
SUM(quantity * unit_price * (1 - discount)) AS total_order_price
FROM order_details 
GROUP BY order_id
ORDER BY total_order_price DESC;

SELECT company, job_title, COUNT(id) AS total_employees 
FROM employees 
GROUP BY company, job_title ORDER BY total_employees ASC;

-- HAVING - как WHERE, но по полям, которых не было в исходной таблице
SELECT order_id, 
COUNT(*) AS total_positions, 
SUM(quantity * unit_price * (1 - discount)) AS total_order_price
FROM order_details
GROUP BY order_id
HAVING total_order_price > 1000
ORDER BY total_positions DESC;

-- Для таблицы products:
SELECT * FROM products; -- 45
-- Задание 1: выведите количество товаров и среднюю цену для каждой категории.
SELECT category, COUNT(*) AS total_units, AVG(list_price) AS avg_list_price FROM products GROUP BY category;
-- Задание 2: выведите категории, в которых больше 2 товаров и средняя цена больше 15
SELECT category, 
COUNT(*) AS total_units, 
AVG(list_price) AS avg_list_price 
FROM products 
GROUP BY category 
HAVING total_units > 2 AND avg_list_price  > 15
ORDER BY category;
-- Задание 3: для каждой категории посчитайте суммарный остаток на складе.
SELECT category, SUM(unit_in_stock) AS sum_unit_in_stock FROM products GROUP BY category;
-- Задание 4: Сгруппируйте товары по minimum_reorder_quantity и посчитайте количество товаров для каждого minimum_reorder_quantity.
SELECT minimum_reorder_quantity, COUNT(*) AS total_unit_in_stock FROM products 
GROUP BY minimum_reorder_quantity ORDER BY minimum_reorder_quantity;
-- Задание 5: Выведите категории, в которых суммарный остаток на складе больше 20.
SELECT category, SUM(unit_in_stock) AS sum_unit_in_stock FROM products GROUP BY category HAVING sum_unit_in_stock > 20;






