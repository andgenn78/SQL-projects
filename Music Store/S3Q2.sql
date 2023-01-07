/*Вопрос 2:Вывести названия песен длина  которых превышает среднюю длину*/
SELECT Name,Milliseconds
FROM Track
WHERE Milliseconds > (
	SELECT AVG(Milliseconds) AS avg_track_length
	FROM Track)
ORDER BY Milliseconds DESC;
 
