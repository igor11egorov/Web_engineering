-- Таблица order_details
USE northwind;
-- 1 Для каждого product_id выведите inventory_id а также предыдущий и последующей inventory_id по убыванию quantity
SELECT 
	product_id, 
	inventory_id, 
	LAG(inventory_id) OVER(PARTITION BY product_id ORDER BY quantity DESC) AS prev_inv_id,
	LEAD(inventory_id) OVER(PARTITION BY product_id ORDER BY quantity DESC) AS post_inv_id,
	quantity
FROM order_details;

-- 2 Выведите максимальный и минимальный unit_price для каждого order_id с помощью функции FIRST VALUE  Вывести order_id и полученные значения
SELECT 
	order_id, 
	unit_price, 
	FIRST_VALUE(unit_price) OVER(PARTITION BY order_id ORDER BY unit_price) AS min_unit_price,
	FIRST_VALUE(unit_price) OVER(PARTITION BY order_id ORDER BY unit_price DESC) AS max_unit_price
FROM order_details;

-- 3 Выведите order_id и столбец с разнице между  unit_price для каждой заказа и минимальным unit_price в рамках одного заказа 
-- Задачу решить двумя способами - с помощью First VAlue и MIN

-- 4 Присвойте ранг каждой строке используя RANK по убыванию quantity

-- 5  Из предыдущего запроса выберите только строки с рангом до 10 включительно