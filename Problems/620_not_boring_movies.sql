-- Write your PostgreSQL query statement below
SELECT *
FROM Cinema
WHERE id % 2 = 1 AND lower(description) not like 'boring'
ORDER BY rating DESC