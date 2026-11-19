-- TPC-H 任务 4：在演示表上验证 Nation 外键的级联删除定义。
USE TPCH;

CREATE TABLE Nation_Cascade_Demo (
    nationkey INT NOT NULL,
    name CHAR(25),
    regionkey INT,
    comment VARCHAR(152),
    CONSTRAINT PK_Nation_Cascade_Demo PRIMARY KEY (nationkey),
    CONSTRAINT FK_Nation_Cascade_Demo_Region
        FOREIGN KEY (regionkey) REFERENCES Region (regionkey) ON DELETE CASCADE
) ENGINE = InnoDB;

START TRANSACTION;

INSERT INTO Region (regionkey, name) VALUES (904, '级联测试地区');
INSERT INTO Nation_Cascade_Demo (nationkey, name, regionkey)
VALUES (904, '级联测试国家一', 904), (905, '级联测试国家二', 904);

-- 删除前核对地区数量和所属国家数量。
SELECT '删除前' AS stage,
       (SELECT COUNT(*) FROM Region WHERE regionkey = 904) AS region_count,
       (SELECT COUNT(*) FROM Nation_Cascade_Demo WHERE regionkey = 904) AS nation_count;

-- 只执行父表的删除，外键自动删除演示表中引用该地区的两行。
DELETE FROM Region WHERE regionkey = 904;

SELECT '删除后' AS stage,
       (SELECT COUNT(*) FROM Region WHERE regionkey = 904) AS region_count,
       (SELECT COUNT(*) FROM Nation_Cascade_Demo WHERE regionkey = 904) AS nation_count;

-- 结束事务并清理本任务创建的演示表。
ROLLBACK;
DROP TABLE Nation_Cascade_Demo;
