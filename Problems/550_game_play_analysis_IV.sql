-- Write your PostgreSQL query statement below
SELECT ROUND(COUNT(DISTINCT a2.player_id)/COUNT(DISTINCT a1.player_id)::numeric, 2) AS fraction
FROM Activity a1
LEFT JOIN
(SELECT player_id, MIN(event_date) AS fld
FROM Activity
GROUP BY player_id) a2
ON a1.player_id = a2.player_id
AND event_date - INTERVAL '1 DAY' = a2.fld
