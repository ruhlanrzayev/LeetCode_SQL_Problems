# LeetCode Solutions

### SQL solutions to LeetCode database problems, written in PostgreSQL.

## Problems

| # | Title | Difficulty | Technique |
|---|-------|------------|-----------|
| 175 | [Combine Two Tables](https://leetcode.com/problems/combine-two-tables/) | Easy | LEFT JOIN |
| 176 | [Second Highest Salary](https://leetcode.com/problems/second-highest-salary/) | Medium | Subquery / OFFSET-LIMIT |
| 180 | [Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/) | Medium | LAG/LEAD window functions |

## Notes

- All queries target PostgreSQL syntax (LeetCode's PostgreSQL option), not MySQL.
- Solutions prioritize correctness over what happens to pass LeetCode's specific test cases — some accepted submissions on LeetCode use logic that doesn't generalize (e.g., total `COUNT` instead of consecutive-row checks); those are noted where relevant.

## Author

[ruhlanrzayev](https://github.com/ruhlanrzayev)