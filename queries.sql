# sudo -u postgres psql - enter psql with postgres privileges
# \q - exit psql
# \l - databases list
# \c <db_name> - connect to database
# \d - tables list
# psql -U <username>
# \d+ <tablename> - information about table


CREATE ROLE shop LOGIN CREATEDB PASSWORD 'shop';
CREATE DATABASE shop WITH OWNER=shop ENCODING='UTF8';

CREATE TABLE "category" (
    category_id SERIAL PRIMARY KEY,
    category_title VARCHAR(100)
);

CREATE TABLE "item" (
    item_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL,
    item_title VARCHAR(100) NOT NULL,
    item_price NUMERIC(8, 2) NOT NULL
);

INSERT INTO "category" (category_title) VALUES
('Smartphones'), ('Tablets'), ('Smartwatches');

SELECT * FROM "category";
SELECT category_title FROM "category";

INSERT INTO "item" (category_id, item_title, item_price) VALUES
(1, 'iPhone', 999.99),
(1, 'Galaxy 7', 800.00),
(1, 'OnePlus 7', 500.00),
(2, 'iPad', 1999.99),
(2, 'Lenovo Turbo', 300.00),
(3, 'iWatch', 500.00),
(3, 'Zenith', 22200.00);

SELECT * FROM "item" ORDER BY item_price ASC;
SELECT * FROM "item" ORDER BY item_price DESC;
SELECT * FROM "item" WHERE category_id = 1 ORDER BY item_price DESC;
SELECT * FROM "item" WHERE category_id = 1 AND item_price < 600;
UPDATE "item" SET item_price = 499.99 WHERE item_id = 6;
DELETE FROM "item" WHERE item_id = 3;


-- 1. Создать базу данных shop.
-- 2. Создать юзера shop и дать ему полный доступ к БД shop.
-- 4. Создать таблицу для хранения категорий (хранить название).
-- 5. Добавить несколько категорий.
-- 6. Создать таблицу для хранения товаров (название, категория, цена).
-- 7. Внести несколько товаров по цене 1.00
-- 8. Обновить цену первого товара — 3.50
-- 9. Увеличить цену всех товаров на 10%.
-- 10. Удалить товар № 2.
-- 11. Выбрать все товары с сортировкой по названию.
-- 12. Выбрать все товары с сортировкой по убыванию цены.
-- 13. Выбрать 3 самых дорогих товара.
-- 14. Выбрать 3 самых дешевых товара.
-- 15. Выбрать вторую тройку самых дорогих товаров (с 4 по 6).
-- 16. Выбрать наименование самого дорогого товара.
-- 17. Выбрать наименование самого дешевого товара.
-- 18. Выбрать количество всех товаров.
-- 19. Выбрать среднюю цену всех товаров.

select * from item join category on item.category_id = category.category_id;
select * from item natural join category;


INSERT INTO "item" (category_id, item_title, item_price) VALUES
(4, 'GoPro', 999.99);


CREATE TABLE "category" (
    category_id SERIAL PRIMARY KEY,
    category_title VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE "item" (
    item_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES "category"(category_id) ON DELETE CASCADE,
    item_title VARCHAR(100) NOT NULL,
    item_price NUMERIC(8, 2) NOT NULL
);

CREATE TABLE "item" (
    item_id SERIAL PRIMARY KEY,
    category_id INTEGER NULL REFERENCES "category"(category_id) ON DELETE SET NULL,
    item_title VARCHAR(100) NOT NULL,
    item_price NUMERIC(8, 2) NOT NULL
);

CREATE TABLE "item" (
    item_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL DEFAULT 1 REFERENCES "category"(category_id) ON DELETE SET DEFAULT,
    item_title VARCHAR(100) NOT NULL,
    item_price NUMERIC(8, 2) NOT NULL
);