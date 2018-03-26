# DDL(Data Definition Language)
## 建立、删除和更名数据库
 - 在 SQLite3 的话，直接在 Terminal 用 CLI 指令 sqlite3 your_db_name.db 就会打开(或产生)一个数据库档案。直接砍掉档案就是删除数据库。
 - MySQL 的话，指令是 mysql -u root -p。
 - PostgreSQL 的指令是 psql <database_name>。

## 建立 Table
以下 SQL 会建立 events 表，并新增三个字段 name, capacity 和 date。默认是字段允许 NULL，除非加上 NOT NULL。

CREATE TABLE events (name VARCHAR(50) NOT NULL, capacity INTEGER, date DATE);

## 修改 Table
- 改名 Table，例如 ALTER TABLE persons RENAME TO people;
- 新增字串，例如 ALTER TABLE people ADD COLUMN status VARCHAR(50);
- 修改和移除字段：SQLite3 没支援，需要开一个新 table 然后把资料复制过去

# 删除 Table
语法是 DROP TABLE IF EXISTS people;

通常不会让终端使用者可以动态新建 table 和修改 schema。数据库的 Schema 比较像是你程式的一部分，我们的代码会依赖于 Schema 设计。另外也有效能的考量，变更 Schema 是很耗时的操作，特别是数据量已经很多的情况下，修改 Schema 会锁住整个 Table 影响网站运作。

## Migration 机制
数据库 Schema 不是一成不变的，会随着软件变更升级也会有修改的需要。因此，在一些软件中会实作一种叫做 Migration 的功能，透过 Schema Migration 纪录目前的 schema 版本。开机的时候检查目前程式的版本和数据库里面的版本是否相同，不同的话，执行 Migration 更新 schema。这些 Migration 代码也会放进版本控制系统 Git 里面，这样整个团队的开发者和不同服务器上，都可以利用 Migration 来一致管理 Schema。




# DML(Data Manipulation Language,做 CRUD 的操作)
## 新增资料
- INSERT INTO events (capacity, name) VALUES (200, "JSConf");
这个对应的 Rails 语法是 Event.create( :capacity => 200, :name => "JSConf")
- 插入多笔 INSERT INTO events (capacity, name) VALUES (300, "COSCUP"), (300, "OSDC.TW");

## 查询资料
- 捞全部 events 资料 SELECT * FROM events;
对应的 Rails 语法是 Event.all

- 只捞出指定的字段 SELECT name, capacity FROM events;
对应的 Rails 语法是 Event.select(:name, :capacity).all

- 字段前段可以补上表的名称 SELECT events.name, events.capacity FROM events;

- 递增排序 SELECT name, capacity FROM events ORDER BY id; 或 SELECT name, capacity FROM events ORDER BY id ASC;

- 递减排序 SELECT name, capacity FROM events ORDER BY id DESC;

- 分页 SELECT name, capacity FROM events ORDER BY capacity DESC, name ASC LIMIT 20 OFFSET 20;

##修改资料
- UPDATE events SET capacity=10; 这会修改 events table 的所有数据把 capacity 改成 10
对应的 Rails 语法是 Event.update_all( :capacity => 10 )

- UPDATE events SET capacity=100 WHERE name="RubyConf"; 用 WHERE 可以指定只有修改 name 是 "RubyConf" 的数据
对应的 Rails 语法是 Event.where( :name => "RubyConf" ).update_all( :capacity => 100)

- UPDATE events SET capacity=100, name="RubyConf 2015" WHERE name="RubyConf"; 修改 capacity 和 name
对应的 Rails 语法是 Event.where( :name => "RubyConf" ).update_all( :capacity => 100, :name => "RubyConf 2015" )

## 删除数据数据
- DELETE FROM events; 会全部删除
对应的 Rails 语法是 Event.delete_all

- DELETE FROM events WHERE name="RubyConf"; 只删除
对应的 Rails 语法是 Event.where( :name => "RubyConf" ).delete_all

##查有哪些 tables 和 columns
- SQLite3: .tables 和.schema tablename`
- MySQL: show tables 和 describe tablename
- PostgreSQL: \dt 和 \d tablename
这些查询在 Rails 启动的时后，其实也会帮我们做。你可以在 rails console 中对 model 执行 columns 方法，例如 Event.columns 就会反射出这个表有哪些字段。

## 条件查询
- SELECT * FROM events WHERE date = '2015-03-15';
- 条件或 SELECT * FROM events WHERE date = '2015-03-15' OR date = '2015-03-16';
- 某个区间 SELECT * FROM events WHERE date BETWEEN '2015-03-15' AND '2015-03-30';
- 条件且 SELECT * FROM events WHERE date = '2015-03-15' AND capacity >= 100;
- 模糊比对 SELECT * FROM events WHERE name LIKE '%Ruby%';
- 不可为空 SELECT * FROM events WHERE description IS NOT NULL;
- 条件比对时，小心大小写(Case insensitive)不同数据库默认不同。MySQL 是不分大小写(case insensitive)、PostgreSQL 会区分大小写(case sensitive)。

## Indexes 索引
- WHERE、ORDER 条件字段最好都要加上数据库索引(Index)，例如范例中的 date 字串，如果没有索引的话，会是 O(n) 的效率(这里又叫作 Full Table Scan，需要扫过整个表的意思)，数据库越多数据会越慢。如果有索引的话，会是 O(logn)，在数据量大的情况差非常多。
- 模糊搜寻 LIKE 查询都会变成 Full Table Scan，没办法用数据库索引，ransack gem 搜寻是用 LIKE 语法，在几万笔数据内效能还能接受，再大的数据量就需要用另外的 Full-Text Searching 引擎了，例如 ElasticSearch。

- 加索引的 SQL 语法：
加索引 CREATE INDEX events_user_id_idx ON events(user_id);
索引并且值是唯一 CREATE UNIQUE INDEX xxx_idx ON xxx(yyy);
在 Rails Migration 中要加上索引的话，可用 add_index 语法，例如 add_index :events, :date。

将字段设成 unique 跟设成 unique index 是一样的

当然也不是所有字段通通都加上索引就好了，因为加索引会让写入数据变慢(因为要建立索引，也会增加储存空间)，但是查询时会加快。


# 数据库规范化 Normalization
- 数据库规范化(Normalization)是数据库设计的一个非常重要的基本概念，目的是要去除重复的数据，增加数据的一致性。实际的作法是会将重复的字段，抽出来变成另一个新的表。
- 规范化还分成一阶规范化、二阶规范化、三阶规范化、DK/NF规范化等等不同级别，一般来说我们的应用软件会做到二阶或三阶规范化。

## Primary Key 主键
Primary Key 主键就是可以唯一识别的字段，在 Rails 中会默认产生一个字段是 id。

**主键特性：**
- 不能 NULL 也不能重复
- 最常见是 Simple ID Column Key (单一 column) 的设计。但也可以是 Compound/Composite Key (多个 columns 组成一个 primary key)，但 Rails 不支援。

如何选择你的 Primary Key ?
- 最常见是自动递增的整数(Auto incrementing Primary Key)，这是 Rails 的默认方式，也是大家熟悉的 ID
- UUID 通用唯一识别码: 1. 分布式系统喜欢用 2. 或是当作 token URL 功能
- Natural key (例如身份证号码, ISBN, 国码 ISO ALPHA-2) 等等，不过你需要真的确认不会重复，例如 ISBN 其实会重复的
