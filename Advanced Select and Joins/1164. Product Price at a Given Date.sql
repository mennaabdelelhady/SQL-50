SELECT 
    p1.product_id,
    COALESCE(p2.new_price, 10) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) p1
LEFT JOIN 
    (SELECT 
         product_id, 
         new_price,
         ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rn
     FROM 
         Products
     WHERE 
         change_date <= '2019-08-16') p2
ON 
    p1.product_id = p2.product_id AND p2.rn = 1
ORDER BY 
    p1.product_id;