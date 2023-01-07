/*Вопрос 1: Вывести адрес электронной почты, имя и фамилию  всех слушателей рок-музыки.И чтобы список был в алфавитном порядке по адресу электронной почты.*/
SELECT DISTINCT Email,FirstName, LastName
FROM customer
JOIN invoice ON customer.CustomerId = invoice.CustomerId
JOIN invoiceline ON invoice.InvoiceId = invoiceline.InvoiceId
WHERE TrackId IN(
	SELECT TrackId FROM track
	JOIN genre ON track.GenreId = genre.GenreId
	WHERE genre.Name LIKE 'Rock'
)
ORDER BY email