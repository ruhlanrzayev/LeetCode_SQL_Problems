-- Write your PostgreSQL query statement below
select d.name as Department, e.name as Employee, e.salary as Salary
from employee e
join department d on e.departmentid = d.id
where e.salary = (
    select max(salary)
    from employee
    where departmentId = e.departmentId
);

/*
I used correlated subquery instead of group by, cause of if we group by e.name too,
every employee gets own group and max(e.salary) just return their own salary, not real max.
So subquery calculate max salary for that employee's department -> departmentId = e.departmentId.
And where e.salary = that max, only top earner(s) return.
*/