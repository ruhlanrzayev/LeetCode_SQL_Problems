-- Write your PostgreSQL query statement below
WITH leaf_nodes AS (
    SELECT t1.id, 'Leaf' AS type
    FROM Tree t1
    WHERE NOT EXISTS (
        SELECT 1
        FROM Tree t2
        WHERE t2.p_id = t1.id
    )
)
SELECT 
    DISTINCT t1.id,
    CASE 
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id IN (SELECT ID FROM leaf_nodes) THEN 'Leaf'
    ELSE 'Inner' END AS type
FROM Tree t1
