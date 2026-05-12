CREATE DATABASE sql_indexes_demo_igor;

use sql_indexes_demo_igor;

DROP TABLE IF EXISTS users_demo_igor;

CREATE TABLE users_demo_igor (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    created_at DATETIME NOT NULL
);

SET SESSION cte_max_recursion_depth = 1000000;

INSERT INTO users_demo_igor (
    username,
    email,
    city,
    status,
    age,
    created_at
)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000000
)
SELECT
    CONCAT('user_', n),
    CONCAT('user_', n, '@example.com'),
    CASE 
        WHEN n % 10 = 0 THEN 'Berlin'
        WHEN n % 10 = 1 THEN 'Paris'
        WHEN n % 10 = 2 THEN 'London'
        WHEN n % 10 = 3 THEN 'Madrid'
        WHEN n % 10 = 4 THEN 'Rome'
        WHEN n % 10 = 5 THEN 'Warsaw'
        WHEN n % 10 = 6 THEN 'Prague'
        WHEN n % 10 = 7 THEN 'Vienna'
        WHEN n % 10 = 8 THEN 'Amsterdam'
        ELSE 'Lisbon'
    END,
    CASE
        WHEN n % 3 = 0 THEN 'active'
        WHEN n % 3 = 1 THEN 'inactive'
        ELSE 'blocked'
    END,
    18 + (n % 60),
    DATE_ADD('2020-01-01 00:00:00', INTERVAL n SECOND)
FROM numbers;

SELECT * FROM users_demo_igor WHERE email = 'user_500000@example.com';

EXPLAIN ANALYZE SELECT * FROM users_demo_igor WHERE email = 'user_500000@example.com';
-- '-> Filter: (users_demo_tim.email = \'user_500000@example.com\')  
 -- (cost=100868 rows=99563) (actual time=329..657 rows=1 loops=1)\n    
 -- -> Table scan on users_demo_tim  (cost=100868 rows=995625) (actual time=0.0764..500 rows=1e+6 loops=1)\n'
 -- Result 0.66 sec

EXPLAIN ANALYZE SELECT * FROM users_demo_igor WHERE id = 500000;
-- -> Rows fetched before execution  (cost=0..0 rows=1) (actual time=82e-6..123e-6 rows=1 loops=1)

CREATE INDEX idx_users_demo_igor_email ON users_demo_igor(email);

EXPLAIN ANALYZE SELECT * FROM users_demo_igor WHERE email = 'user_500000@example.com';
-- -> Index lookup on users_demo_igor using idx_users_demo_igor_email (email='user_500000@example.com')  (cost=0.35 rows=1) 
-- (actual time=0.0348..0.0365 rows=1 loops=1)
-- Rssult 0.04 sec

-- По функциям индекс не работает. Надо создавать свой индекс для функций
EXPLAIN ANALYZE SELECT * FROM users_demo WHERE LOWER(email) = 'user_500000@example.com';
 /*
 -> Filter: (lower(users_demo.email) = 'user_500000@example.com')  
		(cost=100954 rows=995517) (actual time=400..805 rows=1 loops=1)
     -> Table scan on users_demo  (cost=100954 rows=995517) 
			(actual time=0.0838..524 rows=1e+6 loops=1)
 */
 
 CREATE INDEX idx_users_demo_lower_email ON users_demo((LOWER(email)));
 
 EXPLAIN ANALYZE SELECT * FROM users_demo WHERE LOWER(email) = 'user_500000@example.com';
 /*
 -> Index lookup on users_demo using idx_users_demo_lower_email 
 (lower(email)='user_500000@example.com')  
 (cost=0.35 rows=1) (actual time=0.0356..0.0373 rows=1 loops=1)
 */
 
 EXPLAIN ANALYZE SELECT * FROM users_demo WHERE city = 'Berlin' AND status = 'active';
/*
-> Filter: ((users_demo.`status` = 'active') and (users_demo.city = 'Berlin'))  
	(cost=100982 rows=9955) (actual time=0.0868..666 rows=33333 loops=1)
     -> Table scan on users_demo  (cost=100982 rows=995476) 
			(actual time=0.073..529 rows=1e+6 loops=1)
*/

CREATE INDEX idx_users_demo_city_status ON users_demo(city, status);

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE city = 'Berlin' AND status = 'active';
/*
-> Index lookup on users_demo using idx_users_demo_city_status (city='Berlin', status='active')  
(cost=11113 rows=68112) (actual time=0.283..134 rows=33333 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE city = 'Berlin';
/*
-> Index lookup on users_demo using idx_users_demo_city_status (city='Berlin')  
	(cost=25937 rows=216350) (actual time=0.254..384 rows=100000 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM users_demo WHERE status = 'active';
/*
-> Filter: (users_demo.`status` = 'active')  (cost=100982 rows=99548) 
		(actual time=0.0838..653 rows=333333 loops=1)
     -> Table scan on users_demo  (cost=100982 rows=995476) 
			(actual time=0.0797..529 rows=1e+6 loops=1)
*/

