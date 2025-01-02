WITH FirstOrders AS (
    SELECT customer_id,MIN(order_date) AS first_order_date
    FROM delivery
    GROUP BY customer_id
),
ImmediateOrders AS (
    SELECT d.customer_id
    FROM delivery d
    JOIN FirstOrders fo
    ON d.customer_id=fo.customer_id AND d.order_date=fo.first_order_date
    WHERE d.customer_pref_delivery_date=d.order_date
)
SELECT ROUND(COUNT(DISTINCT io.customer_id)*100.0/COUNT(DISTINCT fo.customer_id),2) AS immediate_percentage
FROM FirstOrders fo
LEFT JOIN ImmediateOrders io
ON FO.customer_id=IO.customer_id;