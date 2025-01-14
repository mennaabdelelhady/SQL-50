WITH ConsecutiveGroups AS (
    SELECT
        num,
        id,
        ROW_NUMBER() OVER (ORDER BY id) - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS grp
    FROM Logs
)
SELECT DISTINCT num AS ConsecutiveNums
FROM ConsecutiveGroups
GROUP BY num, grp
HAVING COUNT(num) >= 3;