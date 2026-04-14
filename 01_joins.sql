-- ============================================
-- JOINs Practice
-- Tables: users, orders, products
-- ============================================

-- INNER JOIN: users with their orders
SELECT u.name, o.amount, o.status
FROM users u
JOIN orders o ON u.id = o.user_id;

-- LEFT JOIN: all users including those without orders
SELECT u.name, COUNT(o.id) AS order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.name;

-- LEFT JOIN: find users with NO orders
SELECT u.name
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;

-- Triple JOIN: user name, product name, order amount
SELECT u.name, p.name AS product, o.amount
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN products p ON o.product_id = p.id
WHERE o.status = 'completed';

-- Triple JOIN with GROUP BY: revenue per category per user
SELECT u.name, p.category, SUM(o.amount) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN products p ON o.product_id = p.id
WHERE o.status = 'completed'
GROUP BY u.name, p.category
ORDER BY total_spent DESC;
