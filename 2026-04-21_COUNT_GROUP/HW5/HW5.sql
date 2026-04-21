USE northwind;
-- Работаем с таблицей purchase_order_details
SELECT * FROM purchase_order_details; -- 55 rows
-- 1 Посчитайте основные статистики - среднее, сумму, минимум, максимум столбца unit_cost.
SELECT 
	AVG(unit_cost) AS avg_unit_cost, -- 17.49...
	SUM(unit_cost) AS sum_unit_cost, -- 962.2500
	MIN(unit_cost) AS min_unit_cost, -- 2.0000
	MAX(unit_cost) AS max_unit_cost -- 61.0000
FROM purchase_order_details;
-- 2 Посчитайте количество уникальных заказов purchase_order_id
SELECT COUNT(DISTINCT purchase_order_id) AS total_uniq_purchase_orders -- 28
FROM purchase_order_details; 
-- 3 Посчитайте количество продуктов product_id в каждом заказе purchase_order_id 
-- Отсортируйте полученные данные по убыванию количества
SELECT purchase_order_id, COUNT(*) AS total_products 
FROM purchase_order_details 
GROUP BY purchase_order_id 
ORDER BY total_products DESC;
-- 4 Посчитайте заказы по дате доставки date_received
-- Считаем только те продукты, количество quantity которых больше 30
SELECT date_received, COUNT(*) AS total_products
FROM purchase_order_details 
WHERE quantity > 30
GROUP BY date_received 
ORDER BY date_received DESC;
-- 5 Посчитайте суммарную стоимость заказов в каждую из дат
-- Стоимость заказа - произведение quantity на unit_cost
SELECT date_received, SUM(quantity * unit_cost) AS sum_products
FROM purchase_order_details 
GROUP BY date_received 
ORDER BY date_received DESC;
-- 6 Сгруппируйте товары по unit_cost и вычислите среднее и максимальное значение quantity 
-- только для товаров где purchase_order_id не больше 100
SELECT unit_cost, AVG(quantity) AS avg_quantity, MAX(quantity) AS max_quntity
FROM purchase_order_details 
WHERE purchase_order_id <= 100
GROUP BY unit_cost 
ORDER BY unit_cost;
-- 7 Выберите только строки где есть значения в столбце inventory_id 
-- Создайте столбец category - если unit_cost > 20 то 'Expensive' в остальных случаях 'others' 
-- Посчитайте количество продуктов в каждой категории
SELECT IF(unit_cost > 20, 'Expensive', 'others') AS category, COUNT(*)
FROM purchase_order_details 
WHERE inventory_id IS NOT NULL
GROUP BY category
ORDER BY category;

