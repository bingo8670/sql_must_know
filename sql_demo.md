1 样例表解释说明
书中所用的表是一个玩具经销商使用的订单录入系统的组成部分，包括：

管理供应商Vendors。
管理产品目录Products。
管理顾客列表Customers。
录入顾客订单Orders、OrderItems。

1.1 供应商Vendors表
Vendors表存储销售产品的供应商信息，每个供应商在表中都有一个记录，供应商ID列（vend_id）作为主键，用于进行产品与供应商的匹配。
vend_id	唯一的供应商ID
vend_name	供应商的名字
vend_address	供应商的地址
vend_city	供应商所在的城市
vend_state	供应商所在州
vend_zip	供应商地址的邮政编码
vend_country	供应商所在国家


1.2 产品目录Products表
Products表每行代表一个产品，每个产品有唯一的ID（prod_id），并作为表的主键。借助vend_id（供应商唯一ID）这一外键，与供应商Vendors表的vend_id相关联。
prod_id	唯一的产品ID
vend_id	产品供应商ID（关联到Vendors表的vend_id）
prod_name	产品名
prod_price	产品价格
prod_desc	产品描述


1.3 顾客信息Customers表
Customers表存储所有顾客信息，每个顾客有唯一的ID（cust_id），并作为表的主键。
cust_id	唯一的顾客ID
cust_name	顾客名
cust_address	顾客的地址
cust_city	顾客所在城市
cust_state	顾客所在州
cust_zip	顾客地址邮政编码
cust_country	顾客所在国家
cust_contact	顾客的联系名
cust_email	顾客的电子邮件地址


1.4 订单Orders表
Orders表存储顾客订单（不是订单细节），每个订单有唯一编号（order_num），并作为表的主键。借助cust_id（顾客唯一ID）这一外键，与顾客信息Customers表的cust_id相关联。
order_num	唯一的订单号
order_state	订单日期
cust_id	订单顾客ID（关联到Customers表的cust_id)


1.5 订单明细OrderItems表
OrderItems表存储每个订单中的实际产品，每个订单的每个产品一行。对于Orders表的每一行，在OrderItems表中有一行或者多行，也就是一个顾客可以买多件产品。每个订单产品由订单号和订单产品唯一标识，也就是联合主键。订单产品order_num列作为外键，与Orders表的order_num相关联，此外，产品唯一ID（prod_id）与Products表的prod_id相关联。
order_num	订单号（关联到Orders表的order_num）
order_item	订单产品号（订单内的顺序）
prod_id	产品ID（关联到Products表的prod_id）
quantity	物品数量
item_price	物品价格



2 创建相关表
2.1 创建供应商Vendors表
CREATE TABLE Vendors
(
  vend_id       char(10)   NOT NULL ,
  vend_name     char(50)   NOT NULL ,
  vend_address  char(50)   NULL ,
  vend_city     char(50)   NULL ,
  vend_state    char(5)    NULL ,
  vend_zip      char(10)   NULL ,
  vend_country  char(50)   NULL
);


2.2 创建产品目录Products表
CREATE TABLE Products
(
  prod_id      char(10)       NOT NULL ,
  vend_id      char(10)       NOT NULL ,
  prod_name    char(255)      NOT NULL ,
  prod_price   decimal(8,2)   NOT NULL ,
  prod_desc    text           NULL
);


2.3 创建顾客信息Products表
CREATE TABLE Customers
(
  cust_id        char(10)    NOT NULL ,
  cust_name      char(50)    NOT NULL ,
  cust_address   char(50)    NULL ,
  cust_city      char(50)    NULL ,
  cust_state     char(5)     NULL ,
  cust_zip       char(10)    NULL ,
  cust_country   char(50)    NULL ,
  cust_contact   char(50)    NULL ,
  cust_email     char(255)   NULL
);


2.4 创建订单Orders表
CREATE TABLE Orders
(
  order_num   int        NOT NULL ,
  order_date  datetime   NOT NULL ,
  cust_id     char(10)   NOT NULL
);


2.5 创建订单明细OrderItems表
CREATE TABLE OrderItems
(
  order_num   int           NOT NULL ,
  order_item  int           NOT NULL ,
  prod_id     char(10)      NOT NULL ,
  quantity    int           NOT NULL ,
  item_price  decimal(8,2)  NOT NULL
);




3 添加主外键约束
3.1 添加主键约束
ALTER TABLE Vendors ADD PRIMARY KEY (vend_id);
ALTER TABLE Products ADD PRIMARY KEY (prod_id);
ALTER TABLE Customers ADD PRIMARY KEY (cust_id);
ALTER TABLE Orders ADD PRIMARY KEY (order_num);
ALTER TABLE OrderItems ADD PRIMARY KEY (order_num, order_item);


