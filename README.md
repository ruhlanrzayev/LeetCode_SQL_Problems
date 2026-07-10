# LeetCode Solutions

### SQL solutions to LeetCode database problems, written in PostgreSQL.

## Structure
 
Each problem is a single `.sql` file inside the `Problems` folder, named by problem number and title.
 
```
Problems/
├── 175_combine_two_tables.sql
├── 176_second_highest_salary.sql
├── 180_consecutive_numbers.sql
├── 181_employees_earning_more_manager.sql
├── 182_duplicate_emails.sql
├── 183_customers_who_never_order.sql
├── 184_department_highest_salary.sql
├── 185_department_top_three_salaries.sql
├── 196_delete_duplicate_emails.sql
├── 584_find_customer_referee.sql
├── 595_big_countries.sql
├── 1148_article_views_I.sql
├── 1280_students_and_examinations.sql
├── 1378_replace_employee_id_with_unique.sql
├── 1683_invalid_tweets.sql
├── 1757_recyclable_and_low_fat_products.sql
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
| 196 | [Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/) | Easy | DELETE ... USING (self-join) |
| 584 | [Find Customer Referee](https://leetcode.com/problems/find-customer-referee/) | Easy | IFNULL / COALESCE |
| 595 | [Big Countries](https://leetcode.com/problems/big-countries/) | Easy | WHERE ... OR |
| 1148 | [Article Views I](https://leetcode.com/problems/article-views-i/) | Easy | Self-comparison / DISTINCT |
| 1280 | [Students and Examinations](https://leetcode.com/problems/students-and-examinations/) | Easy | CROSS JOIN + LEFT JOIN |
| 1378 | [Replace Employee ID With The Unique Identifier](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/) | Easy | LEFT JOIN |
| 1683 | [Invalid Tweets](https://leetcode.com/problems/invalid-tweets/) | Easy | CHAR_LENGTH() |
| 1757 | [Recyclable and Low Fat Products](https://leetcode.com/problems/recyclable-and-low-fat-products/) | Easy | WHERE ... AND |

## Notes

- All queries target PostgreSQL syntax (LeetCode's PostgreSQL option), not MySQL.
- Solutions prioritize correctness over what happens to pass LeetCode's specific test cases — some accepted submissions on LeetCode use logic that doesn't generalize (e.g., total `COUNT` instead of consecutive-row checks); those are noted where relevant.

## Author

[ruhlanrzayev](https://github.com/ruhlanrzayev)