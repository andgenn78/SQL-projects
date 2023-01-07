-- transactions table

create table transactions_april(
	user_id bigint,
	tr_date date,
	amount int
);

create table transactions_march(
	user_id bigint,
	tr_date date,
	amount int
);

copy public.transactions_march from '/home/server/Documents/product-ds/query_four/query_four_march.csv' parser fcsvparser();
copy public.transactions_april from '/home/server/Documents/product-ds/query_four/query_four_april.csv' parser fcsvparser();

-- part 1: sum of amount spent by each user
select
	user_id,
	sum(amount)
from 
	(
		select tm.user_id, tm.amount from transactions_march tm
		union
		select ta.user_id, ta.amount from transactions_april ta
	) as transactions
group by 1
order by 2 desc;


-- part 2: cumulative sum of amount spent by each user
-- eda
select user_id, count(*) n
from transactions_march
group by user_id
order by n desc;

select * from transactions_march where user_id = 10227;
select user_id, amount, (amount + lag(amount, 1) over (partition by user_id order by tr_date)) as lagged_amount from transactions_march where user_id = 10227;
select user_id, amount, sum(amount) over (partition by user_id order by tr_date rows between unbounded PRECEDING and current row) as cum_sum 
from transactions_march where user_id = 10227;

-- solution
SELECT 
	user_id,
	amount,
	sum(amount)
		over (PARTITION by
					user_id order by tr_date
					rows between UNBOUNDED PRECEDING and CURRENT ROW)
		as cum_sum
FROM
	(
	select user_id, tr_date, amount from transactions_march
	union
	select user_id, tr_date, amount from transactions_april
	) as transactions;









