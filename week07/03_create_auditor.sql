-- 第七周探索任务 3：使用管理员连接创建只读审计角色和账号。
CREATE ROLE 'auditor'@'%';
GRANT SELECT ON tpch.* TO 'auditor'@'%';

-- MySQL 在结果中返回随机密码，供本次实验登录。
CREATE USER 'audit_user'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
GRANT 'auditor'@'%' TO 'audit_user'@'localhost';
SET DEFAULT ROLE 'auditor'@'%' TO 'audit_user'@'localhost';

SHOW GRANTS FOR 'audit_user'@'localhost' USING 'auditor'@'%';
