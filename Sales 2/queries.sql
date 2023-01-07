drop database supermarket;
create database supermarket;
use supermarket;

create table if not exists aisle (
id                       int(11),
aisle               varchar(100),
primary key (id)
);
INSERT INTO aisle VALUES 
 ('2','energy granola bars'), 
 ('3','instant foods'), 
 ('4','marinades meat preparation'), 
 ('5','raw food');

select * from aisle limit 5;

create table if not exists product (
id                       int(11),
name               varchar(200),
aisle_id               int(11),
department_id               int(11),
primary key (id)
);
INSERT INTO product VALUES 
 ('1','Chocolate Sandwich Cookies','1','1'), 
 ('2','All-Seasons Salt','2','2'), 
 ('3','Robust Golden Unsweetened Oolong Tea','3','3'), 
 ('4','Smart Ones Classic Favorites Mini Rigatoni Wit...','4','5'), 
 ('5','Green Chile Anytime Sauce','5','4'), 
 ('6','Dry Nose Oil','1','5'), 
 ('7','Pure Coconut Water With Orange','2','4'), 
 ('8','Cut Russet Potatoes Steam N'' Mash','3','3'), 
 ('9','Light Strawberry Blueberry Yogurt','4','2'), 
 ('10','Sparkling Orange Juice & Prickly Pear Beverage','5','1'), 
 ('11','Peach Mango Juice','1','1'), 
 ('12','Chocolate Fudge Layer Cake','2','1'), 
 ('13','Saline Nasal Mist','3','2'), 
 ('14','Fresh Scent Dishwasher Cleaner','4','2'), 
 ('15','Overnight Diapers Size 6','5','3'), 
 ('16','Mint Chocolate Flavored Syrup','2','3'), 
 ('17','Rendered Duck Fat','2','4'), 
 ('18','Pizza for One Suprema Frozen Pizza','2','4'), 
 ('19','Gluten Free Quinoa Three Cheese & Mushroom Blend','2','5'), 
 ('20','Pomegranate Cranberry & Aloe Vera Enrich Drink','2','5'), 
 ('21','Red Lentil Dahl Soup','3','5'), 
 ('22','Spicy Homestyle Guacamole','4','5'), 
 ('23','Organic Classic Gazpacho Chilled Vegetable Soup','5','4'), 
 ('24','Jamaican Jerk Hemp Seed Salad','1','4'), 
 ('25','BBQ Chopped Salad','2','4');
select * from product limit 5;

create table if not exists order_product (
order_id                       int(11),
product_id               int(11),
add_to_cart_order               int(11),
reordered               int(11)
);
INSERT INTO order_product VALUES 
 ('6','18','1','1'), 
 ('11','1','9','1'), 
 ('44','25','4','1'), 
 ('43','18','10','0'), 
 ('26','21','3','0'), 
 ('12','10','2','1'), 
 ('19','4','6','1'), 
 ('5','19','2','1'), 
 ('17','9','10','0'), 
 ('9','7','1','0'), 
 ('4','5','10','0'), 
 ('2','25','4','1'), 
 ('11','3','10','1'), 
 ('29','20','8','0'), 
 ('37','1','5','1'), 
 ('30','18','5','1'), 
 ('4','5','3','1'), 
 ('47','18','4','1'), 
 ('10','8','9','1'), 
 ('41','19','7','1'), 
 ('16','22','8','1'), 
 ('5','3','10','0'), 
 ('16','21','6','1'), 
 ('2','14','1','1'), 
 ('13','16','7','0'), 
 ('6','19','8','0'), 
 ('16','8','5','0'), 
 ('29','1','10','1'), 
 ('49','16','2','0'), 
 ('27','5','1','0'), 
 ('47','19','9','1'), 
 ('41','19','7','1'), 
 ('32','3','9','1'), 
 ('24','3','1','1'), 
 ('22','21','2','1'), 
 ('9','21','6','0'), 
 ('29','4','3','0'), 
 ('50','16','4','1'), 
 ('12','11','7','1'), 
 ('44','11','2','0'), 
 ('28','24','4','0'), 
 ('28','5','9','0'), 
 ('29','17','6','0'), 
 ('25','4','3','1'), 
 ('42','13','8','1'), 
 ('9','10','5','0'), 
 ('3','8','5','1'), 
 ('1','15','9','0'), 
 ('46','11','3','0'), 
 ('24','10','2','1'), 
 ('27','3','7','1'), 
 ('38','7','9','0'), 
 ('6','9','5','0'), 
 ('8','22','5','0'), 
 ('16','25','9','0'), 
 ('10','4','8','0'), 
 ('42','5','8','1'), 
 ('35','8','2','1'), 
 ('32','22','9','0');

