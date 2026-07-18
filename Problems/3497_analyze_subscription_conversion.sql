-- Write your PostgreSQL query statement below
WITH user_activities AS ( SELECT
    user_id,
    AVG(activity_duration) FILTER (WHERE activity_type = 'free_trial') AS trial_avg_duration,
    AVG(activity_duration) FILTER (WHERE activity_type = 'paid') AS paid_avg_duration
FROM UserActivity
GROUP BY user_id )

SELECT user_id, ROUND(trial_avg_duration,2) AS trial_avg_duration, ROUND(paid_avg_duration,2) AS paid_avg_duration
FROM user_activities
WHERE trial_avg_duration IS NOT NULL AND paid_avg_duration IS NOT NULL
ORDER BY user_id
