Select COUNT(*) AS total_rows, 
COUNT(description) AS count_description,
COUNT(listing_price) AS count_listing_price, 
COUNT(last_visited) AS count_last_visited
    FROM info AS i
JOIN finance AS f 
    ON i.product_id=f.product_id
JOIN traffic AS t
    ON i.product_id=t.product_id;
SELECT brand, 
COUNT(f.product_id)
    FROM brands AS b
INNER JOIN finance as f
    ON b.product_id=f.product_id
WHERE listing_price>0
    GROUP BY brand, listing_price
    ORDER BY listing_price DESC;
SELECT brand, 
COUNT(f.product_id), 
CASE WHEN listing_price<42 
    then 'Budget'
WHEN listing_price BETWEEN 42 AND 73
    then 'Average'
WHEN listing_price BETWEEN 74 AND 128
    then 'Expensive'
WHEN listing_price>=129 
    then 'Elite'
    end AS price_category
FROM brands AS b
JOIN finance AS f
    ON b.product_id=f.product_id
WHERE brand IS NOT NULL
    GROUP BY brand, price_category;
SELECT brand, 
AVG(discount)*100 AS average_discount
    FROM brands AS b
INNER JOIN finance AS f
    ON b.product_id=f.product_id
WHERE brand IS NOT NULL
GROUP BY brand;
SELECT brand, 
EXTRACT(MONTH FROM last_visited) AS month,
COUNT(r.product_id) AS num_reviews
    FROM brands as b
JOIN reviews AS r
    ON b.product_id=r.product_id
JOIN traffic AS t
    ON r.product_id=t.product_id
WHERE (brand IS NOT NULL AND EXTRACT(MONTH FROM last_visited) IS NOT NULL)
    GROUP BY brand, month
    ORDER BY brand, month