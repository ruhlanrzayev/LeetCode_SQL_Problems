-- Write your PostgreSQL query statement below
WITH diff_date AS (
    SELECT *, '2019-08-16'::date - change_date::date AS diff
    FROM Products
)

SELECT Final.product_id, COALESCE(SUM(Final.price), 10) AS price
FROM (SELECT 
    diff_date.*, 
    d1.min_diff,
    CASE WHEN diff_date.diff = d1.min_diff THEN new_price 
        WHEN diff_date.diff <> d1.min_diff THEN 0 ELSE NULL
    END AS price
FROM diff_date
LEFT JOIN
(SELECT product_id, MIN(diff) AS min_diff
FROM diff_date
WHERE diff >= 0
GROUP BY product_id) d1
ON diff_date.product_id = d1.product_id) Final
GROUP BY Final.product_id