CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) 
RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (
    SELECT t.salary
    FROM (
        SELECT
            e.salary,
            dense_rank() OVER(ORDER BY e.salary DESC) AS rnk
        FROM Employee e
    ) AS t
    WHERE rnk = N
    LIMIT 1
  );

END;
$$ LANGUAGE plpgsql;
