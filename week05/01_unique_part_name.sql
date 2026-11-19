-- 第五周索引实验探索任务 1：验证零件名称的唯一索引。
-- 先选中并执行 USE、CREATE UNIQUE INDEX 和 SHOW INDEX。
USE TPCH;

CREATE UNIQUE INDEX idx_part_name_unique ON Part (name);

SHOW INDEX FROM Part WHERE Key_name = 'idx_part_name_unique';

-- 单独执行下方 INSERT：新主键和正数价格均合法，同名零件会违反唯一索引。
INSERT INTO Part (partkey, name, retailprice)
VALUES (501, '光模块', 135.00);
