USE e_commerce;

-- 存储过程1：生成订单编号（规则：年月日+用户ID+随机数）
DELIMITER // -- 临时修改分隔符，避免冲突
CREATE PROCEDURE generate_order_id(
    IN user_id INT,
    OUT order_id VARCHAR(32)
)
BEGIN
    SET order_id = CONCAT(
        DATE_FORMAT(NOW(), '%Y%m%d'),
        user_id,
        FLOOR(RAND() * 1000)
    );
END //
DELIMITER ; -- 恢复分隔符

-- 存储过程2：下单时扣减商品库存（带事务，保证数据一致性）
DELIMITER //
CREATE PROCEDURE reduce_product_stock(
    IN p_product_id INT,
    IN p_quantity INT,
    OUT result INT -- 0-失败 1-成功
)
BEGIN
    DECLARE stock_left INT;
    START TRANSACTION; -- 开启事务
    
    -- 查询当前库存
    SELECT stock INTO stock_left FROM products WHERE product_id = p_product_id FOR UPDATE;
    IF stock_left >= p_quantity THEN
        -- 扣减库存
        UPDATE products SET stock = stock - p_quantity WHERE product_id = p_product_id;
        SET result = 1;
        COMMIT; -- 提交事务
    ELSE
        SET result = 0;
        ROLLBACK; -- 回滚事务
    END IF;
END //
DELIMITER ;