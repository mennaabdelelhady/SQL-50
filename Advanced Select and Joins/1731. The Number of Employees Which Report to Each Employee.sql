SELECT e1.employee_id,e1.name,COUNT(e2.reports_to)AS reports_count,ROUND(AVG(e2.age)) AS average_age
FROM employees e1
JOIN employees e2
ON e2.reports_to=e1.employee_id
GROUP BY e1.employee_id,e1.name
ORDER BY e1.employee_id;
