-- Write your PostgreSQL query statement below
select e1.name as Employee
from employee e1
where e1.salary > (select e2.salary from employee e2 where e2.id = e1.managerid)


/*
I used a subquery instead of a join to solve this problem, since there's only one table.
We keep e1.salary first, then select the manager's salary in the subquery.
The correlation is e2.id = e1.managerid.
This matches each employee's managerid (e1.managerid) to the manager's own id (e2.id),
so the subquery returns that manager's salary for comparison.
*/