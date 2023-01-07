-- country based user analysis

create table users_country(
	user_id bigint,
	created_at timestamp,
	country varchar(255)
);

copy public.users_country from '/home/server/Documents/product-ds/query_six.csv' parser fcsvparser();

select * from users_country;

-- country with the smallest and largest number of users
SELECT 
	country,
	count(distinct user_id) as n
from 
	users_country
group by country
order by n desc; -- China and Vietnam

select
	(select country from users_country group by country order by count(distinct user_id) desc limit 1) as highest_users,
	(select country from users_country group by country order by count(distinct user_id) limit 1 ) as lowest_users
from
	users_country
limit 1;


-- for every country, first and last user who signed up
with _staging_country as (
	SELECT 
		country,
		user_id,
		created_at,
		first_value(user_id) over (partition by country order by created_at desc rows between unbounded PRECEDING and UNBOUNDED FOLLOWING) as first_user,
		last_value(user_id) over (partition by country order by created_at desc rows between unbounded PRECEDING and UNBOUNDED FOLLOWING) as last_user
	from
		users_country
	group by
		country, user_id, created_at
)
SELECT 
	country,
	max(first_user),
	max(last_user)
from
	_staging_country
group by country;
	





