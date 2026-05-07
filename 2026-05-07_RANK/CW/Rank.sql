USE northwind;

SELECT * FROM orders;

-- ORDER BY работает как накопительная функция
SELECT id, order_date, shipping_fee, SUM(shipping_fee) OVER(ORDER BY order_date) AS total_shipping_fee 
FROM orders;

SELECT id, order_date, shipping_fee, SUM(shipping_fee) OVER(PARTITION BY order_date ORDER BY shipping_fee) AS total_shipping_fee 
FROM orders;

-- ROW_NUMBER() для последовательной нумерации строк
SELECT order_date, ROW_NUMBER() OVER(PARTITION BY order_date ORDER BY shipping_fee) AS order_number, id, shipping_fee
FROM orders;

-- RANK(). Обязательно передавать сравниваемое в OVER(). Ранжирует МЕСТА по этому переданному значению. 
SELECT RANK() OVER(PARTITION BY order_date ORDER BY shipping_fee) AS rank_shipping_fee, id, order_date, shipping_fee 
FROM orders;

SELECT DENSE_RANK() OVER(ORDER BY shipping_fee) AS rank_shipping_fee, id, order_date, shipping_fee 
FROM orders;

-- NTILE(N) делит на одинаковое количество (N) строк
SELECT NTILE(3) OVER(ORDER BY shipping_fee) AS category, id, order_date, shipping_fee 
FROM orders;

-- Для таблицы products:
-- Задание 1: Пронумеровать строки в таблице в зависимости от названия товара от A до Z.
SELECT product_name, ROW_NUMBER() OVER(ORDER BY product_name) AS order_number
FROM products;

-- Задание 2: Присвоить ранг продукту без пропусков значений в ранге от больше себестоимости к меньшей Вывести ТОП 10 продуктов product_name.
SELECT product_name, standard_cost,  DENSE_RANK() OVER(ORDER BY standard_cost DESC) AS rank_cost 
FROM products LIMIT 10; -- первые 10 строк

SELECT product_name, standard_cost,  DENSE_RANK() OVER(ORDER BY standard_cost) AS rank_cost 
FROM products; -- subrequest
SELECT product_name, standard_cost, rank_cost FROM (SELECT product_name, standard_cost,  DENSE_RANK() OVER(ORDER BY standard_cost) AS rank_cost 
FROM products) AS subreq WHERE rank_cost <= 10; -- строки, имеющие ранг <= 10

-- Задание 3: Разделить все продукты на 4 равных группы в зависимости от list_price Вывести имя продукта, list_price и номер группы
SELECT product_name, list_price, NTILE(4) OVER(ORDER BY list_price) AS category_price
FROM products;

USE shop;

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount FROM ORDERS; 

SELECT ORDER_ID AS id, DATE_FORMAT(ODATE, '%Y-%m') AS date_month, AMT AS amount FROM ORDERS; 

SELECT ORDER_ID AS id, DATE_FORMAT(ODATE, '%Y-%m') AS date_month, SUM(AMT) AS total_month_sum
FROM ORDERS 
GROUP BY (DATE_FORMAT(ODATE, '%Y-%m')); 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
LAG(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS prev_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
LEAD(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS post_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
FIRST_VALUE(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS first_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
LAST_VALUE(AMT) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS last_amount
FROM ORDERS; 

SELECT ORDER_ID AS id, ODATE AS date, AMT AS amount,
NTH_VALUE(AMT, 2) OVER(PARTITION BY DATE_FORMAT(ODATE, '%Y-%m') ORDER BY ODATE) AS second_amount
FROM ORDERS;

-- Таблица purchase_orders:
USE northwind;
-- Задание 1: Из таблицы purchase_orders для каждого поставщика supplier_id выведите дату создания заказа а также дату создания предыдущего заказа.
SELECT supplier_id, creation_date, 
LAG(creation_date) OVER(PARTITION BY supplier_id ORDER BY creation_date) AS prev_date 
FROM purchase_orders;

-- Задание 2: Напишите аналогичный второму задания запрос но с использованием функции LEAD Сравните результаты.
SELECT supplier_id, creation_date, 
LAG(creation_date) OVER(PARTITION BY supplier_id ORDER BY creation_date) AS prev_date,
LEAD(creation_date) OVER(PARTITION BY supplier_id ORDER BY creation_date) AS post_date
FROM purchase_orders;

-- Задание 3: Нaйдите самую раннюю дату submitted_date для каждого менеджера created_by
SELECT created_by, submitted_date, FIRST_VALUE(submitted_date) OVER(PARTITION BY created_by ORDER BY submitted_date) AS frist_date FROM purchase_orders;

SELECT created_by, submitted_date, MIN(submitted_date) AS min_date, 
FIRST_VALUE(submitted_date) OVER(PARTITION BY created_by ORDER BY submitted_date) AS frist_date 
FROM purchase_orders GROUP BY created_by;

SELECT created_by, MIN(submitted_date) AS frist_date FROM purchase_orders GROUP BY created_by;
