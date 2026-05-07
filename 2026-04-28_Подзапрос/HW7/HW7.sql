USE northwind;
-- 1   Вывести названия продуктов таблица products, включая количество заказанных единиц quantity для каждого продукта таблица order_details.
-- Решить задачу с помощью cte и подзапроса
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details GROUP BY product_id; -- subrequest

SELECT product_name, total_quantity FROM products
LEFT JOIN (
	SELECT product_id, SUM(quantity) AS total_quantity
	FROM order_details GROUP BY product_id
) AS products_by_quantity ON products.id = products_by_quantity.product_id
ORDER BY total_quantity;

WITH products_by_quantity AS (
    SELECT product_id, SUM(quantity) AS total_quantity
    FROM order_details GROUP BY product_id
)
SELECT product_name, total_quantity FROM products 
LEFT JOIN products_by_quantity ON products.id = products_by_quantity.product_id
ORDER BY total_quantity;

-- 2  Найти все заказы таблица orders, сделанные после даты самого первого заказа клиента Lee таблица customers.
SELECT id FROM customers WHERE last_name = 'Lee'; -- subrequest (id in [4,29])
SELECT MIN(order_date) FROM orders WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Lee') ; -- subrequest (date = '2006-01-20 00:00:00')
SELECT * FROM orders 
WHERE order_date > (SELECT MIN(order_date) FROM orders WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Lee')) 
ORDER BY order_date;

-- 3 Найти все продукты таблицы  products c максимальным target_level
SELECT MAX(target_level) FROM products; -- subrequest
SELECT * FROM products WHERE target_level = (SELECT MAX(target_level) FROM products);
