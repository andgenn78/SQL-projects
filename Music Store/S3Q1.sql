/*Вопрос 1: сСамый популярный музыкальный жанр для каждой страны*/
/*продажи в каждой стране*/
CREATE TABLE IF NOT EXISTS tbl_sales_per_country AS
SELECT COUNT(*) AS purchases_per_genre, customer.Country, genre.Name, genre.GenreId
FROM invoiceline
JOIN invoice ON invoice.InvoiceId = invoiceline.InvoiceId
JOIN customer ON customer.CustomerId = invoice.CustomerId
JOIN track ON track.TrackId = invoiceline.TrackId
JOIN genre ON genre.GenreId = track.GenreId
GROUP BY 2,3,4
ORDER BY 2;

/*самый популярный жанр в каждой стране */
CREATE TABLE IF NOT EXISTS tbl_max_genre_per_country AS
SELECT MAX(purchases_per_genre) AS max_genre_number, country
FROM tbl_sales_per_country
GROUP BY 2
ORDER BY 2;

/*** Финал ***/
SELECT tbl_sales_per_country.* 
FROM tbl_sales_per_country
JOIN tbl_max_genre_per_country ON tbl_sales_per_country.country = tbl_max_genre_per_country.country
WHERE tbl_sales_per_country.purchases_per_genre = tbl_max_genre_per_country.max_genre_number;