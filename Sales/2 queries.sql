SELECT top 10 * FROM store_sales


SELECT top 10 *
FROM store_sales
ORDER BY revenue DESC

SELECT AVG(revenue)
FROM store_sales;

SELECT 
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY revenue)
	OVER () AS pct_50_revenue
FROM store_sales;


SELECT
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY revenue) OVER () AS pct_50_revenues,
	PERCENTILE_DISC(0.6) WITHIN GROUP(ORDER BY revenue) OVER () AS pct_60_revenues,
	PERCENTILE_DISC(0.9) WITHIN GROUP(ORDER BY revenue) OVER () AS pct_90_revenues,
	PERCENTILE_DISC(0.95) WITHIN GROUP(ORDER BY revenue) OVER () AS pct_95_revenues
FROM store_sales;


SELECT 
	PERCENTILE_CONT(0.95) WITHIN GROUP(ORDER BY revenue) OVER () AS pct_95_cont_revenues,
	PERCENTILE_DISC(0.95) WITHIN GROUP(ORDER BY revenue) OVER () AS pct_95_disc_revenues
FROM store_sales;