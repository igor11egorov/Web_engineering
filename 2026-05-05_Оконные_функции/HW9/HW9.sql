-- Таблица purchase_order_details
USE northwind;
-- 1 Для каждого заказа order_id выведите минимальный, максмальный и средний unit_cost
SELECT purchase_order_id, 
	MIN(unit_cost) OVER(PARTITION BY purchase_order_id) AS min_cost, 
	MAX(unit_cost) OVER(PARTITION BY purchase_order_id) AS max_cost, 
	AVG(unit_cost) OVER(PARTITION BY purchase_order_id) AS avg_cost 
FROM purchase_order_details
ORDER BY purchase_order_id, unit_cost;

-- 2  Оставьте только уникальные строки из предыдущего запроса
SELECT purchase_order_id, 
	MIN(unit_cost) AS min_cost, 
	MAX(unit_cost) AS max_cost, 
	AVG(unit_cost) AS avg_cost 
FROM purchase_order_details
GROUP BY purchase_order_id
ORDER BY purchase_order_id;

-- or

SELECT DISTINCT purchase_order_id, 
	MIN(unit_cost) OVER(PARTITION BY purchase_order_id) AS min_cost, 
	MAX(unit_cost) OVER(PARTITION BY purchase_order_id) AS max_cost, 
	AVG(unit_cost) OVER(PARTITION BY purchase_order_id) AS avg_cost 
FROM purchase_order_details
ORDER BY purchase_order_id;

-- 3 Посчитайте стоимость продукта в заказе как quantity*unit_cost Выведите суммарную стоимость продуктов с помощью оконной функции 
-- Сделайте то же самое с помощью GROUP BY
SELECT product_id, (quantity * unit_cost) AS total_price, 
SUM(quantity * unit_cost) OVER(PARTITION BY product_id) AS sum_price 
FROM purchase_order_details;

SELECT product_id,
SUM(quantity * unit_cost) AS sum_price 
FROM purchase_order_details
GROUP BY product_id;

-- 4 Посчитайте количество заказов по дате получения и posted_to_inventory Если оно превышает 1 то выведите '>1' в противном случае '=1'
-- Выведите purchase_order_id, date_received и вычисленный столбец
SELECT purchase_order_id, date_received, 
IF(COUNT(date_received) OVER(PARTITION BY date_received) > 1, ">1", "=1") AS amount_order
FROM purchase_order_details;