/* Вопрос 2: В каком городе самые лучшие клиенты?*/
SELECT BillingCity,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY BillingCity
ORDER BY InvoiceTotal DESC
LIMIT 1;