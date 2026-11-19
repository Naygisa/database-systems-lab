-- TPC-H 任务 5：按供应商所在国家汇总供应商、零件、库存和供应价格。
USE TPCH;

SELECT n.name AS nation_name,
       COUNT(DISTINCT s.suppkey) AS supplier_count,
       COUNT(DISTINCT ps.partkey) AS part_type_count,
       SUM(ps.availqty) AS total_availqty,
       AVG(ps.supplycost) AS avg_supplycost
FROM Nation AS n
JOIN Supplier AS s ON s.nationkey = n.nationkey
LEFT JOIN PartSupp AS ps ON ps.suppkey = s.suppkey
GROUP BY n.nationkey, n.name
-- 先计算每个国家的总库存，再保留总库存严格大于 500 的分组。
HAVING SUM(ps.availqty) > 500
ORDER BY total_availqty DESC, n.nationkey;
