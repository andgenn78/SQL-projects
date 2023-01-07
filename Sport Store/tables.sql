create table info 
(
product_name varchar(100),
product_id varchar(50),
description varchar(500)
);
create table finance 
(
product_id varchar(50),
listing_price float,
sale_price float,
discount float
);
create table reviews 
(
product_name varchar(100),
product_id varchar(50),
rating float,
reviews float
);
create table traffic
(
product_id varchar(50),
last_visited varchar(50)
);
create table brands
(
product_id varchar(50),
brand varchar(50)
);