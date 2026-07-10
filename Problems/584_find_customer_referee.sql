-- Write your PostgreSQL query statement below

-- Solution 1:
-- SELECT name
-- FROM Customer
-- WHERE referee_id != 2
-- OR referee_id IS NULL

-- Solution 2:
SELECT name 
FROM Customer
WHERE COALESCE(referee_id, -1) <> 2