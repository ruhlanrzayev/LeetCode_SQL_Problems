-- Write your PostgreSQL query statement below
with id1 as ( select e.employee_id from employees e
left join salaries s on e.employee_id = s.employee_id
where s.employee_id is null ),

id2 as (select s.employee_id from salaries s
left join employees e on s.employee_id = e.employee_id
where e.employee_id is null)

SELECT employee_id
FROM id1

UNION ALL

SELECT employee_id
FROM id2

ORDER BY employee_id