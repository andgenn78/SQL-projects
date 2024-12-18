use grocery_data;

create table grocery_table
(member_number int not null,
createDate Date not null,
itemDescription varchar(25) not null);

insert into grocery_table
(member_number, createDate, itemDescription) values
('4313','2014-07-17','newspapers'), 
 ('1618','2014-10-30','napkins'), 
 ('3834','2014-03-21','chocolate marshmallow'),
 ('4493','2014-11-29','margarine'), 
 ('2843','2014-06-06','rolls buns'), 
 ('1754','2014-04-20','cream cheese '), 
 ('2107','2014-10-30','canned beer'), 
 ('4157','2014-04-01','frozen meals'),
 ('2714','2015-03-14','yogurt'), 
('2769','2015-07-21','sparkling wine'), 
('4166','2015-04-30','bottled water'), 
('3614','2015-03-02','citrus fruit'), 
('4361','2015-09-25','hamburger meat'), 
('1922','2015-09-22','packaged fruit vegetables'), 
('4728','2015-09-26','other vegetables'), 
('3646','2015-08-08','soda'), 
('1155','2015-08-10','whole milk'), 
('2119','2015-01-16','herbs'), 
('1602','2015-08-29','citrus fruit'), 
('1074','2015-06-24','misc. beverages'), 
('2256','2015-04-11','female sanitary products'),
('2029','2014-07-15','cake bar'), 
 ('1122','2014-09-25','dishes'), 
 ('2993','2014-06-24','shopping bags'), 
 ('4938','2014-10-13','mayonnaise'), 
 ('2753','2014-07-07','butter'), 
 ('3450','2014-03-04','soda'), 
 ('4745','2014-08-14','pastry'), 
 ('2520','2014-12-18','other vegetables'), 
 ('1260','2014-07-09','curd'), 
 ('4121','2014-04-21','other vegetables'), 
 ('3145','2014-08-16','candy'), 
 ('3479','2014-05-10','pastry'), 
 ('1166','2014-02-17','brown bread'), 
 ('3021','2014-06-22','onions'), 
 ('2489','2014-02-06','rolls buns'), 
 ('3343','2014-06-16','rolls buns'), 
 ('3028','2014-01-04','butter'), 
 ('4866','2014-06-29','soda'), 
 ('4943','2014-05-01','other vegetables'), 
 ('1636','2014-08-08','liquor (appetizer)'), 
 ('3593','2014-09-21','rolls buns'), 
 ('2835','2014-07-23','cream cheese '), 
 ('1383','2014-03-24','whipped sour cream'), 
 ('2545','2014-05-26','whole milk'), 
 ('4719','2014-09-28','coffee'), 
 ('2065','2014-07-20','pastry'), 
 ('2941','2014-06-13','beverages'), 
 ('4430','2014-05-21','cream cheese '), 
 ('4019','2014-05-18','bottled water'), 
 ('1407','2014-09-10','domestic eggs'), 
 ('2960','2014-09-03','canned beer'), 
 ('1343','2014-02-07','other vegetables'), 
 ('4715','2014-01-31','softener'), 
 ('3174','2014-11-10','butter milk'), 
 ('1623','2014-12-07','rolls buns'), 
 ('2506','2014-02-27','chocolate'), 
 ('4799','2014-04-01','frozen fish'), 
 ('2360','2014-07-09','napkins'), 
 ('4822','2014-08-21','coffee'), 
 ('1554','2014-02-04','curd'), 
 ('1867','2014-03-18','frozen vegetables'), 
 ('2148','2014-11-20','domestic eggs'), 
 ('3863','2014-07-19','whipped sour cream'), 
 ('1010','2014-08-23','specialty bar'), 
 ('2768','2014-05-05','baking powder'), 
 ('2218','2014-11-06','pot plants'), 
 ('3785','2014-08-16','frozen fish'), 
 ('4823','2014-01-05','frozen meals'), 
 ('1475','2014-03-05','kitchen towels'), 
 ('1052','2014-01-15','grapes'), 
 ('2565','2014-09-16','jam'), 
 ('4259','2014-07-23','yogurt'), 
 ('1061','2014-07-30','hard cheese'), 
 ('4001','2014-06-11','soda'), 
 ('1620','2014-07-21','cream cheese '), 
 ('3458','2014-06-28','mustard'), 
 ('2178','2014-10-11','male cosmetics'), 
 ('1995','2014-06-14','yogurt'), 
 ('2161','2014-09-24','margarine'), 
 ('3349','2014-07-12','herbs'), 
 ('3742','2014-09-26','shopping bags'), 
 ('1244','2014-11-24','soda'), 
 ('3609','2014-05-13','rolls buns'), 
 ('2375','2014-03-31','dog food'), 
 ('2974','2014-05-24','frozen vegetables'), 
 ('3030','2014-12-06','whole milk'), 
 ('3737','2014-12-22','other vegetables'), 
 ('3619','2014-03-13','dessert'), 
 ('3705','2014-02-28','herbs'), 
 ('3974','2014-08-25','bottled water'), 
 ('1798','2014-10-06','hamburger meat'), 
 ('3272','2014-04-18','canned beer'),
 ('4272','2015-06-06','coffee'), 
