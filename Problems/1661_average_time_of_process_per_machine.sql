-- Write your PostgreSQL query statement below
WITH ptime AS (
    SELECT 
        machine_id,
        process_id,
        SUM(
            CASE 
                WHEN activity_type = 'end' THEN timestamp
                ELSE -timestamp
            END 
        ) AS process_time
    FROM Activity
    GROUP BY machine_id, process_id
    ORDER BY machine_id
)

SELECT
    machine_id,
    ROUND(AVG(process_time::numeric), 3) AS processing_time
FROM ptime
GROUP BY machine_id;
