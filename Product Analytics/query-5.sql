-- average and median transactions performed by the user on the sign up date

create table users(
	user_id bigint,
	sign_up_date date
);

create table transactions(
	user_id bigint,
	transaction_date timestamp,
	transaction_amount int
);

copy public.users from '/home/server/Documents/product-ds/query_five/query_five_users.csv' parser fcsvparser();
copy public.transactions from '/home/server/Documents/product-ds/query_five/query_five_transactions.csv' parser fcsvparser();

-- average transaction on signup date
with agg_table as (
	SELECT 
		u.user_id as user_id,
		u.sign_up_date as signup_date,
		t.transaction_date as transaction_date,
		t.transaction_amount as transaction_amount,
		ROW_NUMBER() over (order by transaction_amount) as rnk
	from
		users u
		left join transactions t
		on u.user_id = t.user_id
		where
			u.sign_up_date = date(t.transaction_date)
),
	med_tr as (
	select
		median(a.transaction_amount) over () as median_transactions,
		avg(a.transaction_amount) over() as average_transactions
	from
		agg_table a
	limit 1
) 
select * from med_tr;






	
	