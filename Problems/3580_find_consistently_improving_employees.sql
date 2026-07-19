-- Write your PostgreSQL query statement below
WITH ranked AS (
    SELECT
        e.employee_id,
        p.review_date,
        p.rating,
        ROW_NUMBER() OVER (
            PARTITION BY e.employee_id
            ORDER BY p.review_date DESC
        ) AS rnk,
        COUNT(*) OVER (PARTITION BY e.employee_id) AS cnt
    FROM Employees e
    JOIN performance_reviews p ON p.employee_id = e.employee_id
    
), scores AS (
    SELECT
        employee_id,
        MAX(CASE WHEN rnk = 1 THEN rating END) AS first_score,
        MAX(CASE WHEN rnk = 2 THEN rating END) AS middle_score,
        MAX(CASE WHEN rnk = 3 THEN rating END) AS last_score
    FROM ranked
    WHERE rnk <= 3
      AND cnt >= 3
    GROUP BY employee_id
)

SELECT 
    s.employee_id,
    e.name,
    s.first_score - s.last_score AS improvement_score
FROM scores s
JOIN Employees e ON e.employee_id = s.employee_id
WHERE first_score > middle_score
    AND middle_score > last_score
ORDER BY improvement_score DESC, e.name ASC