('1120','2015-09-26','pastry'),
('2676','2015-08-15','rolls buns'), 
('1697','2015-05-21','misc. beverages'), 
('2507','2015-08-25','root vegetables'), 
('4620','2015-03-11','sausage'), 
('3365','2015-02-01','canned beer'), 
('2978','2015-06-05','ham'), 
('2910','2015-07-28','turkey'), 
('1061','2015-09-25','whole milk'), 
('3276','2015-04-03','whole milk'), 
('1326','2015-06-19','packaged fruit vegetables'), 
('3023','2015-07-28','rolls buns'), 
('2185','2015-10-11','ham'), 
('3552','2015-06-16','rolls buns'), 
('1967','2015-01-20','other vegetables'), 
('4708','2015-03-20','sausage'), 
('2874','2015-02-15','sausage'),
('4177','2015-04-13','frankfurter'), 
('1663','2015-02-07','rolls buns'), 
('2632','2015-03-02','whole milk'), 
('1377','2015-03-14','curd cheese'), 
('4162','2015-12-22','red blush wine'), 
('2270','2015-07-01','sausage'), 
('4829','2015-11-03','tropical fruit'), 
('3811','2015-04-14','red blush wine'), 
('4766','2015-09-29','whole milk'), 
('2436','2015-04-12','frankfurter'), 
('3860','2015-05-05','whole milk'), 
('4875','2015-05-12','frozen potato products'), 
('1587','2015-07-01','other vegetables'), 
('4038','2015-07-08','citrus fruit'), 
('4750','2015-09-21','flour'), 
('1199','2015-12-10','sugar'), 
('1603','2015-09-30','frozen meals'), 
('3111','2015-01-31','chocolate'), 
('3894','2015-12-13','root vegetables'), 
('1456','2015-09-18','root vegetables'), 
('2022','2015-03-04','herbs'), 
('2505','2015-11-30','bottled water'), 
('4851','2015-12-20','sausage'), 
('4293','2015-08-04','coffee'), 
('2775','2015-11-06','pork'), 
('3693','2015-02-18','berries'), 
('1202','2015-07-22','soda'), 
('3699','2015-08-23','berries'), 
('4152','2015-04-15','fruit vegetable juice'), 
('4155','2015-01-26','citrus fruit'), 
('4010','2015-12-29','pork'),
('4389','2015-10-22','detergent'), 
('3746','2015-08-17','grapes'), 
('2560','2015-05-17','sausage'), 
('1503','2015-07-25','chicken'), 
('2555','2015-12-23','whole milk'), 
('3645','2015-12-12','citrus fruit'), 
('3886','2015-09-11','soda'), 
('2932','2015-03-20','sausage'), 
('1711','2015-06-18','frankfurter'), 
('4291','2015-12-08','sausage'), 
('1143','2015-04-25','soda'), 
('4564','2015-07-08','rolls buns'), 
('3337','2015-05-14','beef'), 
('4931','2015-05-04','whole milk'), 
('2623','2015-10-10','processed cheese'), 
('4581','2015-04-03','tropical fruit'), 
('2635','2015-06-11','frankfurter'), 
('1095','2015-10-30','packaged fruit vegetables'), 
('2990','2015-05-23','whole milk'), 
('2426','2015-06-05','berries'), 
('4555','2015-11-07','citrus fruit'), 
('3635','2015-09-04','tropical fruit'), 
('3058','2015-05-18','hamburger meat'), 
('4391','2015-03-26','hamburger meat'), 
('1306','2015-06-23','whole milk'), 
('1024','2015-08-10','fish'), 
('1295','2015-07-23','frankfurter'), 
('1661','2015-06-21','packaged fruit vegetables'), 
('4591','2015-05-15','pastry'), 
('3169','2015-06-14','other vegetables'), 
('3915','2015-05-21','misc. beverages'), 
('1127','2015-01-14','frankfurter'), 
('4828','2015-08-08','sparkling wine'), 
('3683','2015-06-10','specialty bar'), 
('1971','2015-09-18','sausage'), 
('3014','2015-11-11','curd cheese'), 
('3779','2015-09-15','frankfurter'), 
('2489','2015-05-04','whole milk'), 
('3564','2015-06-27','newspapers'), 
('4092','2015-09-30','berries'), 
('3221','2015-01-13','curd'), 
('1279','2015-09-06','tropical fruit'), 
('2581','2015-08-22','soda'), 
('2295','2015-02-25','rolls buns'), 
('4760','2015-02-22','canned beer'), 
('3649','2015-01-16','canned beer'), 
('1075','2015-11-19','frankfurter'), 
('3987','2015-08-19','other vegetables'), 
('4106','2015-08-25','whole milk'), 
('4338','2015-06-24','whole milk'), 
('4166','2015-11-06','citrus fruit'), 
('1211','2015-03-10','frankfurter'), 
('3954','2015-01-21','frankfurter'), 
('3928','2015-07-18','butter milk'), 
('3827','2015-09-30','hamburger meat'), 
('4699','2015-02-08','pasta'), 
('4747','2015-06-08','other vegetables'), 
('3028','2015-06-09','sausage'), 
('2851','2015-03-16','rolls buns'), 
('4417','2015-02-25','grapes'), 
('3822','2015-03-07','root vegetables'), 
('2288','2015-05-31','coffee'), 
('2184','2015-06-30','popcorn'), 
('4554','2015-08-27','whole milk'), 
('3361','2015-03-05','tropical fruit'), 
('2999','2015-04-17','beef'), 
('2614','2015-06-25','whole milk'), 
('4064','2015-06-05','frankfurter'), 
('3567','2015-10-04','tropical fruit'), 
('2587','2015-05-07','canned beer'), 
('3783','2015-06-17','finished products'), 
('1923','2015-02-14','beverages'), 
('4835','2015-02-19','hamburger meat'), 
('1514','2015-08-24','whole milk'), 
('3154','2015-06-22','finished products'), 
('1313','2015-12-25','other vegetables'), 
('2794','2015-07-18','ham'), 
('2359','2015-04-09','other vegetables'), 
('2238','2015-03-09','curd'),
('3795','2015-01-17','bottled beer'), 
('3724','2015-11-26','curd'), 
('1152','2015-03-05','whole milk'), 
('4559','2015-03-17','whole milk'), 
('3922','2015-02-27','dessert'), 
('1709','2015-04-22','sausage'), 
('2219','2015-04-17','other vegetables'), 
('2206','2015-10-17','ham'), 
('1752','2015-04-06','other vegetables'), 
('3942','2015-11-10','other vegetables'), 
('3296','2015-08-17','soda'), 
('2257','2015-02-05','herbs'), 
('4313','2015-07-28','frankfurter'), 
('2001','2015-08-21','rolls buns'), 
('2449','2015-07-08','curd'), 
('4914','2015-04-12','frankfurter'), 
('2764','2015-07-24','other vegetables'), 
('4187','2015-05-09','dog food'), 
('1392','2015-04-20','specialty bar'), 
('3427','2015-04-28','curd'), 
('1411','2015-02-20','frankfurter'), 
('3390','2015-11-14','soda'), 
('4787','2015-08-01','beef'), 
('3310','2015-01-17','canned beer'), 
('1782','2015-10-10','pork'), 
('3375','2015-04-26','frankfurter'), 
('2760','2015-01-07','sausage'), 
('4249','2015-09-13','canned beer'), 
('2904','2015-06-06','specialty chocolate'), 
('4090','2015-02-26','curd'), 
('3060','2015-07-05','canned beer'), 
('3768','2015-10-07','whole milk'), 
('1232','2015-01-27','rolls buns'), 
('1360','2015-10-23','pork'), 
('1107','2015-10-01','citrus fruit'), 
('2865','2015-11-04','pot plants'), 
('2958','2015-06-14','rolls buns'), 
('2448','2015-07-12','butter'), 
('1222','2015-09-24','condensed milk'), 
('2943','2015-06-20','sausage'), 
('2270','2015-08-11','whole milk'), 
('3812','2015-07-21','sausage'), 
('1482','2015-11-22','beverages'), 
('4720','2015-02-22','beverages'), 
('1344','2015-09-04','bottled water'), 
('2397','2015-10-04','newspapers'), 
('4182','2015-05-12','cleaner'), 
('4487','2015-07-10','sausage'), 
('3467','2015-12-24','newspapers'), 
('2443','2015-11-15','sausage'), 
('2749','2015-01-27','misc. beverages'), 
('4389','2015-04-13','white wine'), 
('1674','2015-12-04','sausage'), 
('4262','2015-10-16','meat'), 
('2082','2015-04-07','frankfurter'), 
('4494','2015-01-06','ice cream'), 
('2460','2015-09-28','canned beer'), 
('4509','2015-11-29','tropical fruit'), 
('2267','2015-07-23','meat'), 
('4891','2015-09-05','whole milk'), 
('3962','2015-09-20','sausage'), 
('4964','2015-07-18','frankfurter'), 
('2914','2015-11-30','meat'), 
('2808','2015-05-05','root vegetables'), 
('1085','2015-08-15','root vegetables'), 
('3808','2015-08-18','whole milk'), 
('4149','2015-01-07','citrus fruit'), 
('2331','2015-06-05','citrus fruit'), 
('4475','2015-04-03','other vegetables'), 
('2761','2015-04-25','citrus fruit'), 
('2620','2015-12-14','sausage'),
('3206','2015-10-13','frankfurter'), 
('1226','2015-04-13','hard cheese'), 
('1395','2015-03-07','cream cheese '), 
('2465','2015-06-07','turkey'), 
('3572','2015-07-09','pork'), 
('4387','2015-05-08','whole milk'), 
('1555','2015-03-27','rolls buns'), 
('1181','2015-11-16','sausage'), 
('2814','2015-05-11','ice cream'), 
('2794','2015-09-16','liquor'), 
('2912','2015-01-28','pip fruit'), 
('4667','2015-01-12','root vegetables'), 
('2235','2015-10-25','soda'), 
('2353','2015-05-02','soda'), 
('3449','2015-03-08','sausage'), 
('1058','2015-10-11','root vegetables'), 
('1027','2015-05-17','pork'), 
('3302','2015-05-22','pork'), 
('2229','2015-05-30','chocolate'), 
('2188','2015-08-15','fruit vegetable juice'), 
('1547','2015-04-18','pickled vegetables'), 
('1649','2015-06-30','bottled water'), 
('3254','2015-09-10','frankfurter'), 
('2818','2015-11-07','tropical fruit'), 
('2703','2015-05-08','canned beer'), 
('3332','2015-01-31','root vegetables'), 
('2473','2015-07-01','meat'), 
('2810','2015-12-30','frankfurter'), 
('1033','2015-04-22','tropical fruit'), 
('4222','2015-05-27','tropical fruit'), 
('3679','2015-09-21','citrus fruit'), 
('2212','2015-08-27','hamburger meat'), 
('1507','2015-06-22','chicken'), 
('2870','2015-01-22','chicken'), 
('3429','2015-04-25','frankfurter'), 
('4148','2015-04-09','canned beer'), 
('2970','2015-12-30','turkey'), 
('2013','2015-08-30','packaged fruit vegetables'), 
('3967','2015-05-30','pasta'), 
('2885','2015-05-15','citrus fruit'), 
('3935','2015-07-02','sausage'), 
('3283','2015-05-01','whole milk'), 
('3268','2015-11-06','canned beer'), 
('3677','2015-04-30','citrus fruit'), 
('3495','2015-06-27','liquor (appetizer)'), 
('1410','2015-10-04','citrus fruit'), 
('2440','2015-06-06','sausage'), 
('4088','2015-01-13','chicken'), 
('2469','2015-09-23','hamburger meat'), 
('4229','2015-03-06','sausage'), 
('2728','2015-08-02','beef'), 
('4694','2015-01-25','citrus fruit'), 
('2836','2015-12-29','UHT-milk'), 
('1311','2015-02-12','candy'), 
('1760','2015-01-23','newspapers'), 
('3656','2015-03-21','beef'), 
('3720','2015-05-28','sausage'), 
('2996','2015-09-26','frankfurter'), 
('1949','2015-07-22','canned beer'), 
('4498','2015-02-11','bottled beer'), 
('2447','2015-12-28','onions'), 
('1952','2015-03-23','tropical fruit'), 
('4099','2015-01-27','bottled water'), 
('1804','2015-03-12','beef'), 
('1510','2015-05-16','sausage'), 
('2879','2015-04-18','hair spray'), 
('4899','2015-03-12','chicken'), 
('4326','2015-09-29','pork'), 
('1670','2015-05-17','ice cream'), 
('1117','2015-05-24','meat'), 
('1346','2015-03-04','other vegetables'), 
('1178','2015-11-15','bottled water'), 
('1649','2015-06-25','tropical fruit'), 
('4651','2015-06-21','photo film'), 
('4243','2015-04-21','sausage'), 
('4429','2015-07-21','grapes'), 
('4645','2015-07-25','domestic eggs'), 
('4019','2015-07-24','rolls buns'), 
('4459','2015-04-26','tropical fruit'), 
('3006','2015-12-27','chicken'), 
('1834','2015-09-17','frankfurter'), 
('3236','2015-07-14','berries'),
 ('2666','2014-05-26','chocolate'), 
 ('2717','2014-01-02','fruit vegetable juice'), 
 ('1095','2014-03-25','shopping bags'), 
 ('1480','2014-12-22','bottled water'), 
 ('2865','2014-09-23','processed cheese'), 
 ('1482','2014-10-22','brown bread'), 
 ('3184','2014-04-20','berries'), 
 ('1468','2014-08-21','salty snack'), 
 ('4077','2014-12-25','sauces'), 
 ('3888','2014-10-16','butter'), 
 ('3972','2014-04-07','butter'), 
 ('2967','2014-05-27','oil'), 
 ('3380','2014-08-16','other vegetables'), 
 ('2207','2014-12-03','coffee'), 
 ('3600','2014-04-08','pickled vegetables'), 
 ('4618','2014-07-09','sliced cheese'), 
 ('2680','2014-03-16','frozen meals'), 
 ('1651','2014-03-28','dishes'), 
 ('2934','2014-03-22','fruit vegetable juice'), 
 ('2860','2014-09-15','waffles'), 
 ('1307','2014-11-14','rolls buns'), 
 ('4628','2014-12-03','UHT-milk'), 
 ('1240','2014-11-27','shopping bags'), 
 ('3666','2014-06-14','bottled water'), 
 ('4008','2014-10-14','shopping bags'), 
 ('3386','2014-08-07','baking powder'), 
 ('2472','2014-06-19','sugar'), 
 ('1323','2014-06-18','whole milk'), 
 ('1654','2014-09-08','butter'), 
 ('3620','2014-05-17','berries'), 
 ('4952','2014-09-03','specialty chocolate'), 
 ('3966','2014-01-07','canned beer'), 
 ('1964','2014-03-23','other vegetables'), 
 ('2504','2014-12-17','waffles'), 
 ('4500','2014-02-04','cat food'), 
 ('1454','2014-05-03','fruit vegetable juice'), 
 ('1066','2014-02-01','bottled beer'), 
 ('3692','2014-01-09','salty snack'), 
 ('2445','2014-04-17','pastry'), 
 ('1860','2014-01-31','rolls buns'), 
 ('1153','2014-08-18','cake bar'), 
 ('3317','2014-08-10','soda'), 
 ('1957','2014-03-20','berries'), 
 ('4303','2014-11-28','specialty bar'), 
 ('3556','2014-10-04','brown bread'), 
 ('1282','2014-05-04','shopping bags'), 
 ('4034','2014-08-29','specialty bar'), 
 ('2807','2014-07-17','beverages'), 
 ('2232','2014-01-25','dessert'), 
 ('2303','2014-06-12','hair spray'), 
 ('2050','2014-10-20','rolls buns'), 
 ('3381','2014-12-05','coffee'), 
 ('3402','2014-05-17','coffee'), 
 ('3072','2014-11-12','dessert'), 
 ('3381','2014-10-30','hygiene articles'), 
 ('1367','2014-01-31','bottled beer'), 
 ('1895','2014-01-23','whipped sour cream'), 
 ('3267','2014-11-14','soda'), 
 ('4192','2014-02-17','canned beer'), 
 ('2274','2014-12-04','curd'), 
 ('4430','2014-10-03','whipped sour cream'), 
 ('4329','2014-10-23','dessert'), 
 ('1922','2014-05-30','whipped sour cream'), 
 ('2154','2014-08-14','onions'), 
 ('4523','2014-08-06','canned beer'), 
 ('1136','2014-05-02','flower (seeds)'), 
 ('3439','2014-04-27','soda'), 
 ('2980','2014-11-27','shopping bags'), 
 ('2509','2014-08-17','other vegetables'), 
 ('4845','2014-07-10','fruit vegetable juice'), 
 ('3589','2014-07-24','fruit vegetable juice'), 
 ('4505','2014-01-18','other vegetables'), 
 ('2744','2014-05-06','frozen vegetables'), 
 ('4236','2014-03-04','curd'), 
 ('3928','2014-08-05','shopping bags'), 
 ('1207','2014-04-28','pickled vegetables'), 
 ('2578','2014-04-19','rolls buns'), 
 ('1553','2014-05-09','soda'), 
 ('3942','2014-01-01','yogurt'), 
 ('1583','2014-01-27','dessert'),
  ('2133','2014-05-24','cat food'), 
 ('4860','2014-11-14','newspapers'), 
 ('4548','2014-10-09','onions'), 
 ('2610','2014-01-01','bottled beer'), 
 ('2344','2014-02-22','napkins'), 
 ('2920','2014-05-12','rolls buns'), 
 ('3847','2014-03-14','domestic eggs'), 
 ('1991','2014-10-31','butter'), 
 ('2241','2014-02-17','frozen vegetables'), 
 ('2794','2014-02-18','whole milk'), 
 ('3871','2014-10-05','salty snack'), 
 ('4085','2014-04-15','potato products'), 
 ('3964','2014-03-11','bottled water'), 
 ('1111','2014-10-24','flour'), 
 ('1294','2014-08-14','soda'), 
 ('1338','2014-08-11','whole milk'), 
 ('1079','2014-10-07','bottled water'), 
 ('1794','2014-04-14','yogurt'), 
 ('4715','2014-11-10','margarine'), 
 ('4694','2014-06-01','whipped sour cream'), 
 ('4156','2014-08-19','candles'), 
 ('4264','2014-03-16','butter milk'), 
 ('1732','2014-04-03','canned beer'), 
 ('1161','2014-01-26','newspapers'), 
 ('4058','2014-02-07','flour'), 
 ('4183','2014-10-26','ice cream'), 
 ('4371','2014-03-29','canned beer'),
 ('1808','2015-07-21','tropical fruit'), 
