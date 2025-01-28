SELECT COALESCE(
    (SELECT MAX(salary)
     FROM employee
     WHERE salary < (SELECT MAX(salary) FROM employee)),
    NULL) AS SecondHighestSalary;