3.2 添加外键约束
ALTER TABLE Products ADD CONSTRAINT FK_Products_Vendors FOREIGN KEY (vend_id) REFERENCES Vendors (vend_id);

ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);

ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_num) REFERENCES Orders (order_num);

ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Products FOREIGN KEY (prod_id) REFERENCES Products (prod_id);




4 插入表数据
4.1 向供应商Vendors表中插入数据
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRS01','Bears R Us','123 Main Street','Bear Town','MI','44444', 'USA');

INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRE02','Bear Emporium','500 Park Street','Anytown','OH','44333', 'USA');

INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('DLL01','Doll House Inc.','555 High Street','Dollsville','CA','99999', 'USA');

INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FRB01','Furball Inc.','1000 5th Avenue','New York','NY','11111', 'USA');

INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FNG01','Fun and Games','42 Galaxy Road','London', NULL,'N16 6PS', 'England');

INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('JTS01','Jouets et ours','1 Rue Amusement','Paris', NULL,'45678', 'France');


4.2 向产品目录Products表中插入数据
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR01', 'BRS01', '8 inch teddy bear', 5.99, '8 inch teddy bear, comes with cap and jacket');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR02', 'BRS01', '12 inch teddy bear', 8.99, '12 inch teddy bear, comes with cap and jacket');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR03', 'BRS01', '18 inch teddy bear', 11.99, '18 inch teddy bear, comes with cap and jacket');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG01', 'DLL01', 'Fish bean bag toy', 3.49, 'Fish bean bag toy, complete with bean bag worms with which to feed it');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG02', 'DLL01', 'Bird bean bag toy', 3.49, 'Bird bean bag toy, eggs are not included');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG03', 'DLL01', 'Rabbit bean bag toy', 3.49, 'Rabbit bean bag toy, comes with bean bag carrots');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RGAN01', 'DLL01', 'Raggedy Ann', 4.99, '18 inch Raggedy Ann doll');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RYL01', 'FNG01', 'King doll', 9.49, '12 inch king doll with royal garments and crown');

INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RYL02', 'FNG01', 'Queen doll', 9.49, '12 inch queen doll with royal garments and crown');


4.3 向顾客信息Customers表中插入数据
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000001', 'Village Toys', '200 Maple Lane', 'Detroit', 'MI', '44444', 'USA', 'John Smith', 'sales@villagetoys.com');

INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000002', 'Kids Place', '333 South Lake Drive', 'Columbus', 'OH', '43333', 'USA', 'Michelle Green');

INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000003', 'Fun4All', '1 Sunny Place', 'Muncie', 'IN', '42222', 'USA', 'Jim Jones', 'jjones@fun4all.com');

INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000004', 'Fun4All', '829 Riverside Drive', 'Phoenix', 'AZ', '88888', 'USA', 'Denise L. Stephens', 'dstephens@fun4all.com');

INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000005', 'The Toy Store', '4545 53rd Street', 'Chicago', 'IL', '54545', 'USA', 'Kim Howard');


4.4 向订单Orders表中插入数据
INSERT INTO Orders(order_num, order_date, cust_id) VALUES(20005, '2012-05-01', '1000000001');

INSERT INTO Orders(order_num, order_date, cust_id) VALUES(20006, '2012-01-12', '1000000003');

INSERT INTO Orders(order_num, order_date, cust_id) VALUES(20007, '2012-01-30', '1000000004');

INSERT INTO Orders(order_num, order_date, cust_id) VALUES(20008, '2012-02-03', '1000000005');

INSERT INTO Orders(order_num, order_date, cust_id) VALUES(20009, '2012-02-08', '1000000001');


4.5 向订单明细OrderItems表中插入数据
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20005, 1, 'BR01', 100, 5.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20005, 2, 'BR03', 100, 10.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20006, 1, 'BR01', 20, 5.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20006, 2, 'BR02', 10, 8.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20006, 3, 'BR03', 10, 11.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20007, 1, 'BR03', 50, 11.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20007, 2, 'BNBG01', 100, 2.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20007, 3, 'BNBG02', 100, 2.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20007, 4, 'BNBG03', 100, 2.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20007, 5, 'RGAN01', 50, 4.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20008, 1, 'RGAN01', 5, 4.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20008, 2, 'BR03', 5, 11.99);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20008, 3, 'BNBG01', 10, 3.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20008, 4, 'BNBG02', 10, 3.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20008, 5, 'BNBG03', 10, 3.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20009, 1, 'BNBG01', 250, 2.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20009, 2, 'BNBG02', 250, 2.49);

INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price) VALUES(20009, 3, 'BNBG03', 250, 2.49);