select * from order_product limit 5;

create table if not exists department (
id                       int(11),
department               varchar(30),
primary key (id)
);
INSERT INTO department VALUES 
 ('1','frozen'), 
 ('2','other'), 
 ('3','bakery'), 
 ('4','produce'), 
 ('5','alcohol');
select * from department limit 5;


create table if not exists orders (
id                       int(11),
user_id                       int(11),
eval_set                       varchar(10),
order_number                       int(11),
order_dow                       int(11),
order_hour_of_day                       int(11),
days_since_prior_order               int(11),
primary key (id)
);
INSERT INTO orders VALUES 
 ('1','27','5','9','20','20','5'), 
 ('2','5','2','8','7','19','5'), 
 ('3','13','1','8','8','9','5'), 
 ('4','18','5','4','8','12','3'), 
 ('5','16','5','10','10','16','3'), 
 ('6','21','4','2','2','5','2'), 
 ('7','34','3','2','3','2','5'), 
 ('8','14','5','12','15','24','5'), 
 ('9','10','3','5','13','8','4'), 
 ('10','24','3','3','5','12','2'), 
 ('11','8','2','4','4','12','5'), 
 ('12','5','3','5','17','24','2'), 
 ('13','14','2','17','14','20','5'), 
 ('14','17','1','7','5','21','5'), 
 ('15','9','1','10','3','4','1'), 
 ('16','12','2','19','9','14','1'), 
 ('17','13','5','12','15','17','5'), 
 ('18','5','1','10','6','8','1'), 
 ('19','27','1','14','6','7','2'), 
 ('20','6','3','13','7','16','4'), 
 ('21','30','2','20','16','7','1'), 
 ('22','27','5','11','20','2','5'), 
 ('23','16','4','4','16','23','2'), 
 ('24','4','2','6','8','24','3'), 
 ('25','4','2','12','4','4','2'), 
 ('26','14','5','18','6','10','5'), 
 ('27','2','5','20','20','22','2'), 
 ('28','15','3','6','16','1','4'), 
 ('29','30','2','4','15','19','3'), 
 ('30','16','2','10','4','12','4'), 
 ('31','22','3','13','18','4','1'), 
 ('32','27','1','5','19','8','4'), 
 ('33','17','1','16','9','10','4'), 
 ('34','34','5','3','11','11','3'), 
 ('35','21','2','20','18','12','3'), 
 ('36','27','2','3','20','16','1'), 
 ('37','13','4','18','19','12','2'), 
 ('38','14','4','11','12','22','1'), 
 ('39','34','5','9','5','8','5'), 
 ('40','14','3','16','4','16','4'), 
 ('41','22','4','19','19','5','2'), 
 ('42','7','3','7','14','5','3'), 
 ('43','19','3','17','10','11','1'), 
 ('44','35','3','8','9','6','4'), 
 ('45','21','5','11','3','22','3'), 
 ('46','32','2','10','11','4','2'), 
 ('47','5','5','8','11','14','2'), 
 ('48','1','1','16','13','13','2'), 
 ('49','35','2','5','12','9','1'), 
 ('50','24','3','9','16','8','1');

select * from orders limit 5;


/*
2.
Selecting top 10 product sales for each day in the week
Including product_id, product_name, total order amount, and day
*/


/*
Hive
use jason_supermarket;
select * 
from (select *, rank() over(partition by day order by sales desc) as rank
from (select product_id, count(orders.id) AS sales,orders.order_dow as day 
	  from order_product
	  join orders
	  where order_product.order_id = orders.id
	  group by product_id, order_dow) as dow_table1) as dow_table2
where rank <= 10;
*/

select product_id, product_name, sales, day
from(
select *,
@day_rank :=if(@dow = day, @day_rank+1, 1) as day_rank,
@dow := day
from(select p.id as product_id, p.name as product_name, count(o.id) as sales, o.order_dow as day
from product as p join order_product as op join orders as o
on p.id = op.product_id and op.order_id = o.id
group by p.id, o.order_dow
order by o.order_dow asc, count(o.id) desc) as dow_table) as dow_table2
where day_rank <=10;


