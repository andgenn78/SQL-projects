-- power users question

create table purchases(
	user_id bigint,
	eventdate timestamp
);

copy public.purchases from '/home/server/Documents/product-ds/query_three.csv' parser fcsvparser();

-- user_id, date: 10th time they purchased and converted into a power user
with _purch  as (
	SELECT
		user_id,
		eventdate,
		row_number() over (PARTITION by user_id order by eventdate asc) as rnk
	from
		purchases		
)
select
	user_id,
	eventdate,
	rnk
from
	_purch
where rnk = 10;