CREATE TABLE IF NOT EXISTS tbl_customter_with_country AS
		SELECT customer.CustomerId,FirstName,LastName,BillingCountry,SUM(total) AS total_spending
		FROM invoice
		JOIN customer ON customer.CustomerId = invoice.CustomerId 
		GROUP BY 1,2,3,4
		ORDER BY 2,3 DESC;

	CREATE TABLE IF NOT EXISTS tbl_country_max_spending AS
		SELECT BillingCountry,MAX(total_spending) AS max_spending
		FROM tbl_customter_with_country
		GROUP BY BillingCountry;

SELECT tbl_cc.BillingCountry, tbl_cc.total_spending,tbl_cc.FirstName,tbl_cc.LastName,tbl_cc.CustomerId
FROM tbl_customter_with_country tbl_cc
JOIN tbl_country_max_spending tbl_ms
ON tbl_cc.BillingCountry = tbl_ms.BillingCountry
WHERE tbl_cc.total_spending = tbl_ms.max_spending 
ORDER BY 1;
