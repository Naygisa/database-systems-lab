-- TPC-H 任务 7：使用任务 2 的初始库存执行一次。
USE TPCH;

CREATE TABLE StockAlert_Log (
    alert_id INT NOT NULL AUTO_INCREMENT,
    partkey INT NOT NULL,
    suppkey INT NOT NULL,
    alert_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (alert_id)
) ENGINE = InnoDB;

-- 仅当库存从至少 10 跌到低于 10 时，插入一条预警。
CREATE TRIGGER trg_partsupp_lowstock
AFTER UPDATE ON PartSupp
FOR EACH ROW
    INSERT INTO StockAlert_Log (partkey, suppkey)
    SELECT NEW.partkey, NEW.suppkey
    WHERE NEW.availqty < 10 AND OLD.availqty >= 10;

-- 测试一：从 50 降至 5，应新增一条预警。
UPDATE PartSupp
SET availqty = 5
WHERE partkey = 1 AND suppkey = 1 AND availqty = 50;

SELECT * FROM StockAlert_Log ORDER BY alert_id;

-- 测试二：从 15 降至 12，预警日志应仍只有第一条记录。
UPDATE PartSupp
SET availqty = 12
WHERE partkey = 1 AND suppkey = 2 AND availqty = 15;

SELECT * FROM StockAlert_Log ORDER BY alert_id;

-- 核对两条供应记录的实际库存。
SELECT partkey, suppkey, availqty
FROM PartSupp
WHERE partkey = 1 AND suppkey IN (1, 2)
ORDER BY suppkey;
