SELECT (Avg(units_sold * revenue) - (Avg(units_sold) * Avg(revenue))) 
/ (StDevP(units_sold) * StDevP(revenue)) as corr
FROM store_sales;


SELECT
(Avg(units_sold * employee_shifts) - (Avg(units_sold) * Avg(employee_shifts))) 
/ (StDevP(units_sold) * StDevP(employee_shifts)) as corr
FROM store_sales;


SELECT 
(Avg(units_sold * month_of_year) - (Avg(units_sold) * Avg(month_of_year))) 
/ (StDevP(units_sold) * StDevP(month_of_year)) as corr
FROM store_sales;

SELECT
	ROW_NUMBER() OVER(ORDER BY units_sold),
	sale_date,
	month_of_year,
	units_sold
FROM store_sales;

SELECT
	ROW_NUMBER() OVER(ORDER BY units_sold),
	sale_date,
	month_of_year,
	units_sold
FROM store_sales
ORDER BY month_of_year;

SELECT 
	month_of_year,
	AVG(employee_shifts) as employee_shifts
FROM store_sales
GROUP BY month_of_year;