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

INSERT INTO "category" (category_title) VALUES ('Smartphones');
INSERT INTO "category" (category_title) VALUES ('Tablets');
INSERT INTO "category" (category_title) VALUES ('Smartwatches');

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