('2552','2015-01-05','whole milk'), 
('2300','2015-09-19','pip fruit'), 
('1187','2015-12-12','other vegetables'), 
('3037','2015-02-01','whole milk'),
('4941','2015-02-14','rolls buns'), 
('4501','2015-05-08','other vegetables'), 
('3803','2015-12-23','pot plants'), 
('2762','2015-03-20','whole milk'), 
('4119','2015-02-12','tropical fruit'), 
('1340','2015-02-24','citrus fruit'), 
('2193','2015-04-14','beef'), 
('1997','2015-07-21','frankfurter'), 
('4546','2015-09-03','chicken'),
('4736','2015-07-21','butter'), 
('1959','2015-03-30','fruit vegetable juice'), 
('1974','2015-05-03','packaged fruit vegetables'), 
('2421','2015-09-02','chocolate'), 
('1513','2015-09-03','specialty bar'), 
('1905','2015-07-07','other vegetables'), 
('2810','2015-09-08','butter milk'), 
('2867','2015-11-12','whole milk'),
('3962','2015-09-18','tropical fruit'), 
('1088','2015-11-30','tropical fruit'), 
('4976','2015-07-17','bottled water'), 
('4056','2015-06-12','yogurt'), 
('3611','2015-02-13','sausage'), 
('1420','2015-01-14','other vegetables'), 
('4286','2015-03-08','brown bread'), 
('4918','2015-01-27','yogurt'),
('4783','2015-10-22','hamburger meat'), 
('3709','2015-10-26','root vegetables'), 
('4289','2015-10-08','pork'), 
('1559','2015-10-03','beef'), 
('2900','2015-04-11','pastry'), 
('1905','2015-02-21','fruit vegetable juice'), 
('3527','2015-09-29','canned beer'), 
('1495','2015-01-09','root vegetables'), 
('3558','2015-04-03','citrus fruit'), 
('3128','2015-04-20','sausage'), 
('1863','2015-08-04','tropical fruit'), 
('3841','2015-07-19','berries'), 
('3903','2015-10-06','canned beer'), 
('2658','2015-10-16','butter milk'),
('1348','2015-09-17','soda'), 
('3806','2015-08-28','tropical fruit'), 
('1711','2015-06-08','soda'), 
('3959','2015-12-04','white bread'), 
('1590','2015-08-15','coffee'), 
('1962','2015-06-08','tropical fruit'), 
('1766','2015-01-21','pork'), 
('2551','2015-10-21','citrus fruit'), 
('2294','2015-09-23','frankfurter'), 
('4531','2015-05-29','frankfurter'), 
('2957','2015-04-12','frankfurter'), 
('4415','2015-01-26','other vegetables'), 
('1476','2015-08-26','yogurt'), 
('3978','2015-07-23','sausage'), 
('2062','2015-09-22','whole milk'), 
('3252','2015-06-28','pip fruit'), 
('3922','2015-06-24','whole milk'), 
('1491','2015-10-17','root vegetables'), 
('3526','2015-08-26','onions'), 
('4060','2015-12-11','specialty chocolate'), 
('1067','2015-04-08','hamburger meat'), 
('2840','2015-01-27','photo film'), 
('4484','2015-11-27','rolls buns'), 
('2353','2015-02-07','canned beer'), 
('3130','2015-02-18','canned beer'), 
('4273','2015-06-14','other vegetables'), 
('4565','2015-12-30','canned beer'), 
('2504','2015-08-14','curd'), 
('4127','2015-10-23','butter'), 
('2690','2015-04-01','other vegetables'), 
('4129','2015-09-22','whole milk'), 
('4511','2015-06-29','beef'), 
('1602','2015-08-04','sausage'), 
('4369','2015-02-01','soda'), 
('1302','2015-09-29','fruit vegetable juice'), 
('3326','2015-04-30','rolls buns'), 
('2066','2015-05-21','pip fruit'), 
('3483','2015-01-15','frozen vegetables'), 
('2840','2015-02-12','beverages'), 
('1807','2015-05-18','hamburger meat'), 
('2067','2015-08-12','root vegetables'), 
('3783','2015-02-17','canned beer'), 
('2884','2015-01-04','frozen vegetables'), 
('2908','2015-03-15','canned beer'), 
('1330','2015-07-10','newspapers'), 
('2293','2015-05-08','rolls buns'), 
('3718','2015-05-20','hamburger meat'), 
('4338','2015-01-25','pip fruit'), 
('3486','2015-11-08','canned beer'), 
('3635','2015-09-04','grapes'), 
('2857','2015-02-18','root vegetables'), 
('3684','2015-08-13','citrus fruit'), 
('3120','2015-10-20','cling film bags'),
('3495','2015-03-11','whole milk'), 
('2813','2015-11-16','pip fruit'), 
('2799','2015-09-02','sugar'), 
('4723','2015-05-22','tropical fruit'), 
('3313','2015-04-08','root vegetables'), 
('4748','2015-12-15','soda'), 
('2991','2015-02-16','whole milk'), 
('1483','2015-04-01','tropical fruit'), 
('3950','2015-10-01','white bread'), 
('1634','2015-01-16','brown bread'), 
('2694','2015-05-12','tropical fruit'), 
('2707','2015-10-18','domestic eggs'), 
('2813','2015-10-16','coffee'), 
('2276','2015-01-11','soda'), 
('4726','2015-02-06','whole milk'), 
('4353','2015-05-25','bottled beer'), 
('4017','2015-08-13','pork'), 
('1422','2015-08-21','other vegetables'),
('4211','2014-05-29','newspapers'), 
('4899','2014-05-10','rolls buns'), 
('1890','2014-04-12','flour'), 
('1268','2014-09-26','sauces'), 
('3172','2014-03-03','bottled beer'), 
('1444','2014-04-30','yogurt'), 
('4758','2014-05-08','butter'), 
('3125','2014-02-23','newspapers'), 
('3258','2014-12-19','yogurt'), 
('4474','2014-07-18','yogurt'), 
('1204','2014-05-25','waffles'), 
('4212','2014-04-13','butter'), 
('3106','2014-01-10','pastry'), 
('2284','2014-01-06','fruit vegetable juice'), 
('3849','2014-01-07','whole milk'), 
('2588','2014-07-01','coffee'), 
('3733','2014-08-05','newspapers'), 
('4306','2014-07-01','misc. beverages'), 
('1718','2014-12-03','rolls buns'),
('3747','2014-11-05','salt'), 
('2048','2014-11-07','fruit vegetable juice'), 
('4358','2014-08-11','coffee'), 
('1581','2014-02-17','napkins'), 
('3815','2014-09-03','cake bar'), 
('2176','2014-09-27','hard cheese'), 
 ('4726','2014-04-01','whole milk'), 
 ('1844','2014-04-10','yogurt'), 
 ('1458','2014-10-20','rolls buns'), 
 ('4491','2014-09-18','bottled water'), 
 ('1013','2014-11-12','mayonnaise'), 
 ('1538','2014-12-06','dessert'), 
 ('3420','2014-08-20','bottled beer'), 
 ('2414','2014-06-04','cling film bags'), 
 ('3714','2014-06-08','butter'), 
 ('2484','2014-03-19','hygiene articles'), 
 ('2315','2014-06-03','newspapers'), 
 ('4056','2014-05-10','salty snack'), 
 ('2630','2014-01-11','processed cheese'), 
 ('2324','2014-04-15','soda'), 
 ('1185','2014-09-28','chewing gum'), 
 ('2415','2014-06-25','candy'), 
 ('3524','2014-03-27','whipped sour cream'), 
 ('4583','2014-06-06','other vegetables'), 
 ('1827','2014-03-12','coffee'), 
 ('4393','2014-02-05','coffee'), 
 ('3177','2014-09-13','soda'), 
 ('3201','2014-09-20','newspapers'), 
 ('4033','2014-02-25','white bread'), 
 ('3059','2014-12-07','misc. beverages'), 
 ('4006','2014-11-25','napkins'), 
 ('1070','2014-04-10','red blush wine'),
 ('1765','2015-03-11','margarine'), 
