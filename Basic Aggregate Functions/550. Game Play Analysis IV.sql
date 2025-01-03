WITH FirstLogin AS(
    SELECT player_id,MIN(event_date) AS first_date
    FROM activity
    GROUP BY player_id
),
NextDayLogin AS(
    SELECT f.player_id
    FROM FirstLogin f
    JOIN activity a
    ON f.player_id=a.player_id
    AND a.event_date=DATE_ADD(f.first_date,INTERVAL 1 DAY)
)
SELECT ROUND(COUNT(DISTINCT n.player_id)/COUNT(DISTINCT f.player_id),2)AS fraction
FROM FirstLogin f
LEFT JOIN NextDayLogin n
ON f.player_id=n.player_id;