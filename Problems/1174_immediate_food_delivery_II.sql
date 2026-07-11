-- Write your PostgreSQL query statement below
SELECT
    ROUND(AVG(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END)::numeric * 100, 2) AS immediate_percentage
FROM Delivery d
LEFT JOIN 
(
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
) f
ON d.customer_id = f.customer_id
WHERE d.order_date = f.first_order_date
