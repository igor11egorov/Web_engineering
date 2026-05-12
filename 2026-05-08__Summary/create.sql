CREATE DATABASE 281125_wdm_egorov_080526;

USE 281125_wdm_egorov_080526;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    customer_address VARCHAR(255) NOT NULL,
    products VARCHAR(500) NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    delivery_cost DECIMAL(10,2) NOT NULL CHECK (delivery_cost > 0)
);

INSERT INTO orders (
    customer_name,
    customer_phone,
    customer_address,
    products,
    delivery_address,
    delivery_cost
) VALUES
('Иван Петров', '+79991234567', 'Москва, ул. Ленина, 10', 'Ноутбук Lenovo, Мышь Logitech', 'Москва, ул. Гагарина, 15', 450.00),
('Анна Смирнова', '+79992345678', 'Санкт', 'Петербург, Невский пр., 22', 'iPhone 15, Чехол', 'Санкт', 'Петербург, ул. Марата, 7', 300.00),
('Дмитрий Волков', '+79993456789', 'Казань, ул. Баумана, 5', 'Монитор Samsung 27"', 'Казань, ул. Победы, 18', 550.00),
('Елена Кузнецова', '+79994567890', 'Новосибирск, ул. Кирова, 12', 'Клавиатура Keychron, Наушники Sony', 'Новосибирск, ул. Советская, 30', 400.00),
('Сергей Орлов', '+79995678901', 'Екатеринбург, ул. Малышева, 44', 'PlayStation 5', 'Екатеринбург, ул. Восточная, 9', 700.00),
('Мария Федорова', '+79996789012', 'Самара, ул. Авроры, 19', 'Планшет iPad Air', 'Самара, ул. Ленинградская, 25', 350.00),
('Алексей Морозов', '+79997890123', 'Омск, ул. Лермонтова, 8', 'Смарт', 'часы Garmin', 'Омск, ул. Жукова, 14', 280.00),
('Ольга Николаева', '+79998901234', 'Челябинск, ул. Труда, 77', 'Телевизор LG 55"', 'Челябинск, ул. Свободы, 11', 950.00),
('Никита Соколов', '+79999012345', 'Ростов', 'на', 'Дону, ул. Пушкина, 3', 'Фотоаппарат Canon EOS', 'Ростов', 'на', 'Дону, ул. Садовая, 20', 620.00),
('Татьяна Белова', '+79990123456', 'Краснодар, ул. Северная, 41', 'Колонка JBL, PowerBank Xiaomi', 'Краснодар, ул. Красная, 66', 260.00);

-- Задание 1: Создайте базу данных интернет-магазина по продаже бумажных книг.
-- Создай внутри базы таблицу с книгами для продажи. В таблице должны храниться такие данные:
-- название книги;
-- авторы;
-- жанры;
-- цена;
-- количество на складе.
CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    authors VARCHAR(255) NOT NULL,
    genres VARCHAR(255) NOT NULL,
    cost DECIMAL(10,2) NOT NULL CHECK (cost > 0),
    amount INT NOT NULL CHECK (amount >= 0)
);
-- Заполните таблицу данным, например такими:
-- Good Omens', 'Terry Pratchett, Neil Gaiman', 'Fantasy, Comedy', '14.99', '10
-- 1984', 'George Orwell', 'Dystopia, Political Fiction, Classic', '9.99', '15
-- The Hobbit', 'J. R. R. Tolkien', 'Fantasy, Adventure', '12.50', '8
-- Clean Code', 'Robert C. Martin', 'Programming, Software Engineering', '29.99', '6
-- The Pragmatic Programmer', 'Andrew Hunt, David Thomas', 'Programming, Software Development', '34.50', '4
INSERT INTO books (title, authors, genres, cost, amount) VALUES
('Good Omens','Terry Pratchett, Neil Gaiman', 'Fantasy, Comedy', 14.99, 10),
('1984', 'George Orwell', 'Dystopia, Political Fiction, Classic', 9.99, 15),
('The Hobbit', 'J. R. R. Tolkien', 'Fantasy, Adventure', 12.50, 8),
('Clean Code', 'Robert C. Martin', 'Programming, Software Engineering', 29.99, 6),
('The Pragmatic Programmer', 'Andrew Hunt, David Thomas', 'Programming, Software Development', 34.50, 4);

ALTER TABLE orders
DROP customer_address;

ALTER TABLE orders
ADD customer_state VARCHAR(100) NOT NULL;
ALTER TABLE orders
ADD customer_city VARCHAR(100) NOT NULL;
ALTER TABLE orders
ADD customer_address VARCHAR(100) NOT NULL;
ALTER TABLE orders
ADD customer_postal_code VARCHAR(100) NOT NULL;



