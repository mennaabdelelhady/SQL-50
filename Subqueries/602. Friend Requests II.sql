WITH FriendCounts AS (
    SELECT 
        user_id,
        COUNT(*) AS num_friends
    FROM (
        SELECT requester_id AS user_id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS user_id FROM RequestAccepted
    ) AS AllFriends
    GROUP BY user_id
)
SELECT 
    user_id AS id,
    num_friends AS num
FROM FriendCounts
WHERE num_friends = (SELECT MAX(num_friends) FROM FriendCounts);