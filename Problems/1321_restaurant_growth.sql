-- Write your PostgreSQL query statement below
WITH daily AS (
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
)

SELECT t.visited_on, t.amount, round(t.average_amount, 2) as average_amount
FROM
(SELECT
    visited_on,
    SUM(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS amount,
    AVG(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS average_amount,
    ROW_NUMBER() OVER (ORDER BY visited_on) AS r
FROM daily) t
WHERE t.r >=7