('3855','2015-03-09','tropical fruit'), 
('4392','2015-11-28','ham'), 
('3330','2015-07-26','hamburger meat'), 
('1723','2015-09-22','yogurt'), 
('4110','2015-03-30','soda'), 
('2600','2015-01-28','yogurt'), 
('2946','2015-10-07','soda'), 
('2426','2015-09-08','bottled water'), 
('4170','2015-05-03','sausage'), 
('1109','2015-04-06','citrus fruit'), 
('3429','2015-01-04','shopping bags'), 
('2055','2015-02-04','newspapers'), 
('2480','2015-09-20','frankfurter'), 
('2441','2015-05-30','sausage'), 
('1054','2015-04-10','frankfurter'), 
('4818','2015-10-14','salt'), 
('3379','2015-01-21','oil'), 
('3939','2015-02-10','curd'), 
('1367','2015-08-05','other vegetables'), 
('1043','2015-01-10','citrus fruit'), 
('2231','2015-10-17','frankfurter'), 
('3235','2015-12-28','root vegetables'), 
('4554','2015-07-16','tropical fruit'), 
('3245','2015-01-24','beef'), 
('2996','2015-05-19','berries'), 
('2507','2015-01-15','canned beer'), 
('4186','2015-10-25','whipped sour cream'), 
('3929','2015-04-28','root vegetables'), 
('3760','2015-11-22','whole milk'), 
('4928','2015-08-18','beef'), 
('4217','2015-12-18','frozen vegetables'), 
('1174','2015-02-11','rolls buns'), 
('4103','2015-06-19','whole milk'), 
('4408','2015-03-13','whole milk'), 
('2588','2015-12-28','citrus fruit'),
('3806','2015-08-28','tropical fruit'), 
('1711','2015-06-08','soda'), 
('3959','2015-12-04','white bread'), 
('1590','2015-08-15','coffee'), 
('1962','2015-06-08','tropical fruit'), 
('1766','2015-01-21','pork'), 
('2551','2015-10-21','citrus fruit'), 
('2294','2015-09-23','frankfurter'), 
('4531','2015-05-29','frankfurter'), 
('2957','2015-04-12','frankfurter'), 
('4415','2015-01-26','other vegetables'), 
('1476','2015-08-26','yogurt'), 
('3978','2015-07-23','sausage'), 
('2062','2015-09-22','whole milk'), 
('3252','2015-06-28','pip fruit'), 
('3922','2015-06-24','whole milk'), 
('1491','2015-10-17','root vegetables'), 
('3526','2015-08-26','onions'), 
('4060','2015-12-11','specialty chocolate'), 
('1067','2015-04-08','hamburger meat'), 
('2840','2015-01-27','photo film'), 
('4484','2015-11-27','rolls buns'), 
('2353','2015-02-07','canned beer'), 
('3130','2015-02-18','canned beer'), 
('4273','2015-06-14','other vegetables'), 
('4565','2015-12-30','canned beer'), 
('2504','2015-08-14','curd'), 
('4127','2015-10-23','butter'), 
('2690','2015-04-01','other vegetables'), 
('4129','2015-09-22','whole milk'), 
('4511','2015-06-29','beef'), 
('1602','2015-08-04','sausage'), 
('4369','2015-02-01','soda'), 
('1302','2015-09-29','fruit vegetable juice'), 
('3326','2015-04-30','rolls buns'), 
('2066','2015-05-21','pip fruit'), 
('3483','2015-01-15','frozen vegetables'), 
('2840','2015-02-12','beverages'), 
('1807','2015-05-18','hamburger meat'), 
('2067','2015-08-12','root vegetables'), 
('3783','2015-02-17','canned beer'), 
('2884','2015-01-04','frozen vegetables'), 
('2908','2015-03-15','canned beer'), 
('1330','2015-07-10','newspapers'), 
('2293','2015-05-08','rolls buns'), 
('3718','2015-05-20','hamburger meat'), 
('4338','2015-01-25','pip fruit'), 
('3486','2015-11-08','canned beer'), 
('3635','2015-09-04','grapes'), 
('2857','2015-02-18','root vegetables'), 
('3684','2015-08-13','citrus fruit'), 
('3120','2015-10-20','cling film bags'),
('1116','2014-08-11','zwieback'), 
('3422','2014-07-27','pastry'), 
('4720','2014-08-24','soft cheese'), 
('1595','2014-11-09','nut snack'), 
('3776','2014-02-21','white wine'), 
('1058','2014-05-24','other vegetables');

