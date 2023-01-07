/*Вопрос 3: Кто лучший клиент?*/
SELECT Customer.CustomerId, FirstName, LastName, SUM(total) AS total_spending
FROM Customer
JOIN invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY (customer.CustomerId)
ORDER BY total_spending DESC
LIMIT 1;
