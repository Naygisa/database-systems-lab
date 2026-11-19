-- 第四周探索任务 3：用 FROM 子查询统计下单超过一次的顾客。
USE TPCH;

SELECT c.name AS customer_name,
       stats.order_count
FROM (
    SELECT o.custkey,
           COUNT(*) AS order_count
    FROM Orders AS o
    GROUP BY o.custkey
    HAVING COUNT(*) > 1
) AS stats
JOIN Customer AS c ON c.custkey = stats.custkey
ORDER BY stats.order_count DESC, c.custkey;
