-- Write your PostgreSQL query statement below
select name as Customers
from customers
left join orders on customers.id = orders.customerID
where orders.customerID is null


/*
We use a left join to solve this problem: for each customer, we bring in matching rows
from orders. If a customer has no matching order, the joined columns from 'orders'
(including customerID) come back as null.
We filter with 'where orders.customerID is null' to keep only customers with no orders.
*/