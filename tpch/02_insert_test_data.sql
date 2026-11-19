-- TPC-H 任务 2：创建八张空表后执行一次，插入测试数据。
USE TPCH;

START TRANSACTION;

INSERT INTO Region (regionkey, name)
VALUES (1, 'ASIA'), (2, 'EUROPE'), (3, 'AMERICA'),
       (4, 'AFRICA'), (5, 'MIDDLE EAST');

INSERT INTO Nation (nationkey, name, regionkey)
VALUES (1, 'CHINA', 1), (2, 'JAPAN', 1), (3, 'GERMANY', 2),
       (4, 'CANADA', 3), (5, 'EGYPT', 4);

INSERT INTO Supplier (suppkey, name, nationkey)
VALUES (1, '华为', 1), (2, 'SONY', 2), (3, '西门子', 3),
       (4, 'Maple Supply', 4), (5, '中兴', 1);

INSERT INTO Part (partkey, name, mfgr, brand, retailprice)
VALUES (1, '光模块', 'MFGR#1', 'BRAND#11', 120.00),
       (2, '交换板', 'MFGR#1', 'BRAND#12', 200.00),
       (3, '传感器', 'MFGR#2', 'BRAND#21',  80.00),
       (4, '电源模块', 'MFGR#2', 'BRAND#22', 100.00),
       (5, '控制器', 'MFGR#3', 'BRAND#31', 180.00);

INSERT INTO PartSupp (partkey, suppkey, availqty, supplycost)
VALUES (1, 1,  50, 75.00), (1, 2,  15,  82.00),
       (2, 1, 600, 95.00), (3, 3, 520,  42.00),
       (4, 4,   8, 60.00), (5, 5,  60, 110.00);

INSERT INTO Customer (custkey, name, nationkey, acctbal)
VALUES (1, '张三', 1, 12000.00), (2, '李四', 1, 8000.00),
       (3, '佐藤', 2,  6500.00), (4, 'Mia', 3, 9000.00),
       (5, 'Noah', 4,  7300.00);

INSERT INTO Orders (orderkey, custkey, orderstatus, totalprice, orderdate)
VALUES (1, 1, 'F', 240.00, '2026-10-01'),
       (2, 1, 'F', 200.00, '2026-10-02'),
       (3, 2, 'F', 240.00, '2026-10-03'),
       (4, 3, 'F', 200.00, '2026-10-04'),
       (5, 4, 'F', 180.00, '2026-10-05');

INSERT INTO Lineitem
    (orderkey, partkey, suppkey, linenumber, quantity, extendedprice, discount, tax)
VALUES (1, 1, 1, 1, 2.00, 240.00, 0.00, 0.00),
       (2, 2, 1, 1, 1.00, 200.00, 0.00, 0.00),
       (3, 3, 3, 1, 3.00, 240.00, 0.00, 0.00),
       (4, 4, 4, 1, 2.00, 200.00, 0.00, 0.00),
       (5, 5, 5, 1, 1.00, 180.00, 0.00, 0.00);

COMMIT;

SELECT 'Region' AS table_name, COUNT(*) AS row_count FROM Region
UNION ALL SELECT 'Nation', COUNT(*) FROM Nation
UNION ALL SELECT 'Supplier', COUNT(*) FROM Supplier
UNION ALL SELECT 'Part', COUNT(*) FROM Part
UNION ALL SELECT 'PartSupp', COUNT(*) FROM PartSupp
UNION ALL SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL SELECT 'Lineitem', COUNT(*) FROM Lineitem;

SELECT partkey, suppkey, availqty, supplycost
FROM PartSupp
ORDER BY partkey, suppkey;
