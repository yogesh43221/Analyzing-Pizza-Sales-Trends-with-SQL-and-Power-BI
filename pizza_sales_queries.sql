-- Basic Queries
-- 1. Retrieve the total number of orders placed.
SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;

-- 2. Calculate the total revenue generated from pizza sales.
SELECT SUM(od.quantity * p.price) AS total_revenue 
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

-- 3. Identify the highest-priced pizza.
SELECT pizza_id, price FROM pizzas ORDER BY price DESC LIMIT 1;

-- 4. Identify the most common pizza size ordered.
SELECT p.size, COUNT(*) AS order_count 
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- Intermediate Queries
-- 6. Total quantity of each pizza category ordered.
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 7. Distribution of orders by hour of the day.
SELECT HOUR(time) AS order_hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- 8. Category-wise distribution of pizzas.
SELECT pt.category, COUNT(DISTINCT p.pizza_id) AS pizza_count
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 9. Average number of pizzas ordered per day.
SELECT date, AVG(order_count) AS avg_pizzas_per_day
FROM (
    SELECT o.date, COUNT(od.pizza_id) AS order_count
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.date
) daily_orders
GROUP BY date;

-- 10. Top 3 most ordered pizza types based on revenue.
SELECT pt.name, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;

-- Advanced Queries
-- 11. Percentage contribution of each pizza type to total revenue.
SELECT pt.name, 
       (SUM(od.quantity * p.price) / (SELECT SUM(od.quantity * p.price) FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id) * 100) AS revenue_percentage
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name;

-- 12. Cumulative revenue generated over time.
SELECT date, SUM(daily_revenue) OVER (ORDER BY date) AS cumulative_revenue
FROM (
    SELECT o.date, SUM(od.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY o.date
) daily_sales;

-- 13. Top 3 most ordered pizza types based on revenue for each pizza category.
SELECT category, name, total_revenue
FROM (
    SELECT pt.category, pt.name, SUM(od.quantity * p.price) AS total_revenue,
           RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rank
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
) ranked_pizzas
WHERE rank <= 3;