/*
3.
Write a query to display the 5 most popular products in each aisle
from Monday to Friday. Listing product_id, aisle, and day in the week.
*/

/*
Hive:
use jason_supermarket;
select product_id, aisle, day, sales 
from (select *, rank() over(partition by day, aisle order by sales desc) as rank
from (select product_id, count(orders.id) as sales, aisle, orders.order_dow as day
from order_product join orders join product join aisle
on order_product.order_id = orders.id and order_product.product_id = product.id and product.aisle_id = aisle.id
group by product_id, order_dow, aisle) as aisle_table1) as aisle_table2
where rank <= 5 and day not in (0,6);
*/


select aisle, day, product_id
from(
select *,
@rank := If(@aisle_num = aisle_id and @dow = day, @rank + 1, 1) as rank1,
@aisle_num := aisle_id,
@dow := day
from
(select p.id as product_id, a.id as aisle_id, a.aisle as aisle, count(o.id) as sales, o.order_dow as day
from order_product as op join orders as o join product as p join aisle as a
on op.order_id = o.id and op.product_id = p.id and p.aisle_id = a.id
group by p.id, o.order_dow,a.id
order by a.id asc, o.order_dow asc, count(o.id) desc) as aisle_table) as aisle_table2
where rank1 <=5 and day not in (0,6);

/*
4.
Query to select the top 10 products that the users have the most frequent
reorder rate. Only need to give the results with product id.
*/

/*
Hive: 
use jason_supermarket;
select op.product_id, sum(op.reordered)/count(op.order_id) as reorder_rate
from order_product as op
group by op.product_id
order by reorder_rate desc
limit 10;
*/

select op.product_id, sum(op.reordered)/count(op.order_id)
from order_product as op
group by op.product_id
order by sum(op.reordered)/count(op.order_id) desc
limit 10;


/*
5. 
*/
-- Part 1. Please list order id and all unique aisle id in the order.

/*
Hive
use jason_supermarket;
select distinct add_to_cart_order, aisle_id, order_id from 
(select * from order_product as op
join product as p where op.product_id = p.id
order by order_id, aisle_id) as table_1
order by order_id, add_to_cart_order;
*/

create table if not exists order_report1 as 
(select * from order_product as op
join product as p
where op.product_id = p.id
order by order_id, aisle_id);
select* from order_report2

create table if not exists order_report2 as 
(select distinct add_to_cart_order, aisle_id, order_id from order_report1 
order by order_id, add_to_cart_order);
select* from order_report2
-- Part 2. Find the most popular shopping path.

/*
Hive:
use jason_supermarket;
select path, count(*) as path_count
from (select order_id, collect_set(aisle) as path
from(select distinct order_id, aisle_id, aisle from order_product
join product join aisle where order_product.product_id = product.id and product.aisle_id = aisle.id 
order by order_id, aisle_id) as table1 group by order_id) as table2
group by path
order by path_count desc;
*/

select path, count(path) as path_count from
(select order_id, GROUP_CONCAT(aisle_id SEPARATOR ' ') as path
from order_report2
group by order_id) as path_temp
group by path
order by path_count desc;

/*
6. Find the pair of items that is most frequently bought together.
*/

/*
Hive:
use jason_supermarket;
select product_1, product_2, count(*) as count
from (select distinct pair1.order_id, pair1.product_id as product_1,
	pair2.product_id as product_2
from (select * from order_product order by order_id, product_id) as pair1
join (select * from order_product order by order_id, product_id desc) AS pair2
where pair1.order_id = pair2.order_id
and pair1.product_id <> pair2.product_id) as pairs
group by product_1, product_2
order by count desc
limit 20;
*/

create table if not exists pairs as(
select pair1.order_id as order_id, pair1.product_id as product_1, pair2.product_id as product_2 from
(select distinct order_id, product_id from order_product order by order_id, product_id asc) as pair1
join
(select distinct order_id, product_id from order_product order by order_id, product_id desc) as pair2
where pair1.order_id = pair2.order_id
and pair1.product_id <> pair2.product_id);

select pair, count(pair) from  
(select *, concat(product_1, " ", product_2) as pair from pairs) as temp
group by pair
order by count(pair) desc;