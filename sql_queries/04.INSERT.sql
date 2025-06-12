-- create database
CREATE DATABASE IF NOT EXISTS testdb;

DROP TABLE IF EXISTS t1,t2;
-- create table
USE testdb;
CREATE TABLE IF NOT EXISTS t1 (id INT, first_name VARCHAR(20));

SHOW COLUMNS FROM t1;
-- or
DESC t1;

-- insert values into table t1
INSERT INTO t1 VALUES (1, 'ahmed');
SELECT * from t1;

-- insert mutliple values into table t1
INSERT INTO t1 VALUES (2, 'aya'), (3, 'john');
SELECT * from t1;

-- create a table t2 based on t1
CREATE TABLE IF NOT EXISTS t2 LIKE t1;
-- INSERT INTO t2(id,first_name) select id,first_name from t1;

-- insert values into table t2 from t1
INSERT INTO t2 SELECT * FROM t1;
-- INSERT INTO t2 SELECT id, first_name FROM t1;

-- insert values into table t2 from t1 with column names
INSERT INTO t2 (id, first_name) VALUES ('10', 'Tamer');
INSERT INTO t2 (first_name, id) VALUES ('Hany', '11');
-- INSERT INTO t2 (id, first_name) SELECT id, first_name FROM t1;

SELECT id,first_name from t2;

-- insert into table t2 using SET
INSERT INTO t2 SET id = 4, first_name = 'wegz';

-- insert into table t2 using ROW()
INSERT INTO t2 VALUES ROW(5, 'pablo');
SELECT 
    *
FROM 
    t2;
-- insert into table t1 using ON DUPLICATE KEY UPDATE
INSERT INTO t1 VALUES (1, 'ahmed') ON DUPLICATE KEY UPDATE first_name = 'ali';
SELECT * from t1;


create table t3 (id int not null PRIMARY key, name VARCHAR(20) not null);

insert into t3 VALUES (1,'ayman');
SELECT * FROM t3;

INSERT INTO t3 VALUES (1,'ayman') ON DUPLICATE KEY UPDATE name = 'amr';

SELECT * FROM t3;

