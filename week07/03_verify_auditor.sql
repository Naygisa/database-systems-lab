-- 第七周探索任务 3：切换到 audit_user 连接后运行。
-- 先选中并执行以下查询，核对当前账号、已激活角色和查询结果。
SELECT CURRENT_USER() AS login_account,
       CURRENT_ROLE() AS active_role,
       p.partkey,
       p.name AS part_name
FROM tpch.Part AS p
ORDER BY p.partkey
LIMIT 3;

-- 单独执行下方 UPDATE：只读角色应被拒绝，筛选条件也不会匹配任何记录。
UPDATE tpch.Part
SET name = '权限验证'
WHERE 1 = 0;
