/* Вопрос 1: В каких странах больше всего счетов?*/
SELECT BillingCountry,COUNT(BillingCountry) AS Invoice_Number
FROM Invoice
GROUP BY BillingCountry
ORDER BY Invoice_Number DESC;