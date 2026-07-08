-- Write your PostgreSQL query statement below
with  top_three as(
select d.name as Department, e.name as Employee , e.salary as Salary,
DENSE_RANK() OVER (PARTITION BY d.name ORDER BY e.salary DESC) as tops
from  Employee as e
join Department as d ON e.departmentid = d.id
)

select Department,Employee,Salary
from top_three
where tops <= 3

/*
High earner means top 3 unique salaries in a department, not top 3 rows.
I used DENSE_RANK() for this. PARTITION BY d.name restarts the ranking for each department.
ORDER BY e.salary DESC gives rank 1 to the highest salary.
I used DENSE_RANK instead of RANK or ROW_NUMBER cause of ties need to share the same rank,
and no gap should come after a tie. That's what "unique" means here.
Then I just filter tops <= 3 to keep top 3 unique salary levels per department.
*/