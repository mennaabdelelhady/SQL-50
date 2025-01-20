-- Find the user who has rated the greatest number of movies
WITH UserRatingCount AS (
    SELECT
        u.name,
        COUNT(mr.movie_id) AS rating_count
    FROM
        MovieRating mr
    JOIN Users u ON mr.user_id = u.user_id
    GROUP BY
        u.name
    ORDER BY
        rating_count DESC,
        u.name ASC
    LIMIT 1
),

-- Find the movie with the highest average rating in February 2020
MovieAvgRating AS (
    SELECT
        m.title,
        AVG(mr.rating) AS avg_rating
    FROM
        MovieRating mr
    JOIN Movies m ON mr.movie_id = m.movie_id
    WHERE
        mr.created_at >= '2020-02-01' AND mr.created_at <= '2020-02-29'
    GROUP BY
        m.title
    ORDER BY
        avg_rating DESC,
        m.title ASC
    LIMIT 1
)

-- Combine the results
SELECT name AS results FROM UserRatingCount
UNION ALL
SELECT title AS results FROM MovieAvgRating;