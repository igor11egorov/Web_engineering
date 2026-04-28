USE northwind;

SELECT id, product_name, 
CASE
	WHEN minimum_reorder_quantity IS NOT NULL THEN true
    ELSE false
END is_minimum_reorder_quantity 
FROM products ORDER BY is_minimum_reorder_quantity;

-- Задания для таблицы Appoitments базы данных medical_healthcare:
USE medical_healthcare;
-- вывести все приёмы, которые ещё не начались.
SELECT *, DATEDIFF(appointment_date, '2024-01-01 00:00:00') AS date_days
FROM Appointments WHERE  DATEDIFF(appointment_date, '2024-01-01 00:00:00') >= 0 ORDER BY appointment_date ASC ;
-- вывести все записи, назначенные на сегодняшнюю дату.
SELECT * 
FROM Appointments WHERE  DATEDIFF(appointment_date, '2024-01-01 00:00:00') = 0 ORDER BY appointment_date ASC ;
-- показать сегодняшние приёмы, которые ещё не наступили по времени.
-- вывести список приёмов, показав дату в виде 14.04.2026 15:30
SELECT *, DATE_FORMAT(appointment_date, '%d.%m.%Y %H:%i') AS appointment_date_formatted
FROM Appointments ORDER BY appointment_date ASC ;
-- вывести приёмы и количество дней до них.
SELECT *, DATEDIFF(appointment_date, '2024-01-01 00:00:00') AS date_days
FROM Appointments ORDER BY appointment_date DESC ;
-- вывести записи, которые были созданы в течение последней недели.

-- вывести все записи с сегодняшнего момента до ближайших трёх дней включительно.
-- вывести, за сколько дней до визита была создана запись.
SELECT *, DATEDIFF(appointment_date, created_at) AS date_days
FROM Appointments ORDER BY date_days DESC ;