CREATE TABLE orders_demo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    country VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    created_at DATETIME NOT NULL
);
SET SESSION cte_max_recursion_depth = 1000000;

INSERT INTO orders_demo (
    order_number,
    customer_name,
    customer_email,
    country,
    status,
    payment_method,
    total_amount,
    created_at
)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 1000000
)
SELECT
    CONCAT('ORD-', LPAD(n, 7, '0')),
    CONCAT('Customer ', n),
    CONCAT('customer_', n, '@shop.test'),
    CASE
        WHEN n % 10 = 0 THEN 'Germany'
        WHEN n % 10 = 1 THEN 'France'
        WHEN n % 10 = 2 THEN 'Spain'
        WHEN n % 10 = 3 THEN 'Italy'
        WHEN n % 10 = 4 THEN 'Poland'
        WHEN n % 10 = 5 THEN 'Netherlands'
        WHEN n % 10 = 6 THEN 'Austria'
        WHEN n % 10 = 7 THEN 'Belgium'
        WHEN n % 10 = 8 THEN 'Portugal'
        ELSE 'Czech Republic'
    END,
    CASE
        WHEN n % 5 = 0 THEN 'new'
        WHEN n % 5 = 1 THEN 'paid'
        WHEN n % 5 = 2 THEN 'shipped'
        WHEN n % 5 = 3 THEN 'delivered'
        ELSE 'cancelled'
    END,
    CASE
        WHEN n % 4 = 0 THEN 'card'
        WHEN n % 4 = 1 THEN 'paypal'
        WHEN n % 4 = 2 THEN 'bank_transfer'
        ELSE 'cash'
    END,
    ROUND(10 + (n % 5000) * 0.37, 2),
    DATE_ADD('2023-01-01 00:00:00', INTERVAL n SECOND)
FROM numbers;

-- Для каждой задачи ответьте на вопросы:
-- 1. Сколько строк MySQL просмотрел до создания индекса?
-- 2. Как изменился план после создания индекса?
-- 3. Какой индекс начал использоваться?
-- 4. Почему это поле/поля хорошо подходит для обычного индекса?

-- Задание 1: Найдите пользователей по стране. Проанализируйте, как выполняется этот запрос и если нужно - создайте для него индекс.
EXPLAIN ANALYZE SELECT * FROM orders_demo WHERE country = 'Spain';
-- -> Filter: (orders_demo.country = 'Spain')  (cost=101125 rows=99243) (actual time=0.0854..764 rows=100000 loops=1)
--     -> Table scan on orders_demo  (cost=101125 rows=992425) (actual time=0.0805..669 rows=1e+6 loops=1)
CREATE INDEX idx_orders_demo_country ON orders_demo(country);
EXPLAIN ANALYZE SELECT * FROM orders_demo WHERE country = 'Spain';
-- -> Index lookup on orders_demo using idx_orders_demo_country (country='Spain')  (cost=25566 rows=199182) (actual time=0.272..334 rows=100000 loops=1)

-- Задание 2: Найдите пользователя по имени в нижнем регистре. Проанализируйте, как выполняется этот запрос и если нужно - создайте для него индекс.
EXPLAIN ANALYZE SELECT * FROM orders_demo WHERE LOWER(customer_name) = 'customer 110';
-- -> Filter: (lower(orders_demo.customer_name) = 'customer 110')  (cost=101125 rows=992425) (actual time=0.202..903 rows=1 loops=1)
--     -> Table scan on orders_demo  (cost=101125 rows=992425) (actual time=0.0875..612 rows=1e+6 loops=1)
CREATE INDEX idx_orders_demo_lower_customer_name ON orders_demo((LOWER(customer_name)));
EXPLAIN ANALYZE SELECT * FROM orders_demo WHERE LOWER(customer_name) = 'customer 110';
-- -> Index lookup on orders_demo using idx_orders_demo_lower_customer_name (lower(customer_name)='customer 110')  
-- (cost=0.35 rows=1) (actual time=0.0385..0.0406 rows=1 loops=1)

-- Задание 3: найдите пользователя по стране и статусу оплаты.  Проанализируйте, как выполняется этот запрос и если нужно - создайте для него индекс.
EXPLAIN ANALYZE SELECT * FROM orders_demo WHERE country = 'Spain' AND status = 'new';
-- -> Filter: (orders_demo.`status` = 'new')  (cost=7639 rows=19918) (actual time=304..304 rows=0 loops=1)
--     -> Index lookup on orders_demo using idx_orders_demo_country (country='Spain')  (cost=7639 rows=199182) (actual time=0.201..295 rows=100000 loops=1)
CREATE INDEX idx_orders_demo_country_status ON orders_demo(country, status);
EXPLAIN ANALYZE SELECT * FROM orders_demo WHERE country = 'Spain' AND status = 'new';
-- -> Index lookup on orders_demo using idx_orders_demo_country_status (country='Spain', status='new')  (cost=0.35 rows=1) 
-- (actual time=0.0321..0.0321 rows=0 loops=1)

-- Задание 4: подумайте, какие индексы еще можно создать для удобства запросов к этой таблице. Опишите свои мысли
