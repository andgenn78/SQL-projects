-- Создание новой таблицы retail_sales в базе данных 
CREATE table retail_sales(
	sales_month date,
	naics_code varchar,
	kind_of_business varchar,
	reason_for_null varchar,
	sales decimal
);
-- Экспорт таблицы из CSV
COPY retail_sales 
FROM 'C:\us_retail_sales.csv' 
WITH (FORMAT CSV, HEADER);

-- Создание трендов
--- Тенденция годового общего объема розничных продаж и продаж в сфере общественного питания
--- Выбрать только год и показать в новой колонке (where условие) 
SELECT date_part('year', sales_month) AS sales_year,
		sum(sales) AS sales
FROM retail_sales
WHERE kind_of_business = 'Retail and food services sales, total'
GROUP BY 1
ORDER BY 1;

-- Сравнение компонентов
--- Сравните ежегодную тенденцию продаж для нескольких категорий, связанных с досугом.
SELECT date_part('year',sales_month) as sales_year,
		kind_of_business,
		sum(sales) as sales
FROM retail_sales
WHERE kind_of_business in ('Book stores','Sporting goods stores','Hobby, toy, and game stores')
GROUP BY 1,2
ORDER BY 1;

---Годовая динамика продаж в магазинах женской и мужской одежды
SELECT date_part('year',sales_month) as sales_year,
		kind_of_business,
		sum(sales) as sales
FROM retail_sales
WHERE kind_of_business in ('Men''s clothing stores','Women''s clothing stores')
GROUP BY 1,2
ORDER BY 1;

SELECT date_part('year',sales_month) as sales_year,
		sum(case when kind_of_business = 'Women''s clothing stores'
          		then sales
          	end) as womens_sales,
		sum(case when kind_of_business = 'Men''s clothing stores'
          		then sales
          	end) as mens_sales
FROM retail_sales
WHERE kind_of_business in ('Men''s clothing stores','Women''s clothing stores')
GROUP BY 1
ORDER BY 1;

--- Годовое соотношение продаж женской и мужской одежды
--- round - округление до 2х десятичных знаков
SELECT sales_year,
	   round(womens_sales / mens_sales,2) as womens_times_of_mens
FROM (

	SELECT date_part('year',sales_month) as sales_year,
		sum(case when kind_of_business = 'Women''s clothing stores'
          		then sales
          	end) as womens_sales,
		sum(case when kind_of_business = 'Men''s clothing stores'
          		then sales
          	end) as mens_sales
	FROM retail_sales
	WHERE kind_of_business in ('Men''s clothing stores','Women''s clothing stores')
	GROUP BY 1
	ORDER BY 1
) a ;

--- Продажи магазинов мужской и женской одежды в процентах от месячной суммы
SELECT 	sales_month, 
		kind_of_business, 
		sales,
		sum(sales) over (partition by sales_month) as total_sales,
		round(sales * 100 / sum(sales) over (partition by sales_month),2) as pct_total
FROM retail_sales
WHERE kind_of_business in ('Men''s clothing stores','Women''s clothing stores')
ORDER BY 1;

--- Процент годового объема продаж женской и мужской одежды за 2019 г.
SELECT 	sales_month, 
		kind_of_business,
		sales,
		sum(sales) over (partition by date_part('year',sales_month),kind_of_business) as yearly_sales,
		round(sales * 100 /sum(sales) over (partition by date_part('year',sales_month),kind_of_business), 2) as pct_yearly
FROM retail_sales
WHERE kind_of_business in ('Men''s clothing stores','Women''s clothing stores')
ORDER BY 1,2;

--Индексирование данных временных рядов
--- Продажи в магазинах мужской и женской одежды, индексированные по продажам в 1992 г.
SELECT sales_year, kind_of_business, sales,
		round((sales / first_value(sales) over (partition by kind_of_business order by sales_year) - 1) * 100, 2) as pct_from_index
FROM
(
    SELECT date_part('year',sales_month) as sales_year,
			kind_of_business,
			sum(sales) as sales
    FROM retail_sales
    WHERE kind_of_business in ('Men''s clothing stores','Women''s clothing stores')
    GROUP BY 1,2
	ORDER BY 1
) a
;

-- Расчет скользящих временных окон
--- 12-месячное скользящее среднее продаж для магазинов женской одежды
SELECT 	sales_month,
		round(avg(sales) over (order by sales_month rows between 11 preceding and current row), 2) as moving_avg,
		count(sales) over (order by sales_month rows between 11 preceding and current row
                  ) as records_count
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores';

--- 12-месячная скользящая средняя продаж для магазинов мужской одежды
SELECT a.sales_month, round(avg(b.sales),2) as moving_avg,
		count(b.sales) as records_count
FROM
(
    SELECT distinct sales_month
    FROM retail_sales
    WHERE sales_month between '1992-01-01' and '2020-12-01'
) a
JOIN retail_sales b 
ON b.sales_month between a.sales_month - interval '11 months' and a.sales_month
 AND b.kind_of_business = 'Men''s clothing stores'
GROUP BY 1
ORDER BY 1;

-- Расчет кумулятивных значений
--- Общий объем продаж с начала года по состоянию на каждый месяц
SELECT 	sales_month, 
		sales,
		sum(sales) over (partition by date_part('year',sales_month) order by sales_month) as sales_ytd
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores';


-- Анализ с учетом сезонности, сравнение периодов
--- Рассчитать рост за месяц
SELECT 	kind_of_business, 
		sales_month, 
		sales,
		round((sales / lag(sales) over (partition by kind_of_business order by sales_month) - 1) * 100, 2) as pct_growth_from_previous
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores';

--- Рассчитать годовой рост
SELECT 	sales_year, 
		yearly_sales,
		lag(yearly_sales) over (order by sales_year) as prev_year_sales,
		round((yearly_sales / lag(yearly_sales) over (order by sales_year) -1) * 100, 2) as pct_growth_from_previous
FROM
(
    SELECT 	date_part('year',sales_month) as sales_year,
			sum(sales) as yearly_sales
    FROM retail_sales
    WHERE kind_of_business = 'Women''s clothing stores'
    GROUP BY 1
) a
;

--- Сравнение того же месяца и прошлого года
SELECT 	sales_month, 
		sales,
		sales - lag(sales) over (partition by date_part('month',sales_month) order by sales_month) as absolute_diff,
		round((sales / lag(sales) over (partition by date_part('month',sales_month) order by sales_month) - 1) * 100,2) as pct_diff
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores';


SELECT 	date_part('month',sales_month) as month_number,
		to_char(sales_month,'Month') as month_name,
		max(case when date_part('year',sales_month) = 2018 then sales end) as sales_2018,
		max(case when date_part('year',sales_month) = 2019 then sales end) as sales_2019,
		max(case when date_part('year',sales_month) = 2020 then sales end) as sales_2020
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores'
 	and sales_month between '2018-01-01' and '2020-12-01'
GROUP BY 1,2;


--- Сравнение с несколькими предыдущими периодами
SELECT 	sales_month, sales,
		round(sales / avg(sales) over (partition by date_part('month',sales_month) order by sales_month rows between 3 preceding and 1 preceding),2) as pct_of_prev_3
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores';

