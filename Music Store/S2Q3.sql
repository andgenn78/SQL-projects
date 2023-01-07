/*Вопрос 3: Самый продоваймый артист и клиент, потративший на него большее количество средств*/
WITH tbl_best_selling_artist AS(
	SELECT artist.ArtistId AS artist_id,artist.name AS artist_name,SUM(invoiceline.UnitPrice*invoiceline.Quantity) AS total_sales
	FROM invoiceline
	JOIN track ON track.TrackId = invoiceline.TrackId
	JOIN album ON album.AlbumId = track.AlbumId
	JOIN artist ON artist.ArtistId = album.AlbumId
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)

SELECT bsa.artist_name,SUM(il.UnitPrice*il.Quantity) AS amount_spent,c.CustomerId,c.FirstName,c.LastName
FROM invoice i
JOIN customer c ON c.CustomerId = i.CustomerId
JOIN invoiceline il ON il.InvoiceId = i.InvoiceId
JOIN track t ON t.TrackId = il.TrackId
JOIN album alb ON alb.AlbumId = t.AlbumId
JOIN tbl_best_selling_artist bsa ON bsa.artist_id = alb.ArtistId
GROUP BY 1,3,4,5
ORDER BY 2 DESC;