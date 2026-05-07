USE northwind;

-- Для таблицы products:
-- Задание 1: Вывести product_name, list_price всех товаров, у которых цена выше средней цены по всем товарам.
SELECT AVG(list_price) FROM products;
SELECT product_name, list_price FROM products WHERE list_price > (SELECT AVG(list_price) FROM products);

-- Задание 2: Найти товары, у которых list_price равен максимальной цене в таблице.
SELECT MAX(list_price) FROM products;
SELECT * FROM products WHERE list_price = (SELECT MAX(list_price) FROM products);

-- Задание 3: Вывести товары, цена которых ниже средней цены товаров той же категории.
SELECT category, AVG(list_price) AS avg_list_price FROM products GROUP BY category;
SELECT * FROM products 
JOIN (SELECT category, AVG(list_price) AS avg_list_price FROM products GROUP BY category) AS avg_price_by_category 
ON products.category = avg_price_by_category.category
WHERE list_price < avg_list_price;

-- var2
SELECT * FROM products 
WHERE list_price < (
  SELECT AVG(p2.list_price) FROM products AS p2
    WHERE p2.category = products.category
);

-- Задание 4: Выведите категории со средней ценой товара больше 100.
SELECT category, AVG(list_price) AS avg_list_price FROM products GROUP BY category;
SELECT category FROM (SELECT category, AVG(list_price) AS avg_list_price FROM products GROUP BY category) 
AS avg_price_by_category WHERE avg_list_price > 100;

-- WITH делает подтаблицу
SELECT AVG(order_price) AS avg_order_price 
FROM (SELECT order_id, SUM(quantity * unit_price * (1 - discount)) AS order_price FROM order_details
GROUP BY order_id) AS order_by_price;

-- запрос выше разбивается на две части, в первой формируется таблица, во второй осуществляется выборка
WITH t_order_price AS (
SELECT order_id, SUM(quantity * unit_price * (1 - discount)) AS order_price FROM order_details
GROUP BY order_id
)
SELECT AVG(order_price) AS avg_order_price FROM t_order_price;


