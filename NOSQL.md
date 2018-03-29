# Key-value
**Redis** 可说是一种小型数据结构瑞士刀，作为搭配用的数据库来使用。
它的用途包括：
- 各式计数器：流量+1
- 简易标记( 例如同一 IP 十分钟内只算一次 pageview)
- 排行榜 zadd
- 自制 Inverted-Index Text Search
- Pub/Sub 聊天室
- Job Queue (例如 sidekiq)
- 主要是局部的、需要密集性写入的功能，改用 Redis 来操作，来降低主数据库的负担。


# Document-Oriented
**MongoDB** 是一种泛用型的数据库，和 MySQL/PostgreSQL 打对台，特色是 Scheme-free 不需要定义 Schema。曾经有一阵子 Rails 社区非常流行，因为不需要用 Migration 去定义 Schema 就可以使用 Model，一开始用起来非常方便。不过后来大家发现营运久了以后，没有 Schema 的数据会变脏，造成后续维运的成本增加。所以后来就没这么流行了。


# Column-Oriented
- Apache HBase 分布式、强调超大 Table： billions of rows X millions of columns (PB以上等级) (Google Big Table 的开源版本，由 Yahoo 推出)
- Apache Cassandra 分布式、最终一致性，高写入场景 (Amazon Dynamo 的开源版本，由 Facebook 推出)
- Amazon DynamoDB
- Google Cloud Datastore


# Graph: neo4j 图形数据库
neo4j 用节点和边来储存数据
