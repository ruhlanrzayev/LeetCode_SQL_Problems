-- Write your PostgreSQL query statement below
WITH temp_dates AS (
    SELECT
        id,
        temperature,
        recordDate,
        LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp,
        LAG(recordDate) OVER (ORDER BY recordDate) AS prev_date
    FROM Weather
)

SELECT id
FROM temp_dates
WHERE temperature > prev_temp
  AND recordDate - prev_date = 1;