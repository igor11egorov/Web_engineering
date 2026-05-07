USE northwind;

SELECT AVG(quantity * unit_price * (1 - discount)) as avg_position_price FROM order_details;

SELECT id, (quantity * unit_price * (1 - discount)) as position_price FROM order_details ORDER BY position_price DESC;

-- OVER() - добавляет агрегирующую функцию, но не схлопывает таблицу (количество строк, как в начальной таблице, но добавлен столбец)
SELECT id, quantity, AVG(quantity) OVER() AS avg_quantity FROM order_details ORDER BY quantity DESC;

SELECT id, (quantity * unit_price * (1 - discount)) as position_price,
AVG(quantity * unit_price * (1 - discount)) OVER() as avg_position_price
FROM order_details
ORDER BY position_price DESC;

-- PARTITION BY - как GROUP BY для OVER()
SELECT product_id, quantity, AVG(quantity) OVER(PARTITION BY product_id) AS avg_product_quantity
FROM order_details
ORDER BY product_id;

-- 1. Из таблицы products выведите максимальный list_price для каждой строки, имя продукта и его list_price.
SELECT  product_name, list_price, MAX(list_price) OVER() AS max_list_price FROM products ORDER BY product_name;

-- 2. Используя предыдущий запрос посчитайте разницу в процентах между ценой продукта и максимальной ценой.
SELECT  product_name, list_price, MAX(list_price) OVER() AS max_list_price, (MAX(list_price) OVER() - list_price) / MAX(list_price) OVER() * 100 AS dif_price_percent 
FROM products ORDER BY dif_price_percent;

-- 3. Посчитайте количество продуктов в каждой категории с помощью оконной функции Оптимально ли использование оконной функции для выполнения этого задания.
SELECT category, unit_in_stock, SUM(unit_in_stock) OVER(PARTITION BY category) AS sum_product_by_cat,
COUNT(unit_in_stock) OVER(PARTITION BY category) AS total_product_by_cat 
FROM products ORDER BY category;

-- 4. Найдите разницу между standard_cost продукта и средним list_price по всей таблицы для каждой строки.
SELECT product_name, standard_cost, list_price, AVG(list_price) OVER() AS avg_list_price, (standard_cost - AVG(list_price) OVER()) AS dif_price
FROM products ORDER BY dif_price;

-- По схеме
-- Задача 1: Найти количество книг в каждом жанре.
SELECT genre_id, name, COUNT(book_id) AS total_book FROM books 
JOIN genres ON books.genre_id = genres.genre_id
GROUP BY genre_id ORDER BY total_book;

-- Задача 2: Вывести авторов и количество написанных ими книг. Отсортировать по количеству книг по убыванию.
SELECT authors.*, COUNT(books.book_id) AS total_book FROM authors
JOIN book_authors ON book_authors.author_id = authors.author_id
-- JOIN books ON book_authors.book_id = books.book_id -- необязательно именно для этой задачи
GROUP BY author_id ORDER BY total_book DESC;

-- Задача 3: Найти жанры, в которых средний рейтинг книг выше 4.2. Вывести название жанра и средний рейтинг.
SELECT genres.*, rating, AVG(rating) AS avg_rating FROM genres
JOIN books ON books.genre_id = genres.genre_id
JOIN reviews ON books.book_id = reviews.book_id
GROUP BY genre_id 
HAVING avg_rating > 4.2
ORDER BY genre_id;