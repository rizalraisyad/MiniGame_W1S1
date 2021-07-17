CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
);

-- Query OK, 0 rows affected (1.23 sec)

--  show tables;
-- +-----------------------+
-- | Tables_in_food_oms_db |
-- +-----------------------+
-- | categories            |
-- +-----------------------+
-- 1 row in set (0.00 sec)

 INSERT INTO `categories` VALUES (2,'beverage'),(3,'dessert'),(1,'main dish');
-- Query OK, 3 rows affected (0.10 sec)
-- Records: 3  Duplicates: 0  Warnings: 0

 CREATE TABLE `items` (
     `id` int NOT NULL AUTO_INCREMENT,
     `name` varchar(50) DEFAULT NULL,
     `price` int DEFAULT '0',
     PRIMARY KEY (`id`)
     );
-- Query OK, 0 rows affected (0.91 sec)

CREATE TABLE `item_categories` (
  `item_id` int NOT NULL,
  `category_id` int NOT NULL,
  KEY `item_id` (`item_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `item_categories_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `item_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
);
-- Query OK, 0 rows affected (1.08 sec)

 INSERT INTO `items` VALUES (1,'Ice Water',2000),(2,'Air Putih',0),(3,'Spaghetti',40000),(4,'Green Tea Latte',18000),(5,'Orange Juice',15000),(6,'Vanilla Ice Cream',13000),(7,'Cordon Bleu',36000),(8,'French Fries',20000);
-- Query OK, 8 rows affected (0.07 sec)
-- Records: 8  Duplicates: 0  Warnings: 0

 INSERT INTO `item_categories` VALUES (1,1),(2,2),(3,1),(3,1),(4,2),(5,2),(6,3),(7,1);
-- Query OK, 8 rows affected (0.13 sec)
-- Records: 8  Duplicates: 0  Warnings: 0


 select * from item_categories;
-- +---------+-------------+
-- | item_id | category_id |
-- +---------+-------------+
-- |       1 |           1 |
-- |       2 |           2 |
-- |       3 |           1 |
-- |       3 |           1 |
-- |       4 |           2 |
-- |       5 |           2 |
-- |       6 |           3 |
-- |       7 |           1 |
-- +---------+-------------+
-- 8 rows in set (0.00 sec)

 select * from items;
-- +----+-------------------+-------+
-- | id | name              | price |
-- +----+-------------------+-------+
-- |  1 | Ice Water         |  2000 |
-- |  2 | Air Putih         |     0 |
-- |  3 | Spaghetti         | 40000 |
-- |  4 | Green Tea Latte   | 18000 |
-- |  5 | Orange Juice      | 15000 |
-- |  6 | Vanilla Ice Cream | 13000 |
-- |  7 | Cordon Bleu       | 36000 |
-- |  8 | French Fries      | 20000 |
-- +----+-------------------+-------+
-- 8 rows in set (0.00 sec)


-- HOMEWORK3
-- 2. DDL
CREATE TABLE `costumers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(17) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`phone`)
);
-- Query OK, 0 rows affected (0.02 sec)

mysql> describe costumers;
-- +-------+-------------+------+-----+---------+----------------+
-- | Field | Type        | Null | Key | Default | Extra          |
-- +-------+-------------+------+-----+---------+----------------+
-- | id    | int         | NO   | PRI | NULL    | auto_increment |
-- | name  | varchar(50) | YES  |     | NULL    |                |
-- | phone | varchar(17) | YES  | UNI | NULL    |                |
-- +-------+-------------+------+-----+---------+----------------+
-- 3 rows in set (0.00 sec)

CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `costumer_id` int NOT NULL,
  `order_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT item_id FOREIGN KEY (item_id) REFERENCES items (id),
  CONSTRAINT costumer_id FOREIGN KEY (costumer_id) REFERENCES costumers (id)
);

-- Query OK, 0 rows affected (0.02 sec)

mysql> describe order_details;
-- +-------------+------+------+-----+---------+----------------+
-- | Field       | Type | Null | Key | Default | Extra          |
-- +-------------+------+------+-----+---------+----------------+
-- | id          | int  | NO   | PRI | NULL    | auto_increment |
-- | item_id     | int  | NO   | MUL | NULL    |                |
-- | costumer_id | int  | NO   | MUL | NULL    |                |
-- | order_date  | date | NO   |     | NULL    |                |
-- +-------------+------+------+-----+---------+----------------+
-- 4 rows in set (0.00 sec)

  -- 3. DML min(5)
 INSERT INTO `costumers` VALUES (NULL,'Budiawan','+6212345678'),(NULL,'Mary Jones','+6287654321'),(NULL,'Santo','+62123321123'),(NULL,'Renra','+62098789987'),(NULL,'Adjo','+62456654456'),(NULL,'Tri','+62123321456');

--  Query OK, 6 rows affected (0.01 sec)
-- Records: 6  Duplicates: 0  Warnings: 0

-- validation for phone (UNIQUE)
 INSERT INTO `costumers` VALUES (NULL,'Budiawan','+6212345678');
-- ERROR 1062 (23000): Duplicate entry '+6212345678' for key 'costumers.phone'

INSERT INTO `costumers` VALUES (NULL,'Budiawan','+6289753124');
-- Query OK, 1 row affected (0.01 sec)

select * from costumers;
-- +----+------------+--------------+
-- | id | name       | phone        |
-- +----+------------+--------------+
-- |  1 | Budiawan   | +6212345678  |
-- |  2 | Mary Jones | +6287654321  |
-- |  3 | Santo      | +62123321123 |
-- |  4 | Renra      | +62098789987 |
-- |  5 | Adjo       | +62456654456 |
-- |  6 | Tri        | +62123321456 |
-- |  8 | Budiawan   | +6289753124  |
-- +----+------------+--------------+
-- 7 rows in set (0.00 sec)

UPDATE items SET name = 'Nasi Goreng Gila' WHERE id = 1;
-- Query OK, 1 row affected (0.01 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from items;
-- +----+-------------------+-------+
-- | id | name              | price |
-- +----+-------------------+-------+
-- |  1 | Nasi Goreng Gila  |  2000 |
-- |  2 | Air Putih         |     0 |
-- |  3 | Spaghetti         | 40000 |
-- |  4 | Green Tea Latte   | 18000 |
-- |  5 | Orange Juice      | 15000 |
-- |  6 | Vanilla Ice Cream | 13000 |
-- |  7 | Cordon Bleu       | 36000 |
-- |  8 | French Fries      | 20000 |
-- +----+-------------------+-------+
-- 8 rows in set (0.00 sec)

 INSERT INTO `order_details` VALUES 
 (NULL,1,1,'2020-10-10'), (NULL,2,1,'2020-10-10'),
 (NULL,3,2,'2020-10-10'), (NULL,4,2,'2020-10-10'),
 (NULL,3,8,'2020-10-10'), (NULL,5,8,'2020-10-10'), 
 (NULL,1,1,'2020-10-11'), (NULL,2,1,'2020-10-11'),
 (NULL,7,2,'2020-10-11'), (NULL,4,2,'2020-10-11'),
 (NULL,2,3,'2020-10-12'), (NULL,7,3,'2020-10-12'), 
 (NULL,1,4,'2020-10-13'), (NULL,2,4,'2020-10-13'), 
 (NULL,4,5,'2020-10-13'), (NULL,8,5,'2020-10-13'),
 (NULL,4,6,'2020-10-13'), (NULL,1,6,'2020-10-13'),
 (NULL,2,8,'2020-10-13');
 
 mysql> select * from order_details;
-- +----+---------+-------------+------------+
-- | id | item_id | costumer_id | order_date |
-- +----+---------+-------------+------------+
-- | 20 |       1 |           1 | 2020-10-10 |
-- | 21 |       2 |           1 | 2020-10-10 |
-- | 22 |       3 |           2 | 2020-10-10 |
-- | 23 |       4 |           2 | 2020-10-10 |
-- | 24 |       3 |           8 | 2020-10-10 |
-- | 25 |       5 |           8 | 2020-10-10 |
-- | 26 |       1 |           1 | 2020-10-11 |
-- | 27 |       2 |           1 | 2020-10-11 |
-- | 28 |       7 |           2 | 2020-10-11 |
-- | 29 |       4 |           2 | 2020-10-11 |
-- | 30 |       2 |           3 | 2020-10-12 |
-- | 31 |       7 |           3 | 2020-10-12 |
-- | 32 |       1 |           4 | 2020-10-13 |
-- | 33 |       2 |           4 | 2020-10-13 |
-- | 34 |       4 |           5 | 2020-10-13 |
-- | 35 |       8 |           5 | 2020-10-13 |
-- | 36 |       4 |           6 | 2020-10-13 |
-- | 37 |       1 |           6 | 2020-10-13 |
-- | 39 |       2 |           8 | 2020-10-13 |
-- +----+---------+-------------+------------+
-- 19 rows in set (0.00 sec)


-- 4. Display data which cantains all orders information.
select ROW_NUMBER() OVER() as 'Order ID',group_concat(DISTINCT order_details.order_date) as 'Order date',group_concat(DISTINCT costumers.name) as 'Customer name', group_concat(DISTINCT costumers.phone) as 'Customer phone',SUM(items.price) as Total, group_concat(items.name separator ', ') as 'items bought'
from order_details join costumers on order_details.costumer_id = costumers.id
join items on order_details.item_id = items.id
group by order_details.order_date, costumers.phone
order by order_details.order_date;


-- NOTED different price of Nasi Goreng Gila and Air Putih
-- +----------+------------+---------------+----------------+-------+-----------------------------------+
-- | Order ID | Order date | Customer name | Customer phone | Total | items bought                      |
-- +----------+------------+---------------+----------------+-------+-----------------------------------+
-- |        1 | 2020-10-10 | Budiawan      | +6212345678    |  2000 | Air Putih, Nasi Goreng Gila       |
-- |        2 | 2020-10-10 | Mary Jones    | +6287654321    | 58000 | Spaghetti, Green Tea Latte        |
-- |        3 | 2020-10-10 | Budiawan      | +6289753124    | 55000 | Orange Juice, Spaghetti           |
-- |        4 | 2020-10-11 | Budiawan      | +6212345678    |  2000 | Nasi Goreng Gila, Air Putih       |
-- |        5 | 2020-10-11 | Mary Jones    | +6287654321    | 54000 | Cordon Bleu, Green Tea Latte      |
-- |        6 | 2020-10-12 | Santo         | +62123321123   | 36000 | Cordon Bleu, Air Putih            |
-- |        7 | 2020-10-13 | Renra         | +62098789987   |  2000 | Air Putih, Nasi Goreng Gila       |
-- |        8 | 2020-10-13 | Tri           | +62123321456   | 20000 | Green Tea Latte, Nasi Goreng Gila |
-- |        9 | 2020-10-13 | Adjo          | +62456654456   | 38000 | Green Tea Latte, French Fries     |
-- |       10 | 2020-10-13 | Budiawan      | +6289753124    |     0 | Air Putih                         |
-- +----------+------------+---------------+----------------+-------+-----------------------------------+
-- 10 rows in set (0.00 sec)