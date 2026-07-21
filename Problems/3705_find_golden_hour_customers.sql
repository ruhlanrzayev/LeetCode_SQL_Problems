-- Write your PostgreSQL query statement below
SELECT  
    customer_id,
    count(*) AS total_orders,
    ROUND(
        COUNT(*) FILTER (
            WHERE order_timestamp::time BETWEEN TIME '11:00:00' AND TIME '14:00:00'
            OR order_timestamp::time BETWEEN TIME '18:00:00' AND TIME '21:00:00'
        ) * 100.0 / COUNT(*)
    ) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING COUNT(*) >= 3
    AND AVG(order_rating) >= 4
    AND COUNT(*) FILTER (
        WHERE order_timestamp::time BETWEEN TIME '11:00:00' AND TIME '14:00:00'
        OR order_timestamp::time BETWEEN TIME '18:00:00' AND TIME '21:00:00'
    ) >= COUNT(*) * 0.6
    AND COUNT(order_rating) >= COUNT(*) * 0.5
ORDER BY average_rating DESC, customer_id DESC
