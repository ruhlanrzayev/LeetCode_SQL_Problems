-- Write your PostgreSQL query statement below
WITH t AS (
    SELECT num,
           LAG(num) OVER (ORDER BY id) AS prev_num,
           LEAD(num) OVER (ORDER BY id) AS next_num
    FROM logs
)
SELECT DISTINCT num AS ConsecutiveNums
FROM t
WHERE num = prev_num AND num = next_num;

/*
This question asks to find numbers that appear at least 3 times in a row (consecutive rows, not just anywhere in the table).

I used LAG and LEAD window functions. LAG(num) grabs the num value from the row right before the current one (in id order). LEAD(num) grabs the num value from the row right after.

So for every row I now have 3 things side by side: the current num, the previous row's num, and the next row's num.

Then I filter with WHERE num = prev_num AND num = next_num. This means: the row before me has the same num, and the row after me has the same num too. If that's true, I'm sitting in the middle of a 3-in-a-row streak.

If a streak is longer than 3 (like 4 or 5 same numbers back to back), more than one row will pass this check with the same num. That's why I added DISTINCT — to only return each qualifying number once.

First row and last row don't have a previous/next row, so LAG/LEAD return NULL for them. NULL never equals num, so they get filtered out automatically, no extra handling needed.
*/