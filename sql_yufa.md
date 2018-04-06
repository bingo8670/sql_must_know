## SQL语句的语法
### ALTER TABLE
ALTER TABLE用来更新已存在表的结构。为了创建新表，应该使用CREATE TABLE。
ALTER TABLE tablename
(
  ADD|DROP column datatype [NULL|NOT NULL] [CONSTRAINTS],
  ADD|DROP column datatype [NULL|NOT NULL] [CONSTRAINTS],
  ...
);


### COMMIT
COMMIT用来将事务写入数据库。
COMMIT [TRANSACTION];


### CREATE INDEX
CREATE INDEX用于在一个或多个列上创建索引。
CREATE INDEX indexname
ON tablename (column, ...);


### CREATE PROCEDURE
CREATE PROCEDURE用于创建存储过程。
CREATE PROCEDURE procedurename [parameters] [options] AS
SQL statement;


### CREATE TABLE
CREATE TABLE用于创建新数据库表。更新已经存在的表的结构，使用ALTER TABLE。
CREATE TABLE tablename
(
  column datatype [NULL|NOT NULL] [CONSTRAINTS],
  column datatype [NULL|NOT NULL] [CONSTRAINTS],
  ...
);


###  CREATE VIEW
CREATE VIEW用来创建一个或多个表上的新视图。
CREATE VIEW viewname AS
SELECT columns, ...
FROM tables, ...
[WHERE ...]
[GROUP BY ...]
[HAVING ...];


### DELETE
DELETE从表中删除一行或多行。
DELETE FROM tablename
[WHERE ...];


### DROP
DROP永久地删除数据库对象(表、视图、索引等)。
DROP INDEX|PROCEDURE|TABLE|VIEW
indexname|procedurename|tablename|viewname;


### INSERT
INSERT为表添加一行。详
INSERT INTO tablename [(columns, ...)]
VALUES(values, ...);

### INSERT SELECT
INSERT SELECT将SELECT的结果插入到一个表。
INSERT INTO tablename [(columns, ...)]
SELECT columns, ... FROM tablename, ...
[WHERE ...];


### ROLLBACK
ROLLBACK用于撤销一个事务块。
ROLLBACK [ TO savepointname];
或者:
ROLLBACK TRANSACTION;


### SELECT
SELECT用于从一个或多个表(视图)中检索数据。
SELECT columnname, ...
FROM tablename, ... [WHERE ...]
[UNION ...]
[GROUP BY ...]
[HAVING ...]
[ORDER BY ...];


### UPDATE
UPDATE更新表中的一行或多行。详
UPDATE tablename
SET columname = value, ... [WHERE ...];



