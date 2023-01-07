WITH
orders_q2_q4 as (
	select * from [dbo].[orders_q2]
	union
	select * from [dbo].[orders_q4]
)

select * into orders_q2_q4  from orders_q2_q4
--Создание обобщенной таблицы 2.2.1
WITH
totalsales_revenue2 as(
	select 
		DATEPART(q, orderDate) as quarterr,
		sum(quantity) as total_sales,
		sum(quantity*priceeach) as revenue
	from orders_q2_q4
	where
		status = 'shipped' and
		(DATEPART(q, orderDate) = 2 
		or 
		DATEPART(q, orderDate) = 4)
	group by datepart(q, orderDate)
)
--select * from totalsales_revenue2;
select 
	quarterr,
	total_sales,
	((total_sales*100)/
	LAG(total_sales) OVER(ORDER BY quarterr ASC)) - 100
		as sales_growth,
	revenue,
	((revenue*100)/
	LAG(revenue) OVER(ORDER BY quarterr ASC)) - 100
		as revenue_growth
from totalsales_revenue2


with
total_customer as(
	select
		DATEPART(q, createDate) as quarterr,
		count(Distinct customerID) as total_customers
		from
			[dbo].[customer]
		group by DATEPART(q, createDate)
)
select *  into total_customer from total_customer

with
ordered_customer as(
	select
		DATEPART(q, createDate) as quarterr,
		count(Distinct customerID) as ordered_customer
	from
		customer
	where
		customerID in (
			select Distinct customerID
			from orders_q2
			union
			select Distinct customerID
			from orders_q4
		)
	group by DATEPART(q, createDate)
)
select *  from ordered_customer
--select * into ordered_customer from ordered_customer


select
	total. *,
	ordered.ordered_customer,
	(ordered.ordered_customer*100)/
	(total.total_customers)
	as percentage
from
	total_customer total
join
	ordered_customer ordered on total.quarterr = ordered.quarterr

with
summarize_by_category as (
	select
		right(productCode,2) as categoryID,
		count(Distinct orderNumber) as total_order,
		sum(quantity) as total_sales
	from
		orders_q4
	where
		status = 'shipped'
	group by productCode
)
--select * from summarize_by_categorySSS
select 
	categoryID,
	total_order,
	total_order* 100/(select sum(total_order) from summarize_by_category)  as precent_of_total_order,
	total_sales,
	total_sales * 100/(select sum(total_sales) from summarize_by_category) as precent_of_total_sales
from summarize_by_category


select
	count(distinct customerID) as active_customer,
	(select count(distinct customerID) from orders_q2) as total_customer,
	(
		count(distinct customerID)*100
		/(select count(distinct customerID) from orders_q2)
	) as retention_rate,
	(
		100*((select count(distinct customerID) from orders_q2) - count(distinct customerID))
		/(select count(distinct customerID) from orders_q2)
	) as churn_rate
from orders_q2
where
	customerID in (select distinct customerID from orders_q4)

select
	customerID,
	AVG(ABS(DATEDIFF(d,orderDate,shippedDate))) as avgShippedTime
from 
	orders_q2
where
	customerID not in (select distinct customerID from orders_q4)
group by customerID
Having AVG(ABS(DATEDIFF(d,orderDate,shippedDate))) > 3
order by 2 DESC


--
select 
		--QUARTER(orderDate) as quarter,
		DATEPART(q, orderDate) as quarterr,
		quantity,
		quantity*priceeach as revenue
	into totalsales
	from [dbo].[orders_q1_q2]
	where
		status = 'shipped'

select
	quarterr,
		sum(quantity) as total_sales,
		sum(revenue) as revenue

from totalsales
group by quarterr

--

select 
	quarterr,
	total_sales,
	(total_sales - LAG(total_sales) OVER(ORDER BY quarterr ASC))
	/LAG(total_sales) OVER(ORDER BY quarterr ASC)*100
		as sales_growth,
	revenue,
	(revenue - LAG(revenue) OVER(ORDER BY quarterr ASC))
	/LAG(revenue) OVER(ORDER BY quarterr ASC)*100
		as revenue_growth
from totalsales_revenue2