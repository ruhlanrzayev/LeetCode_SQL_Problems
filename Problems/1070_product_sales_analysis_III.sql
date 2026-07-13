-- Write your PostgreSQL query statement below
SELECT product_id, year as first_year, quantity, price
FROM (
    SELECT *,
    rank() OVER (PARTITION BY product_id ORDER BY year) AS r
    FROM Sales
)
WHERE r = 1
