-- Write your PostgreSQL query statement below
SELECT r.contest_id, ROUND(COUNT(DISTINCT r.user_id)::numeric / COUNT(DISTINCT u.user_id)::numeric * 100, 2) AS percentage
FROM Users u
CROSS JOIN Register r
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id