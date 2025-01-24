WITH RankedSalaries AS (
    SELECT
        e.name AS Employee,
        e.salary AS Salary,
        e.departmentId,
        DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS SalaryRank
    FROM
        Employee e
)
SELECT
    d.name AS Department,
    rs.Employee,
    rs.Salary
FROM
    RankedSalaries rs
JOIN
    Department d ON rs.departmentId = d.id
WHERE
    rs.SalaryRank <= 3
ORDER BY
    d.name,
    rs.Salary DESC,
    rs.Employee;