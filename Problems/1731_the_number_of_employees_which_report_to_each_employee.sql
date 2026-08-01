-- Write your PostgreSQL query statement below
SELECT e1.employee_id, e1.name, COUNT(*) AS reports_count, ROUND(AVG(e2.age)) AS average_age
FROM Employees e1
JOIN Employees e2 ON e2.reports_to = e1.employee_id
GROUP BY e1.employee_id, e1.name
ORDER BY e1.employee_id
