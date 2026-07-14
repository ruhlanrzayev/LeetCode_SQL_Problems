-- Write your PostgreSQL query statement below

--Solution 1:

-- (
-- SELECT u.name AS results
-- FROM MovieRating r
-- LEFT JOIN Users u
-- ON r.user_id = u.user_id
-- GROUP BY u.name
-- ORDER BY COUNT(r.rating) DESC, u.name
-- LIMIT 1
-- )

-- UNION ALL

-- (
-- SELECT m.title AS results
-- FROM MovieRating r
-- LEFT JOIN Movies m
-- ON r.movie_id = m.movie_id
-- WHERE TO_CHAR(created_at, 'YYYY-MM') = '2020-02'
-- GROUP BY m.title
-- ORDER BY AVG(rating) DESC, m.title
-- LIMIT 1
-- )

-- Solution 2:

WITH ranked_users AS (
    SELECT
        u.name,
        ROW_NUMBER() OVER (
            ORDER BY COUNT(*) DESC, u.name
        ) AS rn
    FROM MovieRating r
    JOIN Users u
        ON r.user_id = u.user_id
    GROUP BY u.user_id, u.name
),

ranked_movies AS (
    SELECT
        m.title,
        ROW_NUMBER() OVER (
            ORDER BY AVG(r.rating) DESC, m.title
        ) AS rn
    FROM MovieRating r
    JOIN Movies m
        ON r.movie_id = m.movie_id
    WHERE TO_CHAR(created_at, 'YYYY-MM') = '2020-02'
    GROUP BY m.movie_id, m.title
)

SELECT name AS results
FROM ranked_users
WHERE rn = 1

UNION ALL

SELECT title
FROM ranked_movies
WHERE rn = 1;