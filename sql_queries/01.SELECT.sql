
-- this is a comment 
/* this is a multimline comment 
    this is the second line
*/

SELECT 1+1; -- this is a comment till the end of the line
SELECT 1+1; 
SELECT 1+1; /* this is a comment */
SELECT 1+1; /* this is a comment
that can extend to mutliple lines
*/
SELECT 1 + /* this can also be an in-line comment */ 1 as result;


SELECT 'Hello, SQL'; -- single quotes for strings

SELECT "Hello, SQL"; -- double quotes for strings

SELECT "My", "name", "is", "Ahmed"; -- select multiple values

SELECT 1, "Test"; -- select different data types

SELECT 'Hello, SQL' AS greeting; -- alias

SELECT "'This is a quoted text'"; -- embed different qoutes

-- another way is to use the backslash as an escape character
SELECT "\'This is a quoted text\'";
-- SELECT "This is a single quote \' and this is a doublequote \"";
SELECT "Line 1\nLine 2\nLine 3";
SELECT "This is a path in windows C:\\my\\folder\\path";

-- arithmetic
SELECT 1 + 2;

SELECT 5 % 2;

-- boolean
SELECT 1 = 2;

SELECT 1 <> 2;
SELECT 1!=2;

SELECT 'Hello, SQL' = 'Hello, SQL';

SELECT 'hello, sql' = 'Hello, SQL';  -- SQL is case insensitive by default

SELECT 'Hello, SQL' LIKE 'Hello, SQL';

SELECT 'Hello, SQL' LIKE 'Hello, %';



-- charactersets and collations
SELECT 'a' =  'ä';
SELECT 'a' LIKE 'ä';

SELECT 'a' =  'ä' COLLATE utf8mb4_german2_ci;
SELECT 'a' LIKE 'ä' COLLATE utf8mb4_german2_ci;

SELECT 'a' like  'ä' COLLATE utf8mb4_cs_0900_as_cs;
SELECT 'a' like 'A' COLLATE utf8mb4_cs_0900_as_cs;  -- accent and case sensitive
-- built-in functions and operators 
-- https://dev.mysql.com/doc/refman/8.0/en/built-in-function-reference.html

SELECT ABS(-5); -- absolute values
SELECT ASCII('a'), ASCII('ä');
SELECT ASCII('ab');
SELECT CHAR(65);  -- return the ascii character that correspond to the number
SELECT CHAR(ASCII('d'));

-- date and time functions
SELECT ADDDATE('2022-12-08', 24);
SELECT 
    ADDDATE('2022-12-08', 24),
    DAY('2022-12-08'),
    DAYNAME('2022-12-08'),
    MONTH('2022-12-08'),
    MONTHNAME('2022-12-08'),
    YEAR('2022-12-08');
SELECT CURDATE();

-- string functions
SELECT CONCAT('my', 'name', 'is', 'prince');
SELECT CONCAT_WS(' ', 'my', 'name', 'is', 'prince');
SELECT LENGTH('ahmed');
SELECT LENGTH(CONCAT_WS('', 'my', 'name', 'is', 'prince'));
SELECT LOWER('AHMED');
SELECT LEFT('This is the a text', 10);
SELECT LEFT('EZEKIAL',3);
SELECT RIGHT('This is the a text', 10);
SELECT SUBSTR('This is a long text', 6, 9);
SELECT TRIM('  bar   ');
SELECT TRIM(LEADING 'x' FROM 'xbarx');
SELECT TRIM(TRAILING 'x' FROM 'xbarx');
SELECT TRIM(BOTH 'x' FROM 'xbarx');


SELECT TRIM(LEADING 'A' from actor.first_name) as first_name_a_trimmmed, actor.first_name from actor;


SELECT TRUE, FALSE;
SELECT 'b' IN ('a' , 'b', 'c', 'd', 'e', 'f');
SELECT 'b' NOT IN ('a' , 'b', 'c', 'd', 'e', 'f');
SELECT instr("abcdefg", "f") IS TRUE;
SELECT instr("abcdefg", "x") IS TRUE;
-- check if a record contains anchor tag 
SELECT instr('<a href=\'https://www.google.com\'></a>','</a>');
-- returns the position of the first occurence
SELECT ISNULL(NULL);
SELECT ISNULL(1/0);
SELECT ISNULL('');  -- empty quote is not a null value

SELECT 5 between 1 AND 10;

SELECT IF(5 < 4, "TRUE", "FALSE");

-- assignment operator SET using := and = 
-- assignment operator SELECT using :=
SET @var5 := 5;
SET @vara = 'a';
SELECT @var5, @vara, @var10 := 10;

SELECT @var11 = 11; -- null

--  select from tables
--
SELECT actor_id FROM sakila.actor;
SELECT count(actor_id) FROM sakila.actor;
SELECT DISTINCT actor_id FROM sakila.actor;
SELECT actor_id, first_name FROM sakila.actor;
USE sakila;
SELECT actor_id, first_name FROM actor;
SELECT actor_id, first_name FROM actor LIMIT 5;
SELECT actor_id, first_name FROM actor LIMIT 5, 10; -- start from 6 and stop at 15
SELECT actor_id, first_name, 'dummy text' FROM actor LIMIT 5;
SELECT actor_id, first_name, curdate() as 'Current_Date' FROM actor LIMIT 5;
SELECT actor_id, first_name, last_update FROM actor LIMIT 5;
SELECT * FROM actor;

-- table stmt
TABLE actor; -- similar to SELECT * FROM actor;

