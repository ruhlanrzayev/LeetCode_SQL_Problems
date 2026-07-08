# LeetCode Solutions

### SQL solutions to LeetCode database problems, written in PostgreSQL.

## Structure
 
Each problem is stored in its own folder, named by problem number and title. Each folder contains a `.sql` file with the solution and a comment block explaining the approach.
 
```
leetcode/
├── 0175-combine-two-tables/
│   └── solution.sql
├── 0176-second-highest-salary/
│   └── solution.sql
├── 0180-consecutive-numbers/
│   └── solution.sql
├── 0181-employees-earning-more-than-their-managers/
│   └── solution.sql
├── 0182-duplicate-emails/
│   └── solution.sql
├── 0183-customers-who-never-order/
│   └── solution.sql
├── 0184-department-highest-salary/
│   └── solution.sql
├── 0185-department-top-three-salaries/
│   └── solution.sql
```
 
## Problems
 
| # | Title | Difficulty | Technique |
|---|-------|------------|-----------|
| 175 | [Combine Two Tables](https://leetcode.com/problems/combine-two-tables/) | Easy | LEFT JOIN |
| 176 | [Second Highest Salary](https://leetcode.com/problems/second-highest-salary/) | Medium | Subquery / OFFSET-LIMIT |
| 180 | [Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/) | Medium | LAG/LEAD window functions |
| 181 | [Employees Earning More Than Their Managers](https://leetcode.com/problems/employees-earning-more-than-their-managers/) | Easy | Correlated subquery |
| 182 | [Duplicate Emails](https://leetcode.com/problems/duplicate-emails/) | Easy | GROUP BY / HAVING |
| 183 | [Customers Who Never Order](https://leetcode.com/problems/customers-who-never-order/) | Easy | LEFT JOIN / IS NULL |
| 184 | [Department Highest Salary](https://leetcode.com/problems/department-highest-salary/) | Medium | Correlated subquery |
| 185 | [Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/) | Hard | DENSE_RANK() window function |

## Notes

- All queries target PostgreSQL syntax (LeetCode's PostgreSQL option), not MySQL.
- Solutions prioritize correctness over what happens to pass LeetCode's specific test cases — some accepted submissions on LeetCode use logic that doesn't generalize (e.g., total `COUNT` instead of consecutive-row checks); those are noted where relevant.

## Author

[ruhlanrzayev](https://github.com/ruhlanrzayev)