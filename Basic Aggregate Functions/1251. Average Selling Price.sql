SELECT p.product_id,ROUND(COALESCE(SUM(p.price * u.units),0)/
CASE
WHEN SUM(u.units) IS NULL OR SUM(u.units)=0 THEN 1
ELSE SUM(u.units)
END
,2)AS average_price
FROM prices p
LEFT JOIN unitssold u
ON p.product_id=u.product_id
AND u.purchase_date BETWEEN start_date AND end_date
GROUP BY p.product_id;