SELECT 
    actor_id  AS "Actor ID",
    CONCAT_WS(' ',LOWER(first_name), LOWER(last_name)) AS "Actor Full Name",
    last_update AS "Last updated"
FROM
    actor; -- use built-in functions

-- sorting 
--
SELECT actor_id, first_name, last_name, last_update FROM actor;
SELECT actor_id, first_name, last_name, last_update FROM actor ORDER BY first_name;
SELECT actor_id, first_name, last_name, last_update FROM actor ORDER BY last_name;
SELECT rental_id, rental_date FROM rental ORDER BY rental_date;
SELECT actor_id, first_name, last_name, last_update FROM actor ORDER BY first_name, last_name;

-- union
--
SELECT actor_id, first_name FROM actor LIMIT 5, 10;
SELECT actor_id, first_name FROM actor LIMIT 50, 10;

(SELECT actor_id, first_name FROM actor LIMIT 5, 10)
UNION 
(SELECT actor_id, first_name FROM actor LIMIT 50 , 10);

-- where clause
SELECT * FROM film_text;
SELECT * FROM film_text WHERE film_id < 10;
SELECT * FROM film_text WHERE film_id between 16 and 90;
SELECT * FROM film_text WHERE length(title) < 10;
SELECT * FROM film_text WHERE title LIKE "Ar%";
SELECT * FROM film_text WHERE title LIKE "Ar%" and film_id > 38;
SELECT count(*) FROM film_text WHERE locate("drama", description);
SELECT count(*) 
FROM film_text 
WHERE instr(description,'drama');  
-- instr() is equal to locate() 
-- except that locate give the exact position of the desired string
SELECT 
    *, locate("drama", description) 
FROM
    film_text 
WHERE 
    locate("drama", description) -- this returns a truly value (location) if drama exists;

-- prepare and execute
--
SELECT * FROM film_text WHERE title LIKE "Ar%" and film_id > 38;

PREPARE sql_stmt FROM 'SELECT * FROM film_text WHERE title LIKE "Ar%" and film_id > ?';
SET @id := 38;
EXECUTE sql_stmt USING @id;

PREPARE sql_stmt FROM 'SELECT * FROM film_text WHERE title LIKE ? and film_id > ?';
SET @text := "Ar%";
SET @id := 38;
EXECUTE sql_stmt USING @text, @id;

DROP PREPARE sql_stmt;
DEALLOCATE PREPARE sql_stmt;

-- group by
--
SELECT * FROM rental;
SELECT customer_id, rental_id FROM rental;
SELECT count(rental_id), count(distinct(rental_id)) FROM rental;  -- check if rental_id is unique
SELECT customer_id, count(rental_id) FROM rental GROUP BY customer_id;
SELECT customer_id, count(rental_id) FROM rental GROUP BY customer_id ORDER BY customer_id DESC;
SELECT customer_id, count(rental_id) FROM rental GROUP BY customer_id ORDER BY count(rental_id) DESC;


SELECT * FROM payment;
SELECT customer_id, sum(amount) FROM payment GROUP BY customer_id ORDER BY sum(amount) DESC;

-- having
--
SELECT 
    customer_id, sum(amount) 
FROM 
    payment 
GROUP BY 
    customer_id 
WHERE  
    sum(amount) > 150 
ORDER BY 
    sum(amount) 
DESC; 
-- error!
-- WHERE CLAUSE doesn't accept aggregations

SELECT 
    customer_id, sum(amount) 
FROM 
    payment 
GROUP BY 
    customer_id 
HAVING 
    sum(amount) > 150 
ORDER BY 
    sum(amount) ; 

-- joins
--
SELECT category_id, name FROM category;
SELECT film_id, category_id  FROM film_category;

SELECT film_category.film_id, category.category_id, category.name FROM category
INNER JOIN film_category
ON film_category.category_id  = category.category_id;

SELECT fc.film_id, c.category_id, c.name FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id;

SELECT fc.film_id, c.category_id, c.name FROM category AS c
INNER JOIN film_category AS fc
USING (category_id);

SELECT fc.film_id, c.category_id, c.name FROM category AS c
LEFT JOIN film_category AS fc
USING (category_id);

SELECT fc.film_id, c.category_id, c.name FROM category AS c
RIGHT JOIN film_category AS fc
USING (category_id);

-- join 3 tables
--
SELECT fc.film_id, f.title, c.category_id, c.name FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id;

SELECT fc.film_id, f.title AS "Film Name", c.name AS "Genre" FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id;

-- ---
-- complete join example
-- ---
create database testdb;
use testdb;
create table tbl1 (id int, name varchar(20));
create table tbl2 (id int, title varchar(20));

insert into tbl1 values (1, 'ahmed'), (2, 'aya'), (3, 'wegz'), (4, 'marwan');

insert into tbl2 values (2, 'engineer'), (3, 'writer'), (4, 'rapper'), (5, 'doctor');

SELECT * FROM testdb.tbl1;
SELECT * FROM testdb.tbl2;

select tbl1.*, tbl2.* from tbl1 inner join tbl2 using (id);
select tbl1.*, tbl2.* from tbl1 left join tbl2 using (id);
select tbl1.*, tbl2.* from tbl1 right join tbl2 using (id);
select tbl1.*, tbl2.* from tbl1 cross join tbl2;
-- --

-- views
--
CREATE VIEW vw_file_genre
AS
SELECT fc.film_id, f.title AS "Film Name", c.name AS "Genre" FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id;
