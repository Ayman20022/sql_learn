-- update table t2
UPDATE t2 SET first_name = 'amr' WHERE id = 4;
SELECT * from t2;

-- update table t1 using LIMIT
UPDATE t2 SET first_name = 'amr' WHERE id = 4 LIMIT 1;

-- update table t1 using ORDER BY
UPDATE t2 SET first_name = 'amr' WHERE id = 4 ORDER BY id DESC LIMIT 3;


drop table if exists test_update;
create table test_update (id int, name VARCHAR(20));

insert into test_update(id,name) VALUES (1,'ayman'),(2,'bader'),(3,'jad'),(4,'zaid');


update test_update set name = 'zelda' where id = 4;

select * from test_update;

update test_update set name = 'erezviel' where id > 1 ORDER BY name limit 2;
