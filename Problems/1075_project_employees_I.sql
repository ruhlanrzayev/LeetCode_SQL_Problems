-- Write your PostgreSQL query statement below
SELECT p.project_id, ROUND(COALESCE(SUM(e.experience_years), 0)::numeric / COALESCE(COUNT(*), 0)::numeric,2) AS average_years
FROM Project p
LEFT JOIN Employee e USING (employee_id)
GROUP BY p.project_id