/* Показать данные таблицы*/
select * from grocery_data.grocery_table;

/* Проверка нулевых значений в колонках*/
select member_number from grocery_data.grocery_table where member_number is null;
select createDate from grocery_data.grocery_table where createDate is null;
select itemDescription from grocery_data.grocery_table where itemDescription is null;

/*АНАЛИЗ*/
/* Основные подсчеты*/
select count(distinct member_number) from grocery_data.grocery_table;
select count(distinct itemDescription) from grocery_data.grocery_table;
/* Самая ранняя и поздняя дата*/
select min(createDate) from grocery_data.grocery_table;
select max(createDate) from grocery_data.grocery_table;

/* Какие товары продаются чаще всего*/
select itemDescription, count(itemDescription) from grocery_data.grocery_table
group by itemDescription order by count(itemDescription) desc;

/* Анализ продаж по годам, месяцам и дням недели*/
/* Извлечение года, месяца, дня  из поля даты покупки и добавление новых столбцов*/
alter table grocery_data.grocery_table add purchase_year int;
alter table grocery_data.grocery_table add purchase_month int;
alter table grocery_data.grocery_table add purchase_day int;
alter table grocery_data.grocery_table add purchase_dow int;

update grocery_data.grocery_table set purchase_year = year(createDate);
update grocery_data.grocery_table set purchase_month = month(createDate);
update grocery_data.grocery_table set purchase_day = day(createDate);
update grocery_data.grocery_table set purchase_dow = dayofweek(createDate);
select * from grocery_data.grocery_table;

