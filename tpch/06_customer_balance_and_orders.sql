-- TPC-H 任务 6：查询余额高于本国顾客平均余额的人。
USE TPCH;

SELECT c.name AS customer_name,
       n.name AS nation_name,
       c.acctbal AS account_balance
FROM Customer AS c
JOIN Nation AS n ON n.nationkey = c.nationkey
WHERE c.acctbal > (
    SELECT AVG(peer.acctbal)
    FROM Customer AS peer
    WHERE peer.nationkey = c.nationkey
)
ORDER BY c.custkey;

-- 加分项：查询没有任何订单的顾客。
SELECT c.*
FROM Customer AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE o.custkey = c.custkey
)
ORDER BY c.custkey;
