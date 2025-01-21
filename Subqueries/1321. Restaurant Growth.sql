WITH DailyAmounts AS (
    SELECT 
        visited_on,
        SUM(amount) AS amount
    FROM 
        Customer
    GROUP BY 
        visited_on
),
MovingAverages AS (
    SELECT 
        visited_on,
        SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS total_amount,
        ROUND(AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS rn
    FROM 
        DailyAmounts
)
SELECT 
    visited_on,
    total_amount AS amount,
    average_amount
FROM 
    MovingAverages
WHERE 
    rn >= 7
ORDER BY 
    visited_on;