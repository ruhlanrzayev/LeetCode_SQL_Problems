-- Write your PostgreSQL query statement below
/* First Solution:

select max(salary) as secondhighestsalary
from employee
where salary < (select max(salary) from employee)

*/

/* Second Solution: */

select (
    select distinct salary
    from employee
    order by salary desc
    limit 1 offset 1
) as secondhighestsalary

/*
I wrote two solutions for this question. Both of them are much easier but if I have to explain both of them individually, let's move on.
The first one is called subquery technique. I wrote the same query twice, it finds the max value (for example n).
The outer query then finds the max salary among rows where salary is less than n, which excludes the highest salary and returns the second-highest (m).
The second one is the offset/limit technique. OFFSET skips the first (n-1) rows. OFFSET 1 skips the row with the highest salary. LIMIT 1 then takes the next row, which is the second-highest salary.
*/