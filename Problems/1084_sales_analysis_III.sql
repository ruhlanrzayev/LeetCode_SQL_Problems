-- Write your PostgreSQL query statement below
SELECT p.product_id, p.product_name
FROM Product p
WHERE EXISTS (
    SELECT *
    FROM Sales s
    WHERE 
        s.product_id = p.product_id
        AND sale_date::date BETWEEN '2019-01-01' AND '2019-03-31'
)
AND NOT EXISTS (
    SELECT *
    FROM Sales s
    WHERE s.product_id = p.product_id
    AND sale_date::date NOT BETWEEN '2019-01-01' AND '2019-03-31'
)