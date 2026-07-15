-- Write your PostgreSQL query statement below
SELECT
    request_at AS "Day",
    ROUND(
        COUNT(*) FILTER (WHERE status LIKE 'cancelled%')::numeric / COUNT(*),
        2
    ) AS "Cancellation Rate"
FROM Trips
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
AND NOT EXISTS (
    SELECT 1
    FROM Users u
    WHERE u.users_id = Trips.client_id
      AND u.banned = 'Yes'
)
AND NOT EXISTS (
    SELECT 1
    FROM Users u
    WHERE u.users_id = Trips.driver_id
      AND u.banned = 'Yes'
)
GROUP BY request_at
ORDER BY request_at