/* Самые популярные продукты по годам*/
/* за 2014г*/
select itemDescription, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2014 group by itemDescription order by count(itemDescription) desc;
/* за 2015г*/
select itemDescription, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2015 group by itemDescription order by count(itemDescription) desc;

/* Объем продаж по годам*/
select purchase_year, count(itemDescription) from grocery_data.grocery_table
group by purchase_year order by count(itemDescription) desc;

/*Объем продаж по месяцам*/

/*Продажи за все года*/
select purchase_month, count(itemDescription) from grocery_data.grocery_table
group by purchase_month order by count(itemDescription) desc;
/*Продажи по месяцам в 2014*/
select purchase_month, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2014 group by purchase_month order by count(itemDescription) desc;
/*Продажи по месяцам в 2015*/
select purchase_month, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2015 group by purchase_month order by count(itemDescription) desc;

/*Объем продаж по дням месяца*/

/*за 2014г*/
select purchase_day, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2014 group by purchase_day order by count(itemDescription) desc;
/*за 2015г*/
select purchase_day, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2015 group by purchase_day order by count(itemDescription) desc;

/*Объем продаж по дням недели*/

/*за 2014г*/
select purchase_dow, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2014 group by purchase_dow order by count(itemDescription) desc;
/*за 2015г*/
select purchase_dow, count(itemDescription) from grocery_data.grocery_table
where purchase_year=2015 group by purchase_dow order by count(itemDescription) desc;

