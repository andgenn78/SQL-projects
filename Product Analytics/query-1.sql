-- Query 1
create flex table query_one();
copy query_one from '\data\query_one.csv' parser fcsvparser();
select * from query_one; -- doesn't work
select maptostring(__raw__) from query_one;

--drop table query_one;
create table query_one(
	user_id bigint,
	page varchar(255),
	unix_timestamp bigint
);

copy public.query_one from '\data\query_one.csv' parser fcsvparser();

select * from public.query_one;

-- answer to question
-- for each user_id, find the difference between the last and the second last action
with _staging_query as (
	SELECT 
		user_id,
		page,
		unix_timestamp,
		ROW_NUMBER() over (PARTITION by user_id order by unix_timestamp desc) as rnk
	from 
		public.query_one
)
select
	q1.user_id,
	TIMESTAMPDIFF (second, timestamp 'epoch' + q1.unix_timestamp * interval '1 second',
			 		timestamp 'epoch' + q2.unix_timestamp * interval '1 second') as difference
from _staging_query q1
	left join _staging_query q2
	 on q1.user_id = q2.user_id
	 	and q1.rnk = q2.rnk + 1
	where difference is not null
	order by difference desc;
