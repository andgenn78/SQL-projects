#информация о таблице
DESC clean_data;

#5 первых строк
SELECT *
FROM clean_data  
LIMIT 5;

#1. Количество заказов и общий объем продаж по годам
SELECT YEAR(order_date) years,
 SUM(sales) sales,
 COUNT(order_status) 'number of order'
FROM clean_data 
WHERE order_status = 'Order Finished'
GROUP BY 1;

#2. Общий объем продаж по подкатегориям за 2011 и 2012 годы
SELECT *,
       ROUND((sales2012-sales2011)*100/sales2012, 1) 'growth sales (%)'
FROM(
     SELECT product_sub_category,
            SUM( IF( YEAR(order_date) = 2011, sales, 0)) sales2011,
            SUM( IF( YEAR(order_date) = 2012, sales, 0)) sales2012
     FROM clean_data 
     WHERE order_status = 'Order Finished'
     GROUP BY product_sub_category
    ) sub_category
ORDER BY 4 DESC;

#3. Эффективность и результативность продвижения по годам
SELECT YEAR(order_date) years,
 SUM(sales) sales,
 SUM(discount_value) 'promotion value',
 ROUND( SUM(discount_value)*100/SUM(sales), 2) 'burn rate (%)'
FROM clean_data
WHERE order_status = 'Order Finished'
GROUP BY 1;

#4. Эффективность и результативность продвижения по подкатегориям товаров
SELECT product_sub_category,
 product_category,
 SUM(sales) sales,
 SUM(discount_value) promotion_value,
 ROUND(SUM(discount_value)*100/SUM(sales),2) 'burn rate (%)'
FROM clean_data
WHERE YEAR(order_date) = 2012
 AND order_status = 'Order Finished'
GROUP BY product_sub_category,
 product_category
ORDER BY 5;

#5. Количество клиентов в год
SELECT YEAR(order_date) years,
       COUNT(DISTINCT customer) 'number of customer'
FROM clean_data
WHERE order_status = 'Order Finished'
GROUP BY 1;

#6. Новые клиенты по годам
SELECT YEAR(first_order) years,
 COUNT(customer) 'new customers'
FROM(
 SELECT customer,
 MIN(order_date) first_order
 FROM clean_data
 WHERE order_status = 'Order Finished'
 GROUP BY 1) first
GROUP BY 1;
