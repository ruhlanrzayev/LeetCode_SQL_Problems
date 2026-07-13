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
├── 550_game_play_analysis_IV.sql
├── 570_managers_with_5_directors.sql
├── 584_find_customer_referee.sql
├── 595_big_countries.sql
├── 596_classes_with_at_least_5_students.sql
├── 602_friend_requests_II.sql
├── 619_biggest_single_number.sql
├── 620_not_boring_movies.sql
├── 1045_customers_who_bought_all_products.sql
├── 1070_product_sales_analysis_III.sql
├── 1075_project_employees_I.sql
├── 1141_user_activity_for_30_days.sql
├── 1148_article_views_I.sql
├── 1158_market_analysis_I.sql
├── 1174_immediate_food_delivery_II.sql
├── 1193_monthly_transactions_I.sql
├── 1211_queries_quality_and_percentage.sql
├── 1251_average_selling_price.sql
├── 1280_students_and_examinations.sql
├── 1378_replace_employee_id_with_unique.sql
├── 1633_percentage_of_users_attended.sql
├── 1683_invalid_tweets.sql
├── 1729_find_followers_count.sql
├── 1757_recyclable_and_low_fat_products.sql
├── 1789_primary_dep_for_each_employee.sql
├── 1934_confirmation_rate.sql
├── 2356_number_of_unique_subjects_by_teacher.sql
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
| 550 | [Game Play Analysis IV](https://leetcode.com/problems/game-play-analysis-iv/) | Medium | LEFT JOIN to subquery (MIN date) + INTERVAL comparison |
| 570 | [Managers with at Least 5 Direct Reports](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/) | Medium | GROUP BY / HAVING |
| 584 | [Find Customer Referee](https://leetcode.com/problems/find-customer-referee/) | Easy | IFNULL / COALESCE |
| 595 | [Big Countries](https://leetcode.com/problems/big-countries/) | Easy | WHERE ... OR |
| 596 | [Classes With at Least 5 Students](https://leetcode.com/problems/classes-more-than-5-students/) | Easy | GROUP BY / HAVING |
| 602 | [Friend Requests II: Who Has the Most Friends](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/) | Medium | UNION + GROUP BY |
| 619 | [Biggest Single Number](https://leetcode.com/problems/biggest-single-number/) | Easy | GROUP BY / HAVING + MAX |
| 620 | [Not Boring Movies](https://leetcode.com/problems/not-boring-movies/) | Easy | WHERE ... AND / ORDER BY |
| 1045 | [Customers Who Bought All Products](https://leetcode.com/problems/customers-who-bought-all-products/) | Medium | GROUP BY / HAVING COUNT(DISTINCT) |
| 1070 | [Product Sales Analysis III](https://leetcode.com/problems/product-sales-analysis-iii/) | Medium | Window function / MIN per group |
| 1075 | [Project Employees I](https://leetcode.com/problems/project-employees-i/) | Easy | JOIN + AVG + GROUP BY |
| 1141 | [User Activity for the Past 30 Days I](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/) | Easy | WHERE date range + GROUP BY |
| 1148 | [Article Views I](https://leetcode.com/problems/article-views-i/) | Easy | Self-comparison / DISTINCT |
| 1158 | [Market Analysis I](https://leetcode.com/problems/market-analysis-i/) | Medium | LEFT JOIN + conditional aggregation |
| 1174 | [Immediate Food Delivery II](https://leetcode.com/problems/immediate-food-delivery-ii/) | Medium | CASE WHEN + conditional aggregation |
| 1193 | [Monthly Transactions I](https://leetcode.com/problems/monthly-transactions-i/) | Medium | TO_CHAR + GROUP BY + conditional aggregation |
| 1211 | [Queries Quality and Percentage](https://leetcode.com/problems/queries-quality-and-percentage/) | Easy | CASE WHEN + AVG |
| 1251 | [Average Selling Price](https://leetcode.com/problems/average-selling-price/) | Easy | LEFT JOIN + conditional aggregation |
| 1280 | [Students and Examinations](https://leetcode.com/problems/students-and-examinations/) | Easy | CROSS JOIN + LEFT JOIN |
| 1378 | [Replace Employee ID With The Unique Identifier](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/) | Easy | LEFT JOIN |
| 1633 | [Percentage of Users Attended a Contest](https://leetcode.com/problems/percentage-of-users-attended-a-contest/) | Easy | COUNT + subquery percentage |
| 1683 | [Invalid Tweets](https://leetcode.com/problems/invalid-tweets/) | Easy | CHAR_LENGTH() |
| 1729 | [Find Followers Count](https://leetcode.com/problems/find-followers-count/) | Easy | GROUP BY + COUNT |
| 1757 | [Recyclable and Low Fat Products](https://leetcode.com/problems/recyclable-and-low-fat-products/) | Easy | WHERE ... AND |
| 1789 | [Primary Department for Each Employee](https://leetcode.com/problems/primary-department-for-each-employee/) | Medium | WHERE ... OR + subquery (GROUP BY / HAVING) |
| 1934 | [Confirmation Rate](https://leetcode.com/problems/confirmation-rate/) | Medium | LEFT JOIN + conditional aggregation |
| 2356 | [Number of Unique Subjects Taught by Each Teacher](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/) | Easy | GROUP BY + COUNT(DISTINCT) |

## Notes

- All queries target PostgreSQL syntax (LeetCode's PostgreSQL option), not MySQL.
- Solutions prioritize correctness over what happens to pass LeetCode's specific test cases — some accepted submissions on LeetCode use logic that doesn't generalize (e.g., total `COUNT` instead of consecutive-row checks); those are noted where relevant.

## Author

[ruhlanrzayev](https://github.com/ruhlanrzayev)