-- Write your PostgreSQL query statement below
WITH categories AS (
    SELECT *
    FROM (VALUES
        ('Low Salary'),
        ('Average Salary'),
        ('High Salary')
    ) AS t(category)
),
counts AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            WHEN income > 50000 THEN 'High Salary'
        END AS category,
        COUNT(*) AS cnt
    FROM Accounts
    GROUP BY category
)
SELECT
    c.category,
    COALESCE(cnt, 0) AS accounts_count
FROM categories c
LEFT JOIN counts
ON c.category = counts.category;
