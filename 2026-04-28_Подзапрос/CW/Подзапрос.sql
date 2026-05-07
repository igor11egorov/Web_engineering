USE northwind;

SELECT invoices.id, invoice_date, due_date, tax, shipping, amount_due, order_id
FROM invoices
JOIN orders ON invoices.order_id = orders.id;

-- Для базы данных medical_helthcare:
USE medical_healthcare;
-- Задание 1: Соберите first_name, last_name, phone и отдельный столбец table_from, равный "patient" или "doctor" 
-- из таблиц Doctors и Patients. Дубли оставляйте.
SELECT first_name, last_name, phone, 'patient' AS table_from FROM Patients
UNION ALL
SELECT first_name, last_name, phone, 'doctor' AS table_from FROM Doctors ORDER BY phone;

-- Задание 2: Вывести все записи за 2024 год, добавив id, first_name, last_name и телефон доктора.
SELECT Appointments.*, 
first_name, last_name, phone
FROM Appointments
JOIN Doctors ON Appointments.doctor_id = Doctors.doctor_id
WHERE YEAR(appointment_date) = 2024;

-- Задание 3: Добавьте в предыдущем задании id, first_name, last_name и телефон пациента.
SELECT Appointments.*, 
Doctors.first_name AS doctor_first_name, Doctors.last_name AS doctor_last_name, Doctors.phone AS doctor_phone,
Patients.first_name AS patient_first_name , Patients.last_name AS patient_last_name , Patients.phone AS patient_phone
FROM Appointments
JOIN Doctors ON Appointments.doctor_id = Doctors.doctor_id
JOIN Patients ON Appointments.patient_id = Patients.patient_id
WHERE YEAR(appointment_date) = 2024;

-- Задание 4: Выведите пациента, а также всю информацию об его адресе и страховке.
SELECT Patients.*, Addresses.*, Insurances.*
FROM Patients
JOIN Addresses ON Patients.address_id = Addresses.address_id
JOIN Insurances ON Patients.insurance_id = Insurances.insurance_id;


-- Задание 5: добавьте к предыдущему запросу информацию о его медицинской истории.
SELECT Patients.*, Addresses.*, Insurances.*, Medical_History.*
FROM Patients
JOIN Addresses ON Patients.address_id = Addresses.address_id
JOIN Insurances ON Patients.insurance_id = Insurances.insurance_id
JOIN Medical_History ON Patients.patient_id = Medical_History.patient_id ;

USE northwind;

SELECT AVG(unit_price) AS avg_unit_price FROM order_details;

-- SET сохраняет переменную, только ОДНО значение
SET @avg_unit_price = (SELECT AVG(unit_price) FROM order_details);
SELECT * FROM order_details WHERE unit_price > @avg_unit_price ORDER BY unit_price;

SELECT * FROM order_details 
WHERE unit_price > (SELECT AVG(unit_price) FROM order_details)
ORDER BY unit_price;

SELECT * FROM customers WHERE city = 'Los Angelas';

SELECT * FROM orders WHERE customer_id IN (SELECT id FROM customers WHERE city = 'Los Angelas');

-- Для таблицы nothwind:
USE northwind;
-- Задание 1: выбрать все заказы, оформленные сотрудниками с должностью 'Sales Representative'.
SELECT id FROM employees WHERE job_title = 'Sales Representative';
SELECT * FROM orders WHERE employee_id IN (SELECT id FROM employees WHERE job_title = 'Sales Representative');

-- Задание 2: Выбрать все заказы, стоимость которых выше средней.
SELECT id, order_date FROM orders;
-- найти стоимость каждого заказа
SELECT order_id, SUM(quantity * unit_price * (1 - discount)) AS order_price FROM order_details
GROUP BY order_id ORDER BY order_id ASC;
-- найти среднюю стоимость заказа
SELECT AVG(order_price) AS avg_order_price 
FROM (SELECT order_id, SUM(quantity * unit_price * (1 - discount)) AS order_price FROM order_details
GROUP BY order_id) AS order_by_price;
-- отфильтровать заказы по стоимости
SELECT id FROM orders
WHERE (SELECT SUM(quantity * unit_price * (1 - discount)) AS order_price 
FROM order_details 	WHERE order_details.order_id = orders.id GROUP BY order_id) > (
SELECT AVG(order_price) AS avg_price
FROM (
SELECT order_id, SUM(quantity * unit_price * (1 - discount)) AS order_price 
FROM order_details GROUP BY order_id
) AS t
);

-- Задание 3: Выбрать все товары, в которых разница между оптовой и отпускной ценой меньше средней.
SELECT AVG(list_price - standard_cost) FROM products;
SELECT *, (list_price - standard_cost) AS product_dif,
(SELECT AVG(list_price - standard_cost) FROM products) AS avg_product_dif 
FROM products WHERE (list_price - standard_cost) < (SELECT AVG(list_price - standard_cost) FROM products)
ORDER BY product_dif;
