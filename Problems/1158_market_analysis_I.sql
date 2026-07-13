-- Write your PostgreSQL query statement below
SELECT u.user_id AS buyer_id, u.join_date, SUM(CASE WHEN TO_CHAR(o.order_date, 'YYYY')::numeric = 2019 THEN 1 ELSE 0 END) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.buyer_id
LEFT JOIN Items i ON o.item_id = i.item_id
GROUP BY u.user_id, u.join_date
