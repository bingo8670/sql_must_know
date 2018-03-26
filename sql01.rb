第一课 了解SQL
1.1 数据库基础
1.1.1 数据库（database：保存有组织的数据的容器）
数据库管理系统（DBMS）
数据库是通过DBMS创建和操纵的容器；

1.1.2 表（table：某种特定类型数据的结构化清单）

1.1.3 列和数据类型
列 (column)：表中的一个字段。所有表都是由一个或多个列组成的。
数据类型：所允许的数据的类型。每个表列都有相应的数据类型，它限制(或允许)该列中存储的数据。

1.1.4 行（row) ：表中的一个记录。

1.1.5 主键(primary key) ：一列(或一组列)，其值能够唯一标识表中每一行。
表中的任何列都可以作为主键，只要它满足以下条件:
· 任意两行都不具有相同的主键值;
· 每一行都必须具有一个主键值(主键列不允许NULL值);
· 主键列中的值不允许修改或更新;
· 主键值不能重用(如果某行从表中删除，它的主键不能赋给以后的新行)。


1.2 什么是SQL
SQL(发音为字母S-Q-L或sequel)是结构化查询语言(Structured Query Language)的缩写。SQL是一种专门用来与数据库沟通的语言。
SQL有如下的优点。
· SQL不是某个特定数据库供应商专有的语言。几乎所有重要的DBMS都支持SQL，所以学习此语言使你几乎能与所有数据库打交道。
· SQL简单易学。它的语句全都是由有很强描述性的英语单词组成，而且这些单词的数目不多。
· SQL虽然看上去很简单，但实际上是一种强有力的语言，灵活使用其语言元素，可以进行非常复杂和高级的数据库操作。



第2课 检索数据
2.1 SELECT语句
