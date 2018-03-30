## 第一课 了解SQL
### 1.1 数据库基础
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


### 1.2 什么是SQL
SQL(发音为字母S-Q-L或sequel)是结构化查询语言(Structured Query Language)的缩写。SQL是一种专门用来与数据库沟通的语言。
SQL有如下的优点。
· SQL不是某个特定数据库供应商专有的语言。几乎所有重要的DBMS都支持SQL，所以学习此语言使你几乎能与所有数据库打交道。
· SQL简单易学。它的语句全都是由有很强描述性的英语单词组成，而且这些单词的数目不多。
· SQL虽然看上去很简单，但实际上是一种强有力的语言，灵活使用其语言元素，可以进行非常复杂和高级的数据库操作。



## 第2课 检索数据
### 2.1 SELECT语句

### 2.2 检索单个列
SQL语句不区分大小写，因此SELECT与select是相同的。同样，写成Select也没有关系。许多SQL开发人员喜欢对SQL关键字使用 大写，而对列名和表名使用小写，这样做使代码更易于阅读和调试。
SELECT prod_name FROM Products;

2.3 检索多个列
在选择多个列时，一定要在列名之间加上逗号，但最后一个列名后不加。如果在最后一个列名后加了逗号，将出现错误。
SELECT prod_id, prod_name, prod_price FROM Products;

### 2.4 检索所有列
使用通配符*
一般而言，除非你确实需要表中的每一列，否则最好别使用*通配符。虽然使用通配符能让你自己省事，不用明确列出所需列，但检索不需 要的列通常会降低检索和应用程序的性能。
使用通配符有一个大优点。由于不明确指定列名(因为星号检索每一列)，所以能检索出名字**未知的列**。
SELECT * FROM Products;                  可能重复

### 2.5 检索不同的值
SELECT DISTINCT vend_id FROM Products;   
使用 DISTINCT 关键字去重，它必须直接放在列名的前面，且不能部分使用DISTINCT。

### 2.6 限制结果
SELECT prod_name FROM Products LIMIT 5;     
只检索前5行数据。
SELECT prod_name FROM Products LIMIT 5 OFFSET 5;  返回从第5行起的5行数据。第一个数字是指从哪儿开始，第二个数字是检索的行数。

### 2.7 使用注释
行内注释:使用-- (两个连字符)嵌在行内。-- 之后的文本就是注释。
SELECT prod_name -- 这是一条注释
FROM Products;

行内注释：
    # 这是一条注释
    SELECT prod_name
    FROM Products;

多行注释：
注释从/\*开始，到\*/结束，/\*和\*/之间的任何内容都是注释