-- Write your PostgreSQL query statement below
SELECT 
    query_name, 
    ROUND(AVG(rating::numeric/position::numeric), 2) AS quality,
    ROUND(AVG(CASE WHEN rating < 3 THEN 1 ELSE 0 END)::numeric * 100, 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name