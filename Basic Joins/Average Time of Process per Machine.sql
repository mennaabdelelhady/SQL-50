WITH ProcessTime AS (
    SELECT
        machine_id,
        process_id,
        MAX(CASE WHEN activity_type = 'end' THEN timestamp ELSE NULL END) -
        MAX(CASE WHEN activity_type = 'start' THEN timestamp ELSE NULL END) AS process_time
    FROM
        Activity
    GROUP BY
        machine_id, process_id
),
AverageTime AS (
    SELECT
        machine_id,
        ROUND(AVG(process_time), 3) AS processing_time
    FROM
        ProcessTime
    GROUP BY
        machine_id
)
SELECT
    machine_id,
    processing_time
FROM
    AverageTime
ORDER BY
    machine_id;
