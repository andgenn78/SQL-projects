/*Вопрос 2: Кто пишет рок-музыку?*/
SELECT artist.ArtistId, artist.Name,COUNT(artist.ArtistId) AS number_of_songs
FROM track
JOIN album ON album.AlbumId = track.AlbumId
JOIN artist ON artist.ArtistId = album.AlbumId
JOIN genre ON genre.GenreId = track.GenreId
WHERE genre.Name LIKE 'Rock'
GROUP BY artist.ArtistId
ORDER BY number_of_songs DESC
LIMIT 10;