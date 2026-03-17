USE e_commerce;

-- 插入分类数据
INSERT INTO product_categories (category_name, parent_id) VALUES 
('电子产品', 0),
('手机', 1),
('服装', 0),
('男装', 3);

-- 插入商品数据
INSERT INTO products (product_name, category_id, price, stock, sales) VALUES 
('iPhone 15', 2, 5999.00, 100, 50),
('华为Mate 70', 2, 4999.00, 200, 80),
('纯棉T恤', 4, 99.00, 500, 200);

-- 插入用户数据（密码哈希仅示例，简历提：实际用bcrypt加密）
INSERT INTO users (username, phone, email, password_hash) VALUES 
('zhangsan', '13800138000', 'zhangsan@test.com', 'hash_123456'),
('lisi', '13900139000', 'lisi@test.com', 'hash_654321');

-- 插入订单数据
INSERT INTO orders (order_id, user_id, total_amount, status, pay_time) VALUES 
('20260317138001380001', 1, 5999.00, 3, '2026-03-17 10:00:00'),
('20260317139001390001', 2, 99.00, 1, '2026-03-17 11:00:00');

-- 插入订单项数据
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
('20260317138001380001', 1, 1, 5999.00),
('20260317139001390001', 3, 1, 99.00);