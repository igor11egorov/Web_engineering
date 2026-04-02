-- 31.03.2026
USE northwind;

SELECT id, product_name AS name, product_code AS code, standard_cost, list_price FROM products;

SELECT *, quantity * unit_price AS total_price FROM order_details;

SELECT *, 
quantity * unit_price AS total_price, 
(quantity * unit_price * (1 - discount)) AS total_price_with_discount
FROM order_details;

SELECT id, product_code, product_name, standard_cost,
CASE 
	WHEN standard_cost >= 20 THEN 'expensive'
    WHEN standard_cost >= 10 THEN 'medium'
    ELSE 'cheap'
END AS price_category
 FROM products;
 
SELECT id, product_name, minimum_reorder_quantity,
CASE 
	WHEN minimum_reorder_quantity > 10 THEN 'large'
    ELSE 'normal'
END AS reorder_category 
FROM products;

SELECT id, product_name, minimum_reorder_quantity,
IF (minimum_reorder_quantity > 10, 'large', 'normal') AS reorder_category 
FROM products;

SELECT id, last_name, first_name, business_phone,
LEFT(business_phone, 5) AS phone_code 
FROM customers;

SELECT id, last_name, first_name, business_phone, 
SUBSTRING(business_phone, 2, 3) AS phone_code
FROM customers;

SELECT id, first_name, last_name, state_province AS state, city, address,
CONCAT(state_province, ' ', city, ' ', address) AS full_address
FROM customers;

SELECT id, first_name, last_name,
IF (notes IS NOT NULL, notes, 'not filled') AS notes_normalized
FROM employees;

SELECT id, first_name, last_name,
COALESCE(notes, 'not filled') AS notes_normalized
FROM employees;

SELECT id, first_name, last_name, 
UPPER(company) AS company, LOWER(job_title) AS job_title  
FROM employees;

SELECT id, first_name, last_name 
FROM employees 
WHERE LOWER(job_title) = 'sales representative';

-- 01.04.2026 
-- СОРТИРОВКА: SELECT... FROM... WHERE... ORDER BY [column] ASC, ORDER BY [column] DESC
-- можно делать сортировку по старым колонкам и вновь созданным.
-- первая сортировка сортирует одну колонку, последующие сортируют уже внутри предыдущих сортировок
SELECT *, 
quantity * unit_price AS total_price, 
(quantity * unit_price * (1 - discount)) AS total_price_with_discount
FROM order_details ORDER BY quantity ASC;

SELECT *, 
quantity * unit_price AS total_price, 
(quantity * unit_price * (1 - discount)) AS total_price_with_discount
FROM order_details ORDER BY total_price ASC;

SELECT *, 
quantity * unit_price AS total_price, 
(quantity * unit_price * (1 - discount)) AS total_price_with_discount
FROM order_details ORDER BY total_price DESC;

SELECT *, 
quantity * unit_price AS total_price, 
(quantity * unit_price * (1 - discount)) AS total_price_with_discount
FROM order_details ORDER BY total_price DESC, total_price_with_discount DESC;

SELECT id, first_name, last_name, business_phone, 
SUBSTRING(business_phone, 2, 3) AS phone_code
FROM customers ORDER BY first_name ASC;

SELECT id, product_code, product_name, standard_cost,
CASE 
	WHEN standard_cost >= 20 THEN 'expensive'
    WHEN standard_cost >= 10 THEN 'medium'
    ELSE 'cheap'
END AS price_category
FROM products ORDER BY price_category ASC, standard_cost ASC;

SELECT id, order_date FROM orders ORDER BY order_date ASC;

SELECT id, order_date, SUBSTRING(order_date, 6, 2) AS order_month
FROM orders ORDER BY order_month DESC;

-- ОГРАНИЧЕННАЯ ВЫБОРКА: LIMIT... OFFSET...
SELECT * FROM orders ORDER BY order_date DESC LIMIT 10;

SELECT * FROM orders ORDER BY order_date DESC LIMIT 10 OFFSET 10;

SELECT * FROM orders ORDER BY order_date DESC LIMIT 10 OFFSET 20;

SELECT id, product_name, standard_cost FROM products ORDER BY standard_cost DESC LIMIT 1; -- самый дорогой

SELECT id, product_name, standard_cost FROM products ORDER BY standard_cost ASC LIMIT 1; -- самый дешевый

-- УНИКАЛЬНЫЕ ЗНАЧЕНИЯ: DISTINCT
SELECT DISTINCT city FROM customers;

SELECT DISTINCT state_province FROM customers;

SELECT DISTINCT job_title FROM employees;

SELECT DISTINCT payment_type FROM orders WHERE payment_type IS NOT NULL;

SELECT id, title, `imdb.rating` FROM imdb.movies WHERE `imdb.rating` >= 8 ORDER BY `imdb.rating` DESC;

SELECT id, title, year, `imdb.rating` FROM imdb.movies 
WHERE `imdb.rating` >= 8 AND year >= 2010
ORDER BY year DESC, `imdb.rating` DESC;


 
 