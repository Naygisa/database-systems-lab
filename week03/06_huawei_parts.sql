-- 第三周探索任务 6：查询华为供应的零件名称和品牌。
USE TPCH;

-- 通过供应关系表连接供应商和零件，按供应商名称筛选。
SELECT p.name AS part_name,
       p.brand
FROM Supplier AS s
JOIN PartSupp AS ps ON ps.suppkey = s.suppkey
JOIN Part AS p ON p.partkey = ps.partkey
WHERE s.name = '华为'
ORDER BY p.partkey;
