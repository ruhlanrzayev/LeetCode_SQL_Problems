-- Write your PostgreSQL query statement below
select email
from person
group by email
having count(*) > 1

/*
No detailed breakdown needed, this is a common problem with a common solution.
We check whether any 'email' value appears more than once, using having count(*) > 1.
Since count(*) is an aggregate function, we must group by the column being checked (email).
*/