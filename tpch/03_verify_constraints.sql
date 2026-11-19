-- TPC-H 任务 3：在同一个查询窗口选中各段，按顺序运行。
-- 选中下方三条语句，开启事务并准备父子记录。
START TRANSACTION;
INSERT INTO Region (regionkey, name) VALUES (901, '临时测试地区');
INSERT INTO Nation (nationkey, name, regionkey) VALUES (901, '临时测试国家', 901);

-- ① 主键冲突：任务 2 已插入 regionkey = 1。
INSERT INTO Region (regionkey, name) VALUES (1, '重复编号地区');

-- ② 外键插入冲突：地区 999 不存在。
INSERT INTO Nation (nationkey, name, regionkey) VALUES (902, '无效地区国家', 999);

-- ③ 外键删除冲突：地区 901 仍被国家 901 引用。
DELETE FROM Region WHERE regionkey = 901;

-- ④ 价格检查约束冲突：零售价必须大于 0。
INSERT INTO Part (partkey, name, retailprice) VALUES (901, '零售价测试零件', 0.00);

-- ⑤ 库存检查约束冲突：库存 -1 违反 availqty >= 0。
INSERT INTO PartSupp (partkey, suppkey, availqty, supplycost) VALUES (2, 2, -1, 90.00);

-- 测试结束后单独执行，撤销临时数据。
ROLLBACK;
