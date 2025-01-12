SELECT employee_id,department_id
FROM employee
WHERE primary_flag='y'

UNION

SELECT employee_id,department_id
FROM employee
WHERE employee_id IN(
    SELECT employee_id
    FROM employee
    GROUP BY employee_id
    HAVING COUNT(department_id)=1
)
;
