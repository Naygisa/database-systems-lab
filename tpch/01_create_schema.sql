-- TPC-H 任务 1：在尚未创建或没有表的 TPCH 数据库中执行。
CREATE DATABASE IF NOT EXISTS TPCH CHARACTER SET utf8mb4;
USE TPCH;

-- 按外键依赖顺序建表，先创建被引用的表。
CREATE TABLE Region (
    regionkey INT NOT NULL,
    name CHAR(25),
    comment VARCHAR(152),
    CONSTRAINT PK_Region PRIMARY KEY (regionkey)
) ENGINE = InnoDB;

CREATE TABLE Nation (
    nationkey INT NOT NULL,
    name CHAR(25),
    regionkey INT,
    comment VARCHAR(152),
    CONSTRAINT PK_Nation PRIMARY KEY (nationkey),
    CONSTRAINT FK_Nation_Region FOREIGN KEY (regionkey) REFERENCES Region (regionkey)
) ENGINE = InnoDB;

CREATE TABLE Supplier (
    suppkey INT NOT NULL,
    name CHAR(25),
    address VARCHAR(40),
    nationkey INT,
    phone CHAR(15),
    acctbal DECIMAL(10, 2),
    comment VARCHAR(101),
    CONSTRAINT PK_Supplier PRIMARY KEY (suppkey),
    CONSTRAINT FK_Supplier_Nation FOREIGN KEY (nationkey) REFERENCES Nation (nationkey)
) ENGINE = InnoDB;

CREATE TABLE Part (
    partkey INT NOT NULL,
    name VARCHAR(55),
    mfgr CHAR(25),
    brand CHAR(10),
    type VARCHAR(25),
    size INT,
    container CHAR(10),
    retailprice DECIMAL(10, 2) NOT NULL,
    comment VARCHAR(23),
    CONSTRAINT PK_Part PRIMARY KEY (partkey),
    CONSTRAINT CK_Part_Price CHECK (retailprice > 0)
) ENGINE = InnoDB;

CREATE TABLE PartSupp (
    partkey INT NOT NULL,
    suppkey INT NOT NULL,
    availqty INT NOT NULL,
    supplycost DECIMAL(10, 2),
    comment VARCHAR(199),
    CONSTRAINT PK_PartSupp PRIMARY KEY (partkey, suppkey),
    CONSTRAINT FK_PartSupp_Part FOREIGN KEY (partkey) REFERENCES Part (partkey),
    CONSTRAINT FK_PartSupp_Supplier FOREIGN KEY (suppkey) REFERENCES Supplier (suppkey),
    CONSTRAINT CK_PartSupp_AvailQty CHECK (availqty >= 0)
) ENGINE = InnoDB;

CREATE TABLE Customer (
    custkey INT NOT NULL,
    name VARCHAR(25),
    address VARCHAR(40),
    nationkey INT,
    phone CHAR(15),
    acctbal DECIMAL(10, 2),
    mktsegment CHAR(10),
    comment VARCHAR(117),
    CONSTRAINT PK_Customer PRIMARY KEY (custkey),
    CONSTRAINT FK_Customer_Nation FOREIGN KEY (nationkey) REFERENCES Nation (nationkey)
) ENGINE = InnoDB;

CREATE TABLE Orders (
    orderkey INT NOT NULL,
    custkey INT,
    orderstatus CHAR(1),
    totalprice DECIMAL(10, 2),
    orderdate DATE,
    orderpriority CHAR(15),
    clerk CHAR(15),
    shippriority INT,
    comment VARCHAR(79),
    CONSTRAINT PK_Orders PRIMARY KEY (orderkey),
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (custkey) REFERENCES Customer (custkey)
) ENGINE = InnoDB;

CREATE TABLE Lineitem (
    orderkey INT NOT NULL,
    partkey INT NOT NULL,
    suppkey INT NOT NULL,
    linenumber INT NOT NULL,
    quantity DECIMAL(10, 2),
    extendedprice DECIMAL(10, 2),
    discount DECIMAL(10, 2),
    tax DECIMAL(10, 2),
    returnflag CHAR(1),
    linestatus CHAR(1),
    shipdate DATE,
    commitdate DATE,
    receiptdate DATE,
    shipinstruct CHAR(25),
    shipmode CHAR(10),
    comment VARCHAR(44),
    CONSTRAINT PK_Lineitem PRIMARY KEY (orderkey, linenumber),
    CONSTRAINT FK_Lineitem_Orders FOREIGN KEY (orderkey) REFERENCES Orders (orderkey),
    CONSTRAINT FK_Lineitem_PartSupp FOREIGN KEY (partkey, suppkey)
        REFERENCES PartSupp (partkey, suppkey)
) ENGINE = InnoDB;

-- 核对数据库字符集、八张基本表及两个检查约束的启用状态。
SELECT VERSION() AS mysql_version, SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME
FROM information_schema.SCHEMATA
WHERE SCHEMA_NAME = DATABASE();

SHOW FULL TABLES WHERE Table_type = 'BASE TABLE';

SELECT TABLE_NAME, CONSTRAINT_NAME, ENFORCED
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = DATABASE() AND CONSTRAINT_TYPE = 'CHECK'
ORDER BY TABLE_NAME, CONSTRAINT_NAME;
