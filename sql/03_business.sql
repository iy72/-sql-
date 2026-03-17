USE e_commerce;

-- 1. 查询指定用户的所有订单（按时间倒序）
SELECT 
    o.order_id,
    o.total_amount,
    o.status,
    o.create_time,
    GROUP_CONCAT(p.product_name SEPARATOR ', ') AS product_names
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE o.user_id = 1
GROUP BY o.order_id
ORDER BY o.create_time DESC;



-- 2. 统计近30天各分类的商品销量（业务报表常用）
SELECT 
    c.category_name,
    SUM(oi.quantity) AS total_sales
FROM product_categories c
LEFT JOIN products p ON c.category_id = p.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.create_time >= DATE_SUB(NOW(), INTERVAL 30 DAY)
  AND o.status IN (1,2,3) -- 仅统计已支付/发货/完成的订单
GROUP BY c.category_id
ORDER BY total_sales DESC;




-- 3. 查询用户的累计消费金额（用户画像常用）
SELECT u.user_id,u.username,SUM(o.total_amount) AS total_consume
FROM users u LEFT JOIN orders o ON o.user_id = u.user_id
WHERE o.status IN (1,2,3)
GROUP BY u.user_id 
HAVING total_consume > 0
ORDER BY total_consume DESC;





