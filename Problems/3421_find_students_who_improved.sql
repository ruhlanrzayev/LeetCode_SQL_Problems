# Write your MySQL query statement below
WITH first_score AS (
    SELECT student_id, subject, score AS first_score
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (
                   PARTITION BY student_id, subject
                   ORDER BY exam_date
               ) AS rn
        FROM Scores
    ) t
    WHERE rn = 1
),

last_score AS (
    SELECT student_id, subject, score AS last_score
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (
                   PARTITION BY student_id, subject
                   ORDER BY exam_date DESC
               ) AS rn
        FROM Scores
    ) t
    WHERE rn = 1
),

exam_count AS (
    SELECT
        student_id,
        subject,
        COUNT(*) AS exam_count
    FROM Scores
    GROUP BY student_id, subject
)

SELECT
    f.student_id,
    f.subject,
    f.first_score,
    l.last_score AS latest_score
FROM first_score f
JOIN last_score l
    ON f.student_id = l.student_id
   AND f.subject = l.subject
JOIN exam_count e
    ON f.student_id = e.student_id
   AND f.subject = e.subject
WHERE e.exam_count >= 2
  AND l.last_score > f.first_score;
