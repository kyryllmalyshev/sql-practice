-- ============================================
-- Aggregations & Complex Queries
-- Tables: users, orders, products, employees
-- ============================================

-- Basic GROUP BY: order count per user
SELECT user_id, COUNT(*) AS order_count
FROM orders
GROUP BY user_id;

-- HAVING: users with more than 1 order
SELECT user_id, COUNT(*) AS order_count
FROM orders
GROUP BY user_id
HAVING COUNT(*) > 1;

-- HAVING with SUM: users with total spend above 300
SELECT u.name, SUM(o.amount) AS total
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.name
HAVING SUM(o.amount) > 300
ORDER BY total DESC;

-- WHERE + GROUP BY + HAVING: avg order above 200, completed only
SELECT u.name, AVG(o.amount) AS avg_order
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status = 'completed'
GROUP BY u.name
HAVING AVG(o.amount) > 200
ORDER BY avg_order DESC;

-- Category revenue: completed only, revenue above 500
SELECT p.category, SUM(o.amount) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.id
WHERE o.status = 'completed'
GROUP BY p.category
HAVING SUM(o.amount) > 500
ORDER BY revenue DESC;

-- Users with more than 1 failed order
SELECT user_id, COUNT(*) AS failed_orders
FROM orders
WHERE status = 'failed'
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Department avg salary above company average
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees)
ORDER BY avg_salary DESC;

-- Employees in departments with project budget over 100000
SELECT name, department
FROM employees
WHERE department IN (
    SELECT department
    FROM projects
    WHERE budget > 100000
);
