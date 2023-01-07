-- create 2 tables
-- mobile and web visitors
create table mobile(
	user_id bigint,
	page varchar(255)
);

create table web(
	user_id bigint,
	page varchar(255)
);

copy public.mobile from '/home/server/Documents/product-ds/query_two/query_two_mobile.csv' parser fcsvparser();
copy public.web from '/home/server/Documents/product-ds/query_two/query_two_web.csv' parser fcsvparser();

-- answer to question 2
with _m as(
	SELECT 
		count(distinct m.user_id) as user_id
	from
		mobile m
		left outer join
		web w  on m.user_id = w.user_id	
),
	_w as (
	SELECT 
		count(distinct w.user_id) as user_id
	from
		web w
		left outer join
		mobile m on w.user_id = m.user_id
),
	_c as (
	SELECT 
		count(distinct m.user_id) as user_id
	from
		mobile m 
		inner join
		web w on m.user_id = w.user_id 
),
	_tot as (
	SELECT 
		_m.user_id + _w.user_id + _c.user_id as total
	from
		_m, _w, _c
)

SELECT 
	_m.user_id / _tot.total * 100 as mobile,
	_w.user_id / _tot.total * 100 as web,
	_c.user_id / _tot.total * 100 as total
from
	_m, _w, _c, _tot;
	

-- alternate solution
SELECT 100*SUM(CASE WHEN m.user_id IS null THEN 1 ELSE 0 END)/COUNT(*) as WEB_ONLY, 
 100*SUM(CASE WHEN w.user_id IS null THEN 1 ELSE 0 END)/COUNT(*) as MOBILE_ONLY, 
 100*SUM(CASE WHEN m.user_id IS NOT null AND w.user_id IS NOT null THEN 1 ELSE 0 END)/COUNT(*) as BOTH 
FROM 
(SELECT distinct user_id FROM web ) w 
FULL OUTER JOIN 
(SELECT distinct user_id FROM mobile ) m 
ON m.user_id = w.user_id;
	
	
	
	
	
	