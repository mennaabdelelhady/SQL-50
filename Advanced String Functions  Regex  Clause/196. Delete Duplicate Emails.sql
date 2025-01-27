DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM (SELECT * FROM Person) AS temp
    GROUP BY email
);