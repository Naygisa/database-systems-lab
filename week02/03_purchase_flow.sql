-- 第二周探索任务 3：按顺序记录顾客、订单和订单明细。
USE TPCH;

START TRANSACTION;

-- 顾客已有对应的国家，订单将引用这位新顾客。
INSERT INTO Customer (custkey, name, nationkey, acctbal)
VALUES (201, '周宁', 1, 3200.00);

INSERT INTO Orders (orderkey, custkey, orderstatus, totalprice, orderdate)
VALUES (201, 201, 'F', 160.00, '2026-11-19');

-- 明细引用新订单和已有的零件供应组合 (3, 3)。
INSERT INTO Lineitem
    (orderkey, partkey, suppkey, linenumber, quantity, extendedprice, discount, tax)
VALUES (201, 3, 3, 1, 2.00, 160.00, 0.00, 0.00);

COMMIT;

-- 连接三张表，核对同一次购买的顾客、订单和明细。
SELECT c.custkey,
       c.name AS customer_name,
       o.orderkey,
       o.totalprice,
       l.linenumber,
       l.partkey,
       l.suppkey,
       l.quantity,
       l.extendedprice
FROM Customer AS c
JOIN Orders AS o ON o.custkey = c.custkey
JOIN Lineitem AS l ON l.orderkey = o.orderkey
WHERE o.orderkey = 201;
