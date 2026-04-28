USE northwind;

-- 1 Выведите одним запросом с использованием UNION столбцы id, employee_id из таблицы orders
-- и соответствующие им столбцы из таблицы purchase_orders В таблице purchase_orders  created_by соответствует employee_id
SELECT id, employee_id FROM orders
UNION  
SELECT id, created_by AS employee_id FROM purchase_orders;

-- 2 Из предыдущего запроса удалите записи там где employee_id не имеет значения Добавьте дополнительный столбец 
-- со сведениями из какой таблицы была взята запись
SELECT id, employee_id, 'orders' AS from_table  FROM orders 
WHERE employee_id IS NOT NULL
UNION  
SELECT id, created_by AS employee_id, 'purchase_orders' AS from_table FROM purchase_orders 
WHERE created_by IS NOT NULL;

-- 3 Выведите все столбцы таблицы order_details а также дополнительный столбец payment_method из таблицы purchase_orders 
-- Оставьте только заказы для которых известен payment_method 
SELECT order_details.*, purchase_orders.payment_method AS purchase_orders_payment_method
FROM order_details 
JOIN purchase_orders ON order_details.purchase_order_id = purchase_orders.id
WHERE purchase_orders.payment_method IS NOT NULL;

-- 4 Выведите заказы orders и фамилии клиентов customers для тех заказов по которым были инвойсы таблица invoices
SELECT orders.*, last_name, invoice_date
FROM orders
JOIN customers ON customers.id = orders.customer_id
JOIN invoices ON orders.id = invoices.order_id;

-- 5 Подсчитайте количество инвойсов для каждого клиента из предыдущего запроса
SELECT orders.*, last_name, COUNT(*) AS total_invoices
FROM orders
JOIN customers ON customers.id = orders.customer_id
JOIN invoices ON orders.id = invoices.order_id
GROUP BY last_name
ORDER BY last_name;

