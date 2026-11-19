-- 查看订单对应的顾客、国家和地区
SELECT o.orderkey AS order_id,
       c.name AS customer_name,
       n.name AS nation_name,
       r.name AS region_name
FROM Orders AS o
JOIN Customer AS c ON c.custkey = o.custkey
JOIN Nation AS n ON n.nationkey = c.nationkey
JOIN Region AS r ON r.regionkey = n.regionkey
ORDER BY o.orderkey;
