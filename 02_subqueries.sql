-- ============================================
-- Subqueries Practice
-- Tables: users, orders, products
-- ============================================

-- Scalar subquery: orders above average amount
SELECT id, amount
FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders);

-- Scalar subquery: users with total above average
SELECT u.name, SUM(o.amount) AS total
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.name
HAVING SUM(o.amount) > (SELECT AVG(amount) FROM orders);

-- IN: users who have at least one order
SELECT name
FROM users
WHERE id IN (SELECT user_id FROM orders);

-- NOT IN: users with no orders
SELECT name
FROM users
WHERE id NOT IN (SELECT user_id FROM orders);

-- NOT IN with two levels: users who never bought Electronics
SELECT name
FROM users
WHERE id NOT IN (
    SELECT user_id FROM orders
    WHERE product_id IN (
        SELECT id FROM products WHERE category = 'Electronics'
    )
);

-- CASE WHEN: users with 2+ completed orders and no failed orders
SELECT u.name
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.name
HAVING COUNT(CASE WHEN o.status = 'completed' THEN 1 END) >= 2
AND COUNT(CASE WHEN o.status = 'failed' THEN 1 END) = 0;

-- Nested subquery: users with order count above average
SELECT u.name, COUNT(o.id) AS order_count
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.name
HAVING COUNT(o.id) > (
    SELECT AVG(cnt) FROM (
        SELECT COUNT(id) AS cnt
        FROM orders
        GROUP BY user_id
    )
);
