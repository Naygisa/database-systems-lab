-- 第八周探索任务 1：比较单列主键的两种写法和复合主键。
USE TPCH;

-- 写法一：将单列主键写在列定义里。
CREATE TEMPORARY TABLE Week08_Supplier_Column (
    suppkey INT PRIMARY KEY
);

-- 写法二：把同一个单列主键写成表级约束。
CREATE TEMPORARY TABLE Week08_Supplier_Table (
    suppkey INT,
    PRIMARY KEY (suppkey)
);

SHOW CREATE TABLE Week08_Supplier_Column;
SHOW CREATE TABLE Week08_Supplier_Table;

-- 复合主键约束的是整对编号，允许任意一个列值单独重复。
CREATE TEMPORARY TABLE Week08_PartSupp (
    partkey INT,
    suppkey INT,
    PRIMARY KEY (partkey, suppkey)
);

INSERT INTO Week08_PartSupp (partkey, suppkey)
VALUES (1, 1), (1, 2), (2, 1);

SHOW CREATE TABLE Week08_PartSupp;

SELECT partkey, suppkey
FROM Week08_PartSupp
ORDER BY partkey, suppkey;

DROP TEMPORARY TABLE Week08_Supplier_Column, Week08_Supplier_Table, Week08_PartSupp;
