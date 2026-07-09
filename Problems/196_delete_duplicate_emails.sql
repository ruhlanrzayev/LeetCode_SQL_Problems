-- Write your PostgreSQL query statement below
-- Solution 1:

-- DELETE FROM Person 
-- WHERE id NOT IN (
--     SELECT MIN(id)
--     FROM Person
--     GROUP BY email
-- )

-- Solution 2:

DELETE FROM Person p1
USING Person p2
WHERE p1.email = p2.email AND p1.id > p2.id


/*
There's as you can see, two solution that i wrote for this question. Each of them look good,
so let's start explain what's goin on there.
In the first solution, i wrote subquery to solve this problem. We just use delete method with
"where id not in" condition and then one subquery. This subquery return distinct id values with grouping emails
where all just min(id) values. And boom. As i said before we have one condition and this condition
delete some values which aren't in this subquery.
On the other hand, i wrote delete ... using method , which is postgres feature. I used same table
again with using method with different name and i just wrote where condition it combine
all same emails and just delete whose id is bigger.
*/