/*Создание новой таблицы для добавления информации о доходах от продаж*/

create table grocer_price
(item_number int primary key,
itemDescription varchar(25) not null,
item_price int not null);

insert into grocer_price
(item_number, itemDescription, item_price) values
('1','baking powder','15'),
('2','beef','13'),
('3','berries','4'),
('4','beverages','4'),
('5','bottled beer','8'),
('6','bottled water','11'),
('7','brown bread','2'),
('8','butter','8'),
('9','butter milk','12'),
('10','cake bar','4'),
('11','candy','10'),
('12','canned beer','1'),
('13','cat food','6'),
('14','chicken','2'),
('15','chocolate','13'),
('16','chocolate marshmallow','4'),
('17','citrus fruit','13'),
('18','cleaner','14'),
('19','coffee','8'),
('20','cream cheese','13'),
('21','curd','2'),
('22','curd cheese','12'),
('23','dessert','6'),
('24','detergent','7'),
('25','dishes','14'),
('26','dog food','1'),
('27','domestic eggs','8'),
('28','female sanitary products','1'),
('29','flower (seeds)','15'),
('30','frankfurter','13'),
('31','frozen fish','14'),
('32','frozen meals','12'),
('33','frozen vegetables','12'),
('34','fruit vegetable juice','2'),
('35','grapes','13'),
('36','hair spray','1'),
('37','ham','6'),
('38','hamburger meat','9'),
('39','hard cheese','3'),
('40','herbs','3'),
('41','meat','14'),
('42','hygiene articles','1'),
('43','ice cream','1'),
('44','jam','10'),
('45','kitchen towels','9'),
('46','liquor','8'),
('47','liquor (appetizer)','7'),
('48','male cosmetics','5'),
('49','margarine','3'),
('50','mayonnaise','5'),
('51','misc. beverages','10'),
('52','mustard','10'),
('53','napkins','12'),
('54','newspapers','5'),
('55','onions','3'),
('56','other vegetables','11'),
('57','packaged fruit vegetables','9'),
('58','pasta','9'),
('59','pastry','15'),
('60','photo film','13'),
('61','pickled vegetables','9'),
('62','pip fruit','12'),
('63','popcorn','6'),
('64','pork','11'),
('65','pot plants','1'),
('66','processed cheese','14'),
('67','red blush wine','13'),
('68','rolls buns','4'),
('69','root vegetables','11'),
('70','salty snack','7'),
('71','sausage','10'),
('72','shopping bags','2'),
('73','soda','2'),
('74','softener','10'),
('75','sparkling wine','15'),
('76','specialty bar','9'),
('77','specialty chocolate','8'),
('78','sugar','3'),
('79','tropical fruit','4'),
('80','turkey','2'),
('81','UHT-milk','4'),
('82','waffles','7'),
('83','whipped sour cream','6'),
('84','whole milk','12'),
('85','yogurt','2'),
('86','zwieback','3'),
('87','nut snack','3'), 
('88','cling film bags','8'),
('89','oil','1'),
('90','flour','2'),
('91','salt','1'),
('92','fruit vegetable juice','2'); 

select * from grocery_data.grocer_price;

/*Соединение таблиц*/
select grocery_table.member_number, grocery_table.itemDescription, grocery_table.purchase_year,  grocer_price.item_price from grocery_data.grocery_table inner join grocery_data.grocer_price
on grocery_table.itemDescription = grocer_price.itemDescription;