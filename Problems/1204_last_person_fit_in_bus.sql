-- Write your PostgreSQL query statement below
SELECT person_name
FROM Queue
WHERE turn = 
(SELECT q1.turn
FROM Queue q1
LEFT JOIN Queue q2
ON q1.turn >= q2.turn
GROUP BY q1.turn
HAVING SUM(q2.weight) <= 1000
ORDER BY SUM(q2.weight) DESC
LIMIT 1);