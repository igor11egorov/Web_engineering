USE medical_healthcare;

-- Задание 1: из таблицы Doctors базы данных medical_healthcare:
-- выберите имя и фамилию врача, а также и объедините их в одно поле full_name
-- отсортируйте врачей по полю created_at по возрастанию
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
-- , created_at 
FROM Doctors ORDER BY created_at ASC;

-- Задание 2: из таблицы Doctors базы данных medical_healthcare Выведите список врачей, с такими условиями:
-- если email NULL, вывести строку "no email";
-- покажите только первые 5 записей
SELECT *, COALESCE(email, 'no email') AS filled_email FROM Doctors LIMIT 5; 

-- Задание 3: из таблицы Patients базы данных medical_healthcare:
-- выводит уникальные treatment_type пациентов;
-- пропускает пациентов, у которых treatment_type NULL
SELECT DISTINCT treatment_type FROM Patients WHERE treatment_type IS NOT NULL;

-- Задание 4: Из таблицы Patients базы данных medical_healthcare, напишите запрос, который выводит пациентов:
-- где первая буква имени — A или M
-- создается новое поле has_phone с такими значениями: “yes” если телефон есть и “no” - если его нет
-- отсортируйте записи по last_name по возрастанию
-- пропустите первые 10 записей и выведите 10;
SELECT *, IF(phone IS NULL, 'no', 'yes') AS has_phone FROM Patients WHERE first_name LIKE 'A%' OR first_name LIKE 'M%' ORDER BY last_name ASC LIMIT 10 OFFSET 10;

-- Задание 5: Из таблицы Appointments базы данных medical_healthcare выведи список приёмов
-- с appointment_date > '2024-01-01'
SELECT * FROM Appointments WHERE appointment_date > '2024-01-01' ORDER BY appointment_date ASC;

-- Задание 6: Из таблицы Address выберите все уникальные названия штатов.
SELECT DISTINCT state FROM Addresses;

-- Задание 7: Из таблицы Diagnoses:
-- выберите все диагнозы, где в заметках есть слово "drug". 
-- Отсортируйте их по дате изменения;
SELECT * FROM Diagnoses WHERE notes LIKE '%drug%' ORDER BY updated_at ASC;


-- Задание 8: из таблицы Treatments:
-- выберите  уникальные названия процедур;
-- отсортируйте из по убыванию стоимости;
-- покажите первые 10.
SELECT DISTINCT treatment_name, cost FROM Treatments ORDER BY cost DESC LIMIT 10;


-- Задание 9: Из таблицы Insurance_Bills:
-- выберите все счета;
-- Добавьте им поле paid_status равное "completed" если счет оплачен и "not_completed" - если нет.
SELECT *, IF(status = 'Paid', 'completed', 'not_completed') AS paid_status FROM Insurance_Bills;

-- Задание 10: Из таблицы Insurance_Bills:
-- выберите неоплаченные счета;
-- добавьте колонку, отображающую разницу между общей стоимостью и  суммой к оплате
SELECT *, (total_amount - amount_due) AS difference_pay FROM Insurance_Bills WHERE status != 'Paid';