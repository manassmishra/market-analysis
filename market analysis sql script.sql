use project_orders;
show tables;
SELECT * FROM aisles LIMIT 5;
SELECT * FROM departments LIMIT 5;
SELECT * FROM order_products_train LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM products LIMIT 5;    
SELECT  a.aisle,
    COUNT (p.product_id) AS total_products
FROM products p
JOIN aisles a
ON p.aisle_id = a.aisle_id
GROUP BY a.aisle
ORDER BY total_products DESC
LIMIT 10;
  SELECT COUNT( DISTINCT department_id) AS total_departments
 FROM departments;
  SELECT
    d.department,
    COUNT(p.product_id) AS total_products
FROM products p
JOIN departments d
    ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY total_products DESC;
SELECT
    p.product_name,
    ROUND(AVG(opt.reordered) * 100, 2) AS reorder_rate
FROM order_products_train opt
JOIN products p
    ON opt.product_id = p.product_id
GROUP BY p.product_name
HAVING COUNT(*) > 5
ORDER BY reorder_rate DESC
LIMIT 10;
SELECT 1;
SELECT
    p.product_name,
    COUNT(*) AS total_orders,
    SUM(opt.reordered) AS reorder_count,
    ROUND(SUM(opt.reordered) * 100.0 / COUNT(*), 2) AS reorder_rate
FROM order_products_train opt
JOIN products p
    ON opt.product_id = p.product_id
GROUP BY opt.product_id, p.product_name
HAVING COUNT(*) >= 10
ORDER BY reorder_rate DESC, total_orders DESC
LIMIT 10;
SHOW INDEX FROM order_products_train;
DESCRIBE order_products_train;
SELECT
    p.product_name,
    x.reorder_count
FROM products p
JOIN (
    SELECT
        product_id,
        SUM(reordered) AS reorder_count
    FROM order_products_train
    GROUP BY product_id
    ORDER BY reorder_count DESC
    LIMIT 10
) x
ON p.product_id = x.product_id
ORDER BY x.reorder_count DESC;
SELECT COUNT(DISTINCT user_id) AS total_users
FROM orders;
SELECT
    user_id,
    ROUND(AVG(days_since_prior_order),2) AS avg_days_between_orders
FROM orders
WHERE days_since_prior_order IS NOT NULL
GROUP BY user_id
ORDER BY avg_days_between_orders DESC;
SELECT
    order_hour_of_day,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY total_orders DESC;
SELECT
    order_dow,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_dow
ORDER BY order_dow;
SELECT
    p.product_name,
    COUNT(*) AS total_orders
FROM order_products_train opt
JOIN products p
ON opt.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC
LIMIT 10;
SELECT
    d.department,
    COUNT(DISTINCT o.user_id) AS total_users
FROM orders o
JOIN order_products_train opt
ON o.order_id = opt.order_id
JOIN products p
ON opt.product_id = p.product_id
JOIN departments d
ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY total_users DESC;
SELECT
    ROUND(AVG(product_count), 2) AS avg_products_per_order
FROM
(
    SELECT
        order_id,
        COUNT(product_id) AS product_count
    FROM order_products_train
    GROUP BY order_id
) t;
SELECT
    COUNT(*) / COUNT(DISTINCT order_id) AS avg_products_per_order
FROM order_products_train;
SELECT
    product_id,
    SUM(reordered) AS reorder_count
FROM order_products_train
WHERE reordered = 1
GROUP BY product_id
LIMIT 10;
SELECT COUNT(*) AS products_reordered_more_than_once
FROM
(
    SELECT product_id
    FROM order_products_train
    WHERE reordered = 1
    GROUP BY product_id
    HAVING SUM(reordered) > 1
) t;
SELECT
    order_hour_of_day,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY order_hour_of_day;
SELECT
    order_id,
    COUNT(product_id) AS order_size
FROM order_products_train
GROUP BY order_id
LIMIT 20;
SELECT
    order_size,
    COUNT(*) AS number_of_orders
FROM (
    SELECT
        order_id,
        COUNT(product_id) AS order_size
    FROM order_products_train
    GROUP BY order_id
) t
GROUP BY order_size
ORDER BY order_size;
SELECT
    a.aisle,
    ROUND(AVG(opt.reordered), 2) AS avg_reorder_rate
FROM order_products_train opt
JOIN products p
    ON opt.product_id = p.product_id
JOIN aisles a
    ON p.aisle_id = a.aisle_id
GROUP BY a.aisle
ORDER BY avg_reorder_rate DESC;
SELECT
    order_dow,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_dow
ORDER BY order_dow;
SELECT
    user_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 10;
SELECT
    d.department,
    a.aisle,
    COUNT(p.product_id) AS total_products
FROM products p
JOIN aisles a
    ON p.aisle_id = a.aisle_id
JOIN departments d
    ON p.department_id = d.department_id
GROUP BY d.department, a.aisle
ORDER BY d.department, total_products DESC;

