
-- 1 

-- Из следующей таблицы с идентификаторами пользователей, действиями и датами напишите запрос, чтобы вернуть количество публикаций и отмен для каждого пользователя.


WITH users (user_id, action, date) -- создаём временную таблицу users со столбцами user_id, action, date
AS (VALUES  -- и вносим данные
(1,'start', CAST('01-01-20' AS date)), 
(1,'cancel', CAST('01-02-20' AS date)), 
(2,'start', CAST('01-03-20' AS date)), 
(2,'publish', CAST('01-04-20' AS date)), 
(3,'start', CAST('01-05-20' AS date)), 
(3,'cancel', CAST('01-06-20' AS date)), 
(1,'start', CAST('01-07-20' AS date)), 
(1,'publish', CAST('01-08-20' AS date))),

-- retrieve count of starts, cancels, and publishes for each user
-- получить количество запусков, отмен и публикаций для каждого пользователя

t1 AS ( -- в таблицу t1
SELECT -- выводим столбцы
   user_id, -- столбец user_id
   SUM(CASE WHEN action = 'start' THEN 1 ELSE 0 END) AS starts, -- когда значение столбца action = start, то записываем 1, в противном случае записываем 0 в столбец starts
   SUM(CASE WHEN action = 'cancel' THEN 1 ELSE 0 END) AS cancels, -- когда значение столбца action = cancels, то записываем 1, в противном случае записываем 0 в столбец cancels
   SUM(CASE WHEN action = 'publish' THEN 1 ELSE 0 END) AS publishes -- когда значение столбца action = publishes, то записываем 1, в противном случае записываем 0 в столбец publishes
FROM users -- из таблицы users
GROUP BY 1 -- группировка значений по первому столбцу
ORDER BY 1) -- сортировка значений по первому столбцу по возрастани

-- calculate publication, cancelation rate for each user by dividing by number of starts, casting as float by multiplying by 1.0 (default floor division is a quirk of some SQL tools, not always needed)
-- рассчитать коэффициент публикаций и отмены для каждого пользователя путем деления на количество запусков; приведение к числу с плавающей запятой путем умножения на 1,0

select -- выводим столбцы
   user_id, --
   1.0*publishes/starts AS publish_rate, -- считаем коэффициент публикаций путём деления publishes на starts и записываем значение в столбец publish_rate
   1.0*cancels/starts AS cancel_rate -- считаем коэффициент публикаций путём деления publishes на starts и записываем значение в столбец publish_rate
FROM t1 -- из таблицы t1


-- 2 

/* Из следующей таблицы транзакций между двумя пользователями напишите запрос, чтобы вернуть изменение чистой стоимости для каждого пользователя,
упорядоченное по уменьшению чистого изменения. */


WITH transactions (sender, receiver, amount, transaction_date) -- создаём временную таблицу transactions со столбцами sender, receiver, amount, transaction_date
AS (VALUES -- и вносим данные
(5, 2, 10, CAST('12-2-20' AS date)),
(1, 3, 15, CAST('12-2-20' AS date)), 
(2, 1, 20, CAST('13-2-20' AS date)), 
(2, 3, 25, CAST('14-2-20' AS date)), 
(3, 1, 20, CAST('15-2-20' AS date)), 
(3, 2, 15, CAST('15-2-20' AS date)), 
(1, 4, 5, CAST('16-2-20' AS date))),

-- sum amounts for each sender (debits) and receiver (credits)
-- сумма количества для каждого отправителя (дебет) и получателя (кредит)

debits AS ( -- в таблицу debits
SELECT -- выводим столбцы
   sender, -- столбец sender
   SUM(amount) AS debited -- считаем сумму количества и записываем в столбик debited
FROM transactions -- из таблицы transactions
GROUP BY 1 ), -- группировка значений по первому столбцу
credits AS ( -- в таблицу credits
SELECT -- выводим столбцы
   receiver, -- столбец receiver
   SUM(amount) AS credited -- считаем сумму количества и записываем в столбик credited
FROM transactions -- из таблицы transactions
GROUP BY 1 ) -- группировка значений по первому столбцу

-- full (outer) join debits and credits tables on user id, taking net change as difference between credits and debits, coercing nulls to zeros with coalesce()
-- полное объединение таблиц дебета и кредита по идентификатору пользователя, принимая чистое изменение как разницу между кредитами и дебетами, принуждая nulls к 0 с помощью union()
-- COALESCE - это специальное выражение, которое вычисляет по порядку каждый из своих аргументов и на выходе возвращает значение первого аргумента, который был не NULL
-- FULL JOIN - этот вид объединения	 вернет все строки из всех таблиц, участвующих в соединении, соединив между собой те, которые подошли под условие ON.

SELECT -- выводим столбцы
   COALESCE(sender, receiver) AS user, -- выводим объединение столбцов sender и receiver как столбец user
   COALESCE(credited, 0) - COALESCE(debited, 0) AS net_change -- выводим разницу столбцов credited и debited как столбец net_change
FROM debits d -- с таблицей debits d
FULL JOIN credits c -- полное объединение таблицы credits c
ON d.sender = c.receiver -- при условии, что d.sender = c.receiver
ORDER BY 2 desc -- сортировка по убыванию по второму столбцу


-- 3 

/* Из следующей таблицы, содержащей список заказываемых дат и товаров, напишите запрос, чтобы получить наиболее часто заказываемый товар в каждую дату.
Возврат нескольких предметов в случае ничьей. */


WITH items (date, item) -- создаём временную таблицу items со столбцами date, item
AS (VALUES 
(CAST('01-01-20' AS date),'apple'), 
(CAST('01-01-20' AS date),'apple'), 
(CAST('01-01-20' AS date),'pear'), 
(CAST('01-01-20' AS date),'pear'), 
(CAST('01-02-20' AS date),'pear'), 
(CAST('01-02-20' AS date),'pear'), 
(CAST('01-02-20' AS date),'pear'), 
(CAST('01-02-20' AS date),'orange')),

-- add an item count column to existing table, grouping by date and item columns
-- добавить столбец количества элементов в существующую таблицу, сгруппировав столбцы по дате и элементам
-- Функция COUNT(*) возвращает количество строк в указанной таблице с учетом повторяющихся строк. Она подсчитывает каждую строку отдельно.

t1 AS ( -- в таблицу t1
SELECT -- выводим столбцы
   date, 
   item, 
   COUNT(*) AS item_count -- количество строк в таблице t1 записываем в столбец item_count
FROM items
GROUP BY 1, 2 -- группируем по первому и второму столбцу
ORDER BY 1), -- сортировка по первому столбцу

-- add a rank column in descending order, partitioning by date
-- добавить столбец рангов в порядке убывания, разбивая по дате

t2 AS ( -- в таблицу t2
SELECT -- выводим все столбцы
   *, 
   RANK() OVER (PARTITION BY date ORDER BY item_count DESC) AS date_rank -- ранжирование данных; набор секционируется по date и сортируется по item_count по убываниюи записывается в столбец date_rank
FROM t1)

-- return all dates and items where rank = 1
-- вернуть все dates и items, где rank = 1

SELECT -- выводим столбцы
   date, 
   item
FROM t2
WHERE date_rank = 1 -- при условии, что date_rank = 1


-- 4 

/* Из следующей таблицы действий пользователя напишите запрос, возвращающий для каждого пользователя время, прошедшее между последним и предпоследним действием,
в порядке возрастания идентификатора пользователя. */


WITH users (user_id, action, action_date) -- создаём временную таблицу users со столбцами user_id, action, action_date
AS (VALUES 
(1, 'start', CAST('12-2-20' AS date)), 
(1, 'cancel', CAST('13-2-20' AS date)), 
(2, 'start', CAST('11-2-20' AS date)), 
(2, 'publish', CAST('14-2-20' AS date)), 
(3, 'start', CAST('15-2-20' AS date)), 
(3, 'cancel', CAST('15-2-20' AS date)), 
(4, 'start', CAST('18-2-20' AS date)), 
(1, 'publish', CAST('19-2-20' AS date))),

-- create a date rank column, partitioned by user ID, using the ROW_NUMBER() window function 
-- создайте столбец ранга дат, разделенный по идентификатору пользователя, используя оконную функцию ROW_NUMBER()

t1 AS ( -- в таблицу t1
SELECT -- выводим все столбцы
   *, 
   ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY action_date DESC) AS date_rank -- нумеруем набор, который секционируется по user_id и сортируется по action_date по убыванию и записываем в столбец date_rank
FROM users ),

-- filter on date rank column to pull latest and next latest actions from this table
-- отфильтровать столбец date_rank, чтобы извлечь последние и предпоследние действия из этой таблицы

latest AS (
SELECT *
FROM t1 
WHERE date_rank = 1 ), -- при условии, что date_rank = 1
next_latest AS (
SELECT *
FROM t1 
WHERE date_rank = 2 ) -- при условии, что date_rank = 2

-- left join these two tables, subtracting latest from second latest to get time elapsed 
-- левое соединение этих двух таблиц, вычитание последнего из предпоследнего действия, чтобы получить прошедшее между ними время
-- С помощью LEFT JOIN выбираются все записи первой (левой) таблицы, даже если они не соответствуют записям во второй (правой) таблице.

SELECT -- выводим столбцы
   l1.user_id, -- столбец user_id из таблицы latest
   l1.action_date - l2.action_date AS days_elapsed -- в столбец days_elapsed выводим разницу значений столбцов action_date из latest и action_date из next_latest
FROM latest l1 -- с таблицей latest
LEFT JOIN next_latest l2 -- левое объединение таблицы next_latest
ON l1.user_id = l2.user_id -- при условии, что l1.user_id = l2.user_id
ORDER BY 1 -- сортировка по первому столбцу


-- 5 

/* Компания определяет своих суперпользователей как тех, кто совершил не менее двух транзакций. Из следующей таблицы напишите запрос, возвращающий для каждого пользователя дату,
когда он стал суперпользователем, сначала в порядке старших суперпользователей. Пользователи, не являющиеся суперпользователями, также должны присутствовать в таблице. */


WITH users (user_id, product_id, transaction_date) 
AS (VALUES 
(1, 101, CAST('12-2-20' AS date)), 
(2, 105, CAST('13-2-20' AS date)), 
(1, 111, CAST('14-2-20' AS date)), 
(3, 121, CAST('15-2-20' AS date)), 
(1, 101, CAST('16-2-20' AS date)), 
(2, 105, CAST('17-2-20' AS date)),
(4, 101, CAST('16-2-20' AS date)), 
(3, 105, CAST('15-2-20' AS date))),

-- create a transaction number column using ROW_NUMBER(), partitioning by user ID
-- создайте столбец с номером транзакции, используя ROW_NUMBER(), разделив его по идентификатору пользователя

t1 AS (
SELECT 
   *, 
   ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS transaction_number -- нумеруем набор, который секционируется по user_id и сортируется по transaction_date по возрастанию и записываем в столбец transaction_number
FROM users),

-- filter resulting table on transaction_number = 2
-- отфильтровать таблицу по transaction_number = 2

t2 AS (
SELECT 
   user_id, 
   transaction_date
FROM t1
WHERE transaction_number = 2 ), -- при условии, что transaction_number = 2

-- left join super users onto full user table, order by date 
-- левое объединение суперпользователей в полную таблицу пользователей, упорядочить по дате

t3 AS (
SELECT DISTINCT user_id -- выводим уникальные значения user_id
FROM users )
SELECT 
   t3.user_id, -- выводим user_id из таблицы t3
   transaction_date AS superuser_date -- и столбец transaction_date как стобец superuser_date
FROM t3 -- с таблицей t3
LEFT JOIN t2 -- левое объединение таблицы t2
ON t3.user_id = t2.user_id -- при условии, что t3.user_id = t2.user_id
ORDER BY 2 -- сортировка по второму столбцу


-- 6 

/* Используя следующие две таблицы, напишите запрос, чтобы возвращать рекомендации страниц пользователю социальной сети на основе страниц, которые понравились его друзьям,
но которые они еще не отметили, как понравившиеся. Упорядочить результат по возрастанию идентификатора пользователя. */


WITH friends (user_id, friend) -- создаём временную таблицу friends
AS (VALUES 
(1, 2), (1, 3), (1, 4), (2, 1), (3, 1), (3, 4), (4, 1), (4, 3)),
likes (user_id, page_likes) -- и таблицу likes
AS (VALUES 
(1, 'A'), (1, 'B'), (1, 'C'), (2, 'A'), (3, 'B'), (3, 'C'), (4, 'B')),

-- inner join friends and page likes tables on user_id
-- внутреннее объединение таблиц friends и likes по user_id
/* INNER JOIN для получения только тех строк, для которых существует соответствие записей в главной и присоединяемой таблице. Алгоритм формирования результата:
каждая строка главной таблицы сопоставляется с каждой строкой присоединяемой таблицы. После этого проверяется условие соединения. */

t1 AS (
SELECT 
   l.user_id, 
   l.page_likes, 
   f.friend
FROM likes l -- с таблицей likes
inner JOIN friends f -- внутренне объединение таблицы friends
ON l.user_id = f.user_id ), -- при условии, что l.user_id = f.user_id

-- left join likes on this, requiring user = friend and user likes = friend likes 
-- левое объединение likes, требующее выполнения user = friend и user likes = friend likes

t2 AS (
SELECT 
   t1.user_id,
   t1.page_likes, 
   t1.friend, 
   l.page_likes AS friend_likes
FROM t1 -- с таблицей t1
LEFT JOIN likes l -- левое объединение таблицы likes
ON t1.friend = l.user_id -- при условии, что t1.friend = l.user_id и t1.page_likes = l.page_likes
AND t1.page_likes = l.page_likes )

-- if a friend pair doesn’t share a common page like, friend likes column will be null - pull out these entries 
-- если пара друзей не имеет общего лайка на странице, то столбец лайков друзей будет пустым - выведите эти записи

SELECT DISTINCT -- вывести уникальные значения
   friend AS user_id, -- из столбца friend в столбец user_id
   page_likes AS recommended_page -- из столбца page_likes в столбец recommended_page
FROM t2
WHERE friend_likes IS null -- при условии, что friend_likes является null
ORDER BY 1 -- сортировка по первому столбцу


-- 7 

-- С помощью следующих двух таблиц верните долю пользователей, которые посещали только мобильное приложение, только веб-сайты и посещали оба варианта.


WITH mobile (user_id, page_url) 
AS (VALUES 
(1, 'A'), (2, 'B'), (3, 'C'), (4, 'A'), (9, 'B'), (2, 'C'), (10, 'B')),
web (user_id, page_url) 
AS (VALUES 
(6, 'A'), (2, 'B'), (3, 'C'), (7, 'A'), (4, 'B'), (8, 'C'), (5, 'B')),

-- outer join mobile and web users on user ID
-- внешнее объединение мобильных и веб-пользователей по идентификатору пользователя

t1 AS (
SELECT DISTINCT -- выводим уникальные значения
   m.user_id AS mobile_user, -- значения столбца m.user_id записываем в столбец mobile_user
   w.user_id AS web_user -- значения столбца w.user_id записываем в столбец web_user
FROM mobile m -- с таблицей mobile
FULL JOIN web w -- полное объединение таблицы web
ON m.user_id = w.user_id) -- при условии, что m.user_id = w.user_id

-- calculate fraction of mobile-only, web-only, and both as average of values (ones and zeros) specified in case statement condition
-- вычислить долю только для мобильных устройств, только для веб-страниц и обоих вариантов как среднее значений (единиц и нулей), указанных в условии оператора case

SELECT 
   AVG(CASE WHEN mobile_user IS NOT NULL AND web_user IS NULL THEN 1   ELSE 0 END) AS mobile_fraction, -- когда значение столбца mobile_user не является null и значение столбца web_user является null, то записываем 1, в противном случае записываем 0 и в столбец mobile_fraction записываем среднее значение полученных 1 и 0
   AVG(CASE WHEN web_user IS NOT NULL AND mobile_user IS NULL THEN 1 ELSE 0 END) AS web_fraction, -- когда значение столбца web_user не является null и значение столбца mobile_user является null, то записываем 1, в противном случае записываем 0 и в столбец web_fraction записываем среднее значение полученных 1 и 0
   AVG(CASE WHEN web_user IS NOT NULL AND mobile_user IS NOT NULL THEN 1 ELSE 0 END) AS both_fraction -- когда значение столбца web_user не является null и значение столбца mobile_user не является null, то записываем 1, в противном случае записываем 0 и в столбец both_fraction записываем среднее значение полученных 1 и 0
FROM t1


-- 8 

/* Учитывая следующие две таблицы, верните долю пользователей, округленную до двух знаков после запятой, которые получили доступ к второй функции (введите: F2 в таблице событий)
и перешли на премиум в течение первых 30 дней после регистрации. */


WITH users (user_id, name, join_date) 
AS (VALUES 
(1, 'Jon', CAST('14-2-20' AS date)), 
(2, 'Jane', CAST('14-2-20' AS date)), 
(3, 'Jill', CAST('15-2-20' AS date)), 
(4, 'Josh', CAST('15-2-20' AS date)), 
(5, 'Jean', CAST('16-2-20' AS date)), 
(6, 'Justin', CAST('17-2-20' AS date)),
(7, 'Jeremy', CAST('18-2-20' AS date))),
events (user_id, type, access_date) 
AS (VALUES 
(1, 'F1', CAST('1-3-20' AS date)), 
(2, 'F2', CAST('2-3-20' AS date)), 
(2, 'P', CAST('12-3-20' AS date)),
(3, 'F2', CAST('15-3-20' AS date)), 
(4, 'F2', CAST('15-3-20' AS date)), 
(1, 'P', CAST('16-3-20' AS date)), 
(3, 'P', CAST('22-3-20' AS date))),

-- get feature 2 users and their date of feature 2 access
-- получить пользователей f2 и их дату доступа к f2

t1 AS (
SELECT 
   user_id, 
   type, 
   access_date AS f2_date -- записываем значения столбца access_date в столбец f2_date
FROM events
WHERE type = 'F2' ), -- при условии, что type = 'F2'

-- get premium users and their date of premium upgrade
-- получите премиум-пользователей и дату их премиум-апгрейда

t2 AS (
SELECT 
   user_id, 
   type, 
   access_date AS premium_date -- записываем значения столбца access_date в столбец premium_date
FROM events
WHERE type = 'P' ), -- при условии, что type = 'P'

-- for each feature 2 user, get time between joining and premium upgrade (or null if no upgrade) by inner joining full users table with feature 2 users on user ID and left joining premium users on user ID, then subtracting premium upgrade date from join date
/* -- для каждого пользователя с f2 получить время между присоединением и премиальным обновлением (или нулевое, если нет обновления) путем внутреннего объединения полной таблицы пользователей с пользователями f2
по идентификатору пользователя и оставить присоединение к премиум-пользователям по идентификатору пользователя, а затем вычесть дату премиум-обновления из даты вступления */

t3 AS (
SELECT t2.premium_date - u.join_date AS upgrade_time -- записываем разницу значений столбца t2.premium_date и столбца u.join_date в столбец upgrade_time
FROM users u -- с таблицей users
inner JOIN t1 -- внутреннее объединение таблицы t1
ON u.user_id = t1.user_id -- при условии, что u.user_id = t1.user_id
LEFT JOIN t2 -- и левое объединение с таблицей t2
ON u.user_id = t2.user_id ) -- при условии, что u.user_id = t2.user_id

-- calculate fraction of users with upgrade time less than 30 days as average of values (ones and zeros) specified in case statement condition, rounding to two decimal places
-- вычислить долю пользователей со временем обновления менее 30 дней как среднее значений (единиц и нулей), указанных в условии case, с округлением до двух знаков после запятой 

SELECT 
   ROUND(AVG(CASE WHEN upgrade_time < 30 THEN 1 ELSE 0 END), 2) AS upgrade_rate -- когда upgrade_time < 30, то записываем 1, в противном случае записываем 0 и в столбец upgrade_rate записываем среднее значение полученных 1 и 0, округлённое до 2 знаклв после запятой
FROM t3


-- 9 

/* Учитывая следующую таблицу, верните список пользователей и их соответствующее количество друзей. Упорядочите результат по убыванию количества друзей, а в случае ничьей — по возрастанию идентификатора пользователя.
Предположим, что отображаются только уникальные друзья */


WITH friends (user1, user2) 
AS (VALUES (1, 2), (1, 3), (1, 4), (2, 3)),

-- compile all user appearances into one column, preserving duplicate entries with UNION ALL 
-- скомпилировать все появления пользователей в один столбец, сохраняя повторяющиеся записи с помощью UNION ALL
-- Оператор UNION ALL используется для объединения результатов двух операторов SELECT, с включением повторяющихся строк.

t1 AS (
SELECT user1 AS user_id
FROM friends
UNION all -- выводим объединённые значения из столбцов user1 и user2 в столбец user_id
SELECT user2 AS user_id
FROM friends)

-- grouping by user ID, count up all appearances of that user
-- группировка по идентификатору пользователя и подсчет всех появлений этого пользователя

SELECT 
   user_id, 
   COUNT(*) AS friend_count -- количество строк в таблице user_id записываем в столбец friend_count
FROM t1
GROUP BY 1 -- группируем по первому столбцу
ORDER BY 2 desc -- сортируем по убыванию по второму столбцу 


-- 10 

/* Таблица проектов содержит три столбца: task_id, start_date и end_date. Разница между end_date и start_date составляет 1 день для каждой строки в таблице.
Если даты окончания задач совпадают, они являются частью одного и того же проекта. Проекты не пересекаются.
Напишите запрос, возвращающий даты начала и окончания каждого проекта, а также количество дней, затраченных на его выполнение. Упорядочить по возрастанию продолжительности проекта и по возрастанию даты начала в случае ничьей. */


WITH projects (task_id, start_date, end_date) 
AS (VALUES 
(1, CAST('01-10-20' AS date), CAST('02-10-20' AS date)), 
(2, CAST('02-10-20' AS date), CAST('03-10-20' AS date)), 
(3, CAST('03-10-20' AS date), CAST('04-10-20' AS date)), 
(4, CAST('13-10-20' AS date), CAST('14-10-20' AS date)), 
(5, CAST('14-10-20' AS date), CAST('15-10-20' AS date)), 
(6, CAST('28-10-20' AS date), CAST('29-10-20' AS date)), 
(7, CAST('30-10-20' AS date), CAST('31-10-20' AS date))),

-- get start dates not present in end date column (these are “true” project start dates) 
-- получить даты начала, отсутствующие в столбце даты окончания (это «настоящие» даты начала проекта)

t1 AS (
SELECT start_date
FROM projects
WHERE start_date NOT IN (SELECT end_date FROM projects) ), -- при условии, что значение столбца start_date не содержится в столбце end_date

-- get end dates not present in start date column (these are “true” project end dates) 
-- получить даты окончания, отсутствующие в столбце даты начала (это «настоящие» даты окончания проекта)

t2 AS (
SELECT end_date
FROM projects
WHERE end_date NOT IN (SELECT start_date FROM projects) ), -- при условии, что значение столбца start_date не содержится в столбце start_date

-- filter to plausible start-end pairs (start < end), then find correct end date for each start date (the minimum end date, since there are no overlapping projects)
-- отфильтруйте правдоподобные пары начало-конец (начало < конец), затем найдите правильную дату окончания для каждой даты начала (минимальная дата окончания, так как нет перекрывающихся проектов)

t3 AS (
SELECT 
   start_date, 
   MIN(end_date) AS end_date -- выводим минимальное значение столбца end_date
FROM t1, t2 -- из таблиц t1 и t2
WHERE start_date < end_date -- при условии, что start_date < end_date
GROUP BY 1 ) -- группируем по первому столбцу
SELECT 
   *, 
   end_date - start_date AS project_duration -- в столбец project_duration записываем разницу значений из столбцов end_date и start_date
FROM t3
ORDER BY 3, 1 -- сортируем по третьему, а затем по первому столбцу


-- 11 

-- Имея следующие две таблицы, напишите запрос, возвращающий округленную до двух знаков после запятой долю учащихся, посещавших школу в свой день рождения (attendance  = 1).


WITH attendance (student_id, school_date, attendance)
AS (VALUES
(1, CAST('2020-04-03' AS date), 0),
(2, CAST('2020-04-03' AS date), 1),
(3, CAST('2020-04-03' AS date), 1), 
(1, CAST('2020-04-04' AS date), 1), 
(2, CAST('2020-04-04' AS date), 1), 
(3, CAST('2020-04-04' AS date), 1), 
(1, CAST('2020-04-05' AS date), 0), 
(2, CAST('2020-04-05' AS date), 1), 
(3, CAST('2020-04-05' AS date), 1), 
(4, CAST('2020-04-05' AS date), 1)),
students (student_id, school_id, grade_level, date_of_birth)
AS (VALUES
(1, 2, 5, CAST('2012-04-03' AS date)),
(2, 1, 4, CAST('2013-04-04' AS date)),
(3, 1, 3, CAST('2014-04-05' AS date)), 
(4, 2, 4, CAST('2013-04-03' AS date)))

-- join attendance and students table on student ID, and day and month of school day = day and month of birthday, taking average of attendance column values and rounding
-- объединить таблицу посещаемости и учащихся по идентификатору учащегося, а день и месяц учебного дня = дню и месяцу дня рождения, взяв среднее значение столбца посещаемости и округлив
-- Функция EXTRACT используется для извлечения компонентов из значения даты/времени

SELECT ROUND(AVG(attendance), 2) AS birthday_attendance -- выводим среднее значение столбца attendance, округлённое до двух знаков после запятой
FROM attendance a -- с таблицей attendance
JOIN students s -- объединяем таблицу students
ON a.student_id = s.student_id -- при условии, что a.student_id = s.student_id
AND EXTRACT(MONTH FROM school_date) = EXTRACT(MONTH FROM date_of_birth) -- и месяц из school_date равен месяцу из date_of_birth
AND EXTRACT(DAY FROM school_date) = EXTRACT(DAY FROM date_of_birth) -- и день из school_date равен дню из date_of_birth


-- 12 

/* Имея следующие две таблицы, напишите запрос для возврата идентификатора хакера, имени и общего балла (сумма максимальных баллов за каждое выполненное задание), упорядоченных по убыванию баллов и
по возрастанию идентификатора хакера в случае равенства баллов. Не отображать записи для хакеров с нулевым счетом. */


WITH hackers (hacker_id, name)
AS (VALUES
(1, 'John'),
(2, 'Jane'),
(3, 'Joe'),
(4, 'Jim')),
submissions (submission_id, hacker_id, challenge_id, score)
AS (VALUES
(101, 1, 1, 10),
(102, 1, 1, 12),
(103, 2, 1, 11),
(104, 2, 1, 9),
(105, 2, 2, 13),
(106, 3, 1, 9),
(107, 3, 2, 12),
(108, 3, 2, 15),
(109, 4, 1, 0)),

-- from submissions table, get maximum score for each hacker-challenge pair
-- из таблицы submissions получить максимальный балл за каждую пару hacker-challenge

t1 AS (
SELECT 
   hacker_id, 
   challenge_id, 
   MAX(score) AS max_score -- выводим максимальное значение столбца score в столбец max_score
FROM submissions 
GROUP BY 1, 2 ) -- группировать по первому, затем по второму столбцу

-- inner join this with the hackers table, sum up all maximum scores, filter to exclude hackers with total score of zero, and order result by total score and hacker ID
-- внутреннее объединение с таблицей hackers, суммирование всех максимальных баллов, фильтрация для исключения хакеров с нулевым общим баллом и упорядовачение результатов по общему баллу и идентификатору хакера
-- Having это инструмент фильтрации. Он указывает на результат выполнения агрегатных функций.

SELECT 
   t1.hacker_id, 
   h.name, 
   SUM(t1.max_score) AS total_score -- в столбец total_score записываем сумму значений столбца max_score из таблицы t1
FROM t1 -- с таблицей t1
inner JOIN hackers h -- объединяем таблицу hackers
ON t1.hacker_id = h.hacker_id -- при условии, что t1.hacker_id = h.hacker_id
GROUP BY 1, 2 -- группируем по первому, затем по второму столбцу
HAVING SUM(max_score) > 0 -- при условии, что SUM(max_score) > 0
ORDER BY 3 DESC, 1 -- сортируем по убыванию по третьему столбцу, затем по первому


-- 13 упражнение

/* Напишите запрос для ранжирования оценок в следующей таблице без использования оконной функции. Если есть ничья между двумя оценками, обе должны иметь одинаковый ранг.
После ничьей следующим рангом должно быть следующее последовательное целочисленное значение. */


WITH scores (id, score)
AS (VALUES
(1, 3.50),
(2, 3.65),
(3, 4.00),
(4, 3.85),
(5, 4.00),
(6, 3.65))

-- self-join on inequality produces a table with one score and all scores as large as this joined to it, grouping by first id and score, and counting up all unique values of joined scores yields the equivalent of DENSE_RANK()
/* самообъединение по неравенству создает таблицу с одной оценкой, и все оценки такого размера присоединяются к ней, группируя по первому идентификатору и оценке и подсчитывая все уникальные значения объединенных оценок,
что дает эквивалент DENSE_RANK() */
-- SELF JOIN — используется для объединения таблицы с самой собой, как если бы это были две таблицы, из которых одна была временно переименована в инструкции SQL.

SELECT 
   s1.score, 
   COUNT(DISTINCT s2.score) AS score_rank -- количество уникальных строк в s2.score записываем в столбец score_rank
FROM scores s1 -- самооъединение с таблицей scores
JOIN scores s2 -- таблицы scores
ON s1.score <= s2.score -- при условии, что s1.score <= s2.score
GROUP BY s1.id, s1.score -- группируем по s1.id, затем по s1.score
ORDER BY 1 desc -- сортировать по убыванию по первому столбцу


-- 14 упражнение

/* В следующей таблице содержится информация о ежемесячной заработной плате для нескольких сотрудников. Напишите запрос, чтобы получить за каждый месяц совокупную сумму заработной платы сотрудника за период в 3 месяца,
исключая самый последний месяц. Результат должен быть упорядочен по возрастанию идентификатора сотрудника и месяца. */


WITH employee (id, pay_month, salary)
AS (VALUES
(1, 1, 20),
(2, 1, 20),
(1, 2, 30),
(2, 2, 30),
(3, 2, 40),
(1, 3, 40),
(3, 3, 60),
(1, 4, 60),
(3, 4, 70)),

-- add column for descending month rank (latest month = 1) for each employee
-- добавить столбец для ранга по убыванию месяца (последний месяц = 1) для каждого сотрудника

t1 AS (
SELECT *, 
   RANK() OVER (PARTITION BY id ORDER BY pay_month DESC) AS month_rank -- ранжирование данных; набор секционируется по id и сортируется по pay_month по убыванию и записывается в столбец month_rank
FROM employee )

-- filter to exclude latest month and months 5+, create cumulative salary sum using SUM() as window function, order by ID and month
-- фильтровать, чтобы исключить последний месяц и месяцы 5+, создать кумулятивную сумму зарплаты, используя SUM() в качестве оконной функции, упорядочить по идентификатору и месяцу

SELECT 
   id, 
   pay_month, 
   salary, 
   SUM(salary) OVER (PARTITION BY id ORDER BY month_rank DESC) AS cumulative_sum -- сумма зарплаты секционируется по id и сортируется по month_rank по убыванию и записывается в столбец cumulative_sum
FROM t1 
WHERE month_rank != 1 -- при условии, что month_rank != 1
AND month_rank <= 4 -- и month_rank <= 4
ORDER BY 1, 2 -- сортировать по первому столбцу, затем по второму


-- 15 упражнение

/* Напишите запрос, чтобы вернуть результаты каждой команды в таблице команд после всех матчей, отображаемых в таблице матчей. Очки начисляются следующим образом: ноль очков за поражение, одно очко за ничью и три очка за победу.
Результат должен включать название команды и очки и упорядочен по убыванию очков. В случае ничьей сортируйте по названию команды в алфавитном порядке. */


WITH teams (team_id, team_name)
AS (VALUES
(1, 'New York'),
(2, 'Atlanta'),
(3, 'Chicago'),
(4, 'Toronto'),
(5, 'Los Angeles'),
(6, 'Seattle')),
matches (match_id, host_team, guest_team, host_goals, guest_goals)
AS (VALUES
(1, 1, 2, 3, 0),
(2, 2, 3, 2, 4),
(3, 3, 4, 4, 3),
(4, 4, 5, 1, 1),
(5, 5, 6, 2, 1),
(6, 6, 1, 1, 2)),

-- add host points and guest points columns to matches table, using case-when-then to tally up points for wins, ties, and losses
-- добавить столбцы очков host и guest в таблицу матчей, используя ase-when-then, чтобы подсчитать очки за победы, ничьи и поражения

t1 AS (
SELECT 
   *, 
   CASE WHEN host_goals > guest_goals THEN 3 -- если host_goals > guest_goals, то записываем 3 в столбец host_points
        WHEN host_goals = guest_goals THEN 1 -- если host_goals = guest_goals, то записываем 1 в столбец host_points
        ELSE 0 END AS host_points, -- в остальных случаях записываем 0 в столбец host_points
   CASE WHEN host_goals < guest_goals THEN 3 -- если host_goals < guest_goals, то записываем 3 в столбец guest_points
   		WHEN host_goals = guest_goals THEN 1 -- если host_goals = guest_goals, то записываем 3 в столбец guest_points
   		ELSE 0 END AS guest_points -- в остальных случаях записываем 0 в столбец guest_points
FROM matches )

-- join result onto teams table twice to add up for each team the points earned as host team and guest team, then order as requested
-- Дважды присоедините результат к таблице команд, чтобы сложить для каждой команды очки, заработанные в качестве принимающей и гостевой команд, а затем расположите их в соответствии с заданием.

SELECT 
   t.team_name, 
   a.host_points + b.guest_points AS total_points -- в столбец total_points записываем сумму столбцов a.host_points и b.guest_points
FROM teams t -- с таблицей teams
JOIN t1 a -- объединяем таблицу t1
ON t.team_id = a.host_team -- при условии, что t.team_id = a.host_team
JOIN t1 b -- и ещё раз объединяем с таблицей t1
ON t.team_id = b.guest_team -- при условии, что t.team_id = b.guest_team
ORDER BY 2 DESC, 1 -- сортируем по убыванию по второму столбцу, затем по первому


-- 16 

-- Из следующей таблицы напишите запрос для отображения идентификатора и имени клиентов, которые купили продукты A и B, но не купили продукт C, в порядке возрастания идентификатора клиента.


WITH customers (id, name)
AS (VALUES
(1, 'Daniel'),
(2, 'Diana'),
(3, 'Elizabeth'),
(4, 'John')),
orders (order_id, customer_id, product_name)
AS (VALUES
(1, 1, 'A'),
(2, 1, 'B'),
(3, 2, 'A'),
(4, 2, 'B'),
(5, 2, 'C'),
(6, 3, 'A'), 
(7, 3, 'A'),
(8, 3, 'B'),
(9, 3, 'D'))

-- join customers and orders tables on customer ID, filtering to those who bought both products A and B, removing those who bought product C, returning ID and name columns ordered by ascending ID
/* объединените таблицы клиентов и заказов по идентификатору клиента, отфильтруйте по тем, кто купил продукты A и B, удалите тех, кто купил продукт C, верните столбцы идентификаторов и имен,
упорядоченных по возрастанию идентификатора */

SELECT DISTINCT -- выводим уникальные значения столбцов
   id, 
   name
FROM orders o -- с таблицей orders
JOIN customers c -- объединяем таблицу customers
ON o.customer_id = c.id -- при условии, что o.customer_id = c.id
WHERE customer_id IN (SELECT customer_id -- когда customer_id соответствует customer_id, которые заказали product_name = 'A'
                      FROM orders 
                      WHERE product_name = 'A') 
AND customer_id IN (SELECT customer_id -- когда customer_id соответствует customer_id, которые заказали product_name = 'B'
                    FROM orders 
                    WHERE product_name = 'B') 
AND customer_id NOT IN (SELECT customer_id -- когда customer_id не соответствует customer_id, которые заказали product_name = 'C'
                        FROM orders 
                        WHERE product_name = 'C')
ORDER BY 1 -- сортировать по первому столбцу


-- 17 

-- Напишите запрос, чтобы получить медианную широту метеостанций для каждого штата в следующей таблице с округлением до ближайшей десятой доли градуса. Обратите внимание, что в SQL нет функции MEDIAN()


WITH stations (id, city, state, latitude, longitude)
AS (VALUES
(1, 'Asheville', 'North Carolina', 35.6, 82.6),
(2, 'Burlington', 'North Carolina', 36.1, 79.4),
(3, 'Chapel Hill', 'North Carolina', 35.9, 79.1),
(4, 'Davidson', 'North Carolina', 35.5, 80.8),
(5, 'Elizabeth City', 'North Carolina', 36.3, 76.3),
(6, 'Fargo', 'North Dakota', 46.9, 96.8),
(7, 'Grand Forks', 'North Dakota', 47.9, 97.0),
(8, 'Hettinger', 'North Dakota', 46.0, 102.6),
(9, 'Inkster', 'North Dakota', 48.2, 97.6)),

-- assign latitude-ordered row numbers for each state, and get total row count for each state
-- назначить номера строк в порядке широты для каждого штата и получить общее количество строк для каждого штата

t1 AS (
SELECT 
   *, 
   ROW_NUMBER() OVER (PARTITION BY state ORDER BY latitude ASC) AS row_number_state, -- нумеруем набор, который секционируется по state и сортируется по latitude по возрастанию и записываем в столбец row_number_state
            count(*) OVER (PARTITION BY state) AS row_count -- количество строк в таблице t1 записываем в столбец row_count
FROM stations )

-- filter to middle row (for odd total row number) or middle two rows (for even total row number), then get average value of those, grouping by state
-- отфильтровать среднюю строку (для нечетного общего количества строк) или две средние строки (для четного общего количества строк), затем получить среднее значение из них, группируя по состоянию

SELECT 
   state, 
   AVG(latitude) AS median_latitude -- в столбец median_latitude записываем среднее значение latitude
FROM t1
WHERE row_number_state >= 1.0*row_count/2 -- когда row_number_state >= 1.0*row_count/2
AND row_number_state <= 1.0*row_count/2 + 1 -- и row_number_state <= 1.0*row_count/2 + 1
GROUP BY 1 -- группируем по первому столбцу


-- 18 

-- Из той же таблицы в задании 17 напишите запрос, чтобы вернуть самую удаленную пару городов для каждого штата и соответствующее расстояние (в градусах, округленное до 2 знаков после запятой) между этими двумя городами.


WITH stations (id, city, state, latitude, longitude)
AS (VALUES
(1, 'Asheville', 'North Carolina', 35.6, 82.6),
(2, 'Burlington', 'North Carolina', 36.1, 79.4),
(3, 'Chapel Hill', 'North Carolina', 35.9, 79.1),
(4, 'Davidson', 'North Carolina', 35.5, 80.8),
(5, 'Elizabeth City', 'North Carolina', 36.3, 76.3),
(6, 'Fargo', 'North Dakota', 46.9, 96.8),
(7, 'Grand Forks', 'North Dakota', 47.9, 97.0),
(8, 'Hettinger', 'North Dakota', 46.0, 102.6),
(9, 'Inkster', 'North Dakota', 48.2, 97.6)),

-- self-join on matching states and city < city (avoids identical and double-counted city pairs), pulling state, city pair, and latitude/longitude coordinates for each city
-- самообъединение при совпадении штатов и города < города (избегает идентичных и дважды учитываемых пар городов), вытягивания штата, пары городов и координат широты/долготы для каждого города

t1 AS (
SELECT 
   s1.state, 
   s1.city AS city1, 
   s2.city AS city2, 
   s1.latitude AS city1_lat, 
   s1.longitude AS city1_long, 
   s2.latitude AS city2_lat, 
   s2.longitude AS city2_long
FROM stations s1 -- самообъединение с таблицей stations
JOIN stations s2 -- таблицы stations
ON s1.state = s2.state -- при условии, что s1.state = s2.state
AND s1.city < s2.city ), -- и s1.city < s2.city

-- add a column displaying rounded Euclidean distance 
-- добавить столбец, отображающий округленное евклидово расстояние

t2 AS (
SELECT *, 
ROUND(( (city1_lat - city2_lat)^2 + (city1_long - city2_long)^2 ) ^ 0.5, 2) AS distance -- в столбец distance выводим рассчитанное евкливово расстояние, округлённое до двух занков после запятой
FROM t1 ),

-- rank each city pair by descending distance for each state
-- ранжировать каждую пару городов по убыванию расстояния для каждого штата

t3 AS (
SELECT *, RANK() OVER (PARTITION BY state ORDER BY distance DESC) AS dist_rank -- ранжирование данных; набор секционируется по state и сортируется по distance по убыванию и записывается в столбец dist_rank
FROM t2 )

-- return the city pair with maximium separation
-- вернуть пару городов с максимальным разделением

SELECT 
   state, 
   city1, 
   city2, 
   distance
FROM t3
WHERE dist_rank = 1 -- при условии, что dist_rank = 1


-- 19 

/* Напишите запрос, возвращающий среднее время цикла за каждый месяц. Время цикла — это время, прошедшее между присоединением одного пользователя и присоединением приглашенных им лиц.
Пользователи, которые присоединились без приглашения, имеют ноль в столбце «приглашенные». */


WITH users (user_id, join_date, invited_by) 
AS (VALUES 
(1, CAST('01-01-20' AS date), 0), 
(2, CAST('10-01-20' AS date), 1), 
(3, CAST('05-02-20' AS date), 2), 
(4, CAST('12-02-20' AS date), 3), 
(5, CAST('25-02-20' AS date), 2), 
(6, CAST('01-03-20' AS date), 0), 
(7, CAST('01-03-20' AS date), 4),
(8, CAST('04-03-20' AS date), 7)),

-- self-join on invited by = user ID, extract join month from inviter join date, and calculate cycle time as difference between join dates of inviter and invitee
-- самообъединение по invited = user ID, извлечение месяца присоединения из даты присоединения приглашающего и вычисление времени цикла как разницы между датами присоединения приглашающего и приглашенного

t1 AS (
SELECT 
   CAST(EXTRACT(MONTH FROM u2.join_date) AS int) AS month, -- извлекаем месяц из join_date и записываем в столбец month
   u1.join_date - u2.join_date AS cycle_time -- в столбец cycle_time записываем разность u1.join_date и u2.join_date
FROM users u1 -- самообъединение с таблицей users
JOIN users u2 -- таблицы users
ON u1.invited_by = u2.user_id ) -- при условии, что u1.invited_by = u2.user_id

-- group by join month, take average of cycle times within each month
-- сгруппировать по месяцу подключения, взять среднее время цикла в каждом месяце

SELECT 
   month, 
   AVG(cycle_time) AS cycle_time_month_avg -- в столбец cycle_time_month_avg записываем среднее значение столбца cycle_time
FROM t1
GROUP BY 1 -- группируем по первому столбцу
ORDER BY 1 -- сортируем по первому столбцу


-- 20 

/* В таблице посещаемости регистрируется количество людей, подсчитываемых в толпе каждый день, когда проводится мероприятие. Напишите запрос, чтобы вернуть таблицу, показывающую дату и количество посетителей в периоды
высокой посещаемости, определяемые как три последовательные записи (не обязательно последовательные даты) с более чем 100 посетителями. */


WITH attendance (event_date, visitors) 
AS (VALUES 
(CAST('01-01-20' AS date), 10), 
(CAST('01-04-20' AS date), 109), 
(CAST('01-05-20' AS date), 150), 
(CAST('01-06-20' AS date), 99), 
(CAST('01-07-20' AS date), 145), 
(CAST('01-08-20' AS date), 1455), 
(CAST('01-11-20' AS date), 199),
(CAST('01-12-20' AS date), 188)),

-- add row numbers to identify consecutive entries, since date column has some gaps
-- добавить номера строк, чтобы идентифицировать последовательные записи, так как в столбце даты есть пробелы

t1 AS (
SELECT *, 
   ROW_NUMBER() OVER (ORDER BY event_date) AS day_num -- нумеруем набор и сортируем по event_date
FROM attendance ),

-- filter this to exclude days with > 100 visitors
-- отфильтровать результат, чтобы исключить дни с менее, чем 100 посетителями

t2 AS (
SELECT *
FROM t1
WHERE visitors > 100 ), -- когда visitors > 100

-- self-join (inner) twice on offset = 1 day and offset = 2 days
-- самосоединение (внутреннее) дважды по смещению = 1 день и смещению = 2 дня

t3 AS (
SELECT 
   a.day_num AS day1, 
   b.day_num AS day2, 
   c.day_num AS day3
FROM t2 a -- самообъединение таблицы t2
JOIN t2 b -- с таблицей t2
ON a.day_num = b.day_num - 1 -- при смещении на 1 день
JOIN t2 c -- ещё раз самообъединение
ON a.day_num = c.day_num - 2 ) -- при смещении на 2 дня

-- pull date and visitor count for consecutive days surfaced in previous table
-- дата извлечения и количество посетителей за последовательные дни, появившиеся в предыдущей таблице

SELECT 
   event_date, 
   visitors
FROM t1
WHERE day_num IN (SELECT day1 FROM t3) -- при условии, что day_num = day1
   OR day_num IN (SELECT day2 FROM t3) -- при условии, что day_num = day2
   OR day_num IN (SELECT day3 FROM t3) -- при условии, что day_num = day3


-- 21 

-- Используя следующие две таблицы, напишите запрос, который возвращает названия и частоту покупок трех самых популярных пар товаров, которые чаще всего покупают вместе. Названия обоих продуктов должны появиться в одной колонке


WITH orders (order_id, customer_id, product_id) 
AS (VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5)),
products (id, name) 
AS (VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E')),

-- get unique product pairs from same order by self-joining orders table on order ID and product ID < product ID (avoids identical and double-counted product pairs)
-- получить уникальные пары продуктов из одного и того же заказа путем самообъединения таблицы заказов по идентификатору заказа и идентификатору продукта, который меньше идентификатора продукта (избегает идентичных пар продуктов с двойным подсчетом)

t1 AS (
SELECT 
   o1.product_id AS prod_1, 
   o2.product_id AS prod_2
FROM orders o1 -- самообъединение таблицы orders
JOIN orders o2 -- с таблицей orders
ON o1.order_id = o2.order_id -- при условии o1.order_id = o2.order_id
AND o1.product_id < o2.product_id ), -- и o1.order_id < o2.order_id

-- join products table onto this to get product names, concatenate to get product pairs in one column
-- присоедините к результату таблицу продуктов, чтобы получить названия продуктов и объедините, чтобы получить пары продуктов в одном столбце
-- CONCAT принимает переменное количество строковых аргументов и объединяет их в одну строку. Функция CONCAT неявно преобразует все аргументы в строковые типы перед объединением. CONCAT неявно преобразует значения NULL в пустые строки.

t2 AS (
SELECT CONCAT(p1.name, ' ', p2.name) AS product_pair -- в столбец product_pair выводим объединённые с строку названия пар продуктов
FROM t1 -- с таблицей t1
JOIN products p1 -- объединяем таблицу products
ON t1.prod_1 = p1.id -- при условии t1.prod_1 = p1.id
JOIN products p2 -- самообъединяем с таблицей products
ON t1.prod_2 = p2.id ) -- при условии t1.prod_2 = p2.id

-- grouping by product pair, return top 3 entries sorted by purchase frequency
-- группировка по паре продуктов, возврат первых 3 записей, отсортированных по частоте покупок

SELECT *, 
   COUNT(*) AS purchase_freq -- количество строк в таблице t2 записываем в столбец purchase_freq
FROM t2
GROUP BY 1 -- группируем по первому столбцу
ORDER BY 2 DESC -- сортируем по убыванию по второму столбцу
LIMIT 3 -- выводим 3 первых значения


-- 22 

-- Из следующей таблицы, обобщающей результаты исследования, рассчитайте средний эффект лечения, а также верхнюю и нижнюю границы 95% доверительного интервала. Округлите эти числа до 3 знаков после запятой.


WITH study (participant_id, assignment, outcome) 
AS (VALUES 
(1, 0, 0),
(2, 1, 1),
(3, 0, 1),
(4, 1, 0),
(5, 0, 1),
(6, 1, 1),
(7, 0, 0),
(8, 1, 1),
(9, 1, 1)),

-- get average outcomes, standard deviations, and group sizes for control and treatment groups
-- получить средние результаты, стандартные отклонения и размеры групп для контрольной и лечебной групп
-- Функция STDDEV () используется для вычисления статистической информации для указанного числового поля в запросе

control AS (
SELECT 
   AVG(outcome) AS avg_outcome, -- среднее значение outcome
   STDDEV(outcome) AS std_dev, -- стандартное отклонение outcome
   COUNT(*) AS group_size -- количество всех строк 
FROM study
WHERE assignment = 0 ), -- при условии, что assignment = 0
treatment AS (
SELECT 
   AVG(outcome) AS avg_outcome, -- среднее значение outcome
   STDDEV(outcome) AS std_dev, -- стандартное отклонение outcome
   COUNT(*) AS group_size -- количество всех строк 
FROM study
WHERE assignment = 1 ), -- при условии, что assignment = 1

-- get average treatment effect size
-- получить средний размер лечебного эффекта

effect_size AS (
SELECT t.avg_outcome - c.avg_outcome AS effect_size 
FROM control c, treatment t ),

-- construct 95% confidence interval using z* = 1.96 and magnitude of individual standard errors [ std dev / sqrt(sample size) ]
-- построить 95% доверительный интервал, используя z* = 1,96 и величину отдельных стандартных ошибок [ std dev / sqrt(размер выборки) ]

conf_interval AS (
SELECT 1.96 * (t.std_dev^2 / t.group_size 
             + c.std_dev^2 / c.group_size)^0.5 AS conf_int
FROM treatment t, control c )
SELECT round(es.effect_size, 3) AS point_estimate, 
        round(es.effect_size - ci.conf_int, 3) AS lower_bound, -- округление до 3 знаков после запятой
        round(es.effect_size + ci.conf_int, 3) AS upper_bound -- округление до 3 знаков после запятой
FROM effect_size es, conf_interval ci


-- 23 

/* В следующей таблице показана месячная заработная плата работника за первые девять месяцев данного года. На основе этого напишите запрос, чтобы вернуть таблицу, которая отображает для каждого месяца в первой половине года
скользящую сумму заработной платы сотрудника за этот месяц и следующие два месяца, упорядоченные в хронологическом порядке. */


WITH salaries (month, salary) 
AS (VALUES 
(1, 2000),
(2, 3000),
(3, 5000),
(4, 4000),
(5, 2000),
(6, 1000),
(7, 2000),
(8, 4000),
(9, 5000))

-- self-join to match month n with months n, n+1, and n+2, then sum salary across those months, filter to first half of year, and sort
-- самообъединение, чтобы сопоставить месяц n с месяцами n, n+1 и n+2, затем просуммировать зарплату за эти месяцы, отфильтровать по первому полугодию и отсортировать

SELECT 
   s1.month, 
   SUM(s2.salary) AS salary_3mos -- в столбец salary_3mos записываем сумму salary
FROM salaries s1 -- самообъединение таблицы salaries
JOIN salaries s2 -- с таблицей salaries
ON s1.month <= s2.month -- при условии, что s1.month <= s2.month
AND s1.month > s2.month - 3 -- и s1.month > s2.month
GROUP BY 1 -- группируем по первому столбцу
HAVING s1.month < 7 -- когда s1.month < 7
ORDER BY 1 -- сортируем по первому столбцу


-- 24 

-- Из заданных таблиц trips и users для службы такси напишите запрос, возвращающий процент отмен в первые два дня октября, округленный до двух знаков после запятой, для поездок без забаненных пассажиров или водителей.


WITH trips (trip_id, rider_id, driver_id, status, request_date)
AS (VALUES
(1, 1, 10, 'completed', CAST('2020-10-01' AS date)),
(2, 2, 11, 'cancelled_by_driver', CAST('2020-10-01' AS date)),
(3, 3, 12, 'completed', CAST('2020-10-01' AS date)),
(4, 4, 10, 'cancelled_by_rider', CAST('2020-10-02' AS date)),
(5, 1, 11, 'completed', CAST('2020-10-02' AS date)),
(6, 2, 12, 'completed', CAST('2020-10-02' AS date)),
(7, 3, 11, 'completed', CAST('2020-10-03' AS date))),
users (user_id, banned, type)
AS (VALUES
(1, 'no', 'rider'),
(2, 'yes', 'rider'),
(3, 'no', 'rider'),
(4, 'no', 'rider'),
(10, 'no', 'driver'),
(11, 'no', 'driver'),
(12, 'no', 'driver'))

-- filter trips table to exclude banned riders and drivers, then calculate cancellation rate as 1 - fraction of trips completed, filtering to first two days of the month
-- Отфильтровать таблицу поездок, чтобы исключить забаненных пассажиров и водителей, а затем рассчитать коэффициент отмены как 1 – доля завершенных поездок; отфильтровать по первым двум дням месяца.

SELECT 
   request_date, 
   1 - AVG(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS cancel_rate -- рассчитать коэффициент отмены вычитанием из единицы среднего значения поездок, когда status = 'completed'
FROM trips
WHERE rider_id NOT IN (SELECT user_id -- когда rider_id не содержаться в списке забаненных пассажиров
                       FROM users
                       WHERE banned = 'yes' )
AND driver_id NOT IN (SELECT user_id -- и когда driver_id не содержаться в списке забаненных водителей
                      FROM users
                      WHERE banned = 'yes' )
GROUP BY 1 -- группировать по первому столбцу
HAVING EXTRACT(DAY FROM request_date) <= 2 -- когда извлечённых из request_date день <= 2


-- 25 

/* Из следующей таблицы активности пользователей напишите запрос, чтобы вернуть долю пользователей, которые остаются (показывают некоторую активность) через заданное количество дней после присоединения.
По соглашению пользователи считаются активными в день их присоединения (день 0). */

WITH users (user_id, action_date, action) 
AS (VALUES 
(1, CAST('01-01-20' AS date), 'Join'), 
(1, CAST('01-02-20' AS date), 'Access'), 
(2, CAST('01-02-20' AS date), 'Join'), 
(3, CAST('01-02-20' AS date), 'Join'), 
(1, CAST('01-03-20' AS date), 'Access'), 
(3, CAST('01-03-20' AS date), 'Access'),
(1, CAST('01-04-20' AS date), 'Access')),

-- get join dates for each user
-- получить даты присоединения для каждого пользователя

join_dates AS (
SELECT 
   user_id, 
   action_date AS join_date
FROM users
WHERE action = 'Join' ), -- при условии, что action = 'Join'

-- create vector containing all dates in date range

date_vector AS (
SELECT CAST(GENERATE_SERIES(MIN(action_date), MAX(action_date), 
            '1 day'::interval) AS date) AS dates
FROM users ),

-- cross join to get all possible user-date combinations
-- создать вектор, содержащий все даты в диапазоне дат

all_users_dates AS (
SELECT DISTINCT -- вывести уникальные значения
   user_id, 
   d.dates
FROM users
CROSS JOIN date_vector d ), -- перекрёстное объединение с date_vector

-- left join users table onto all user-date combinations on matching user ID and date (null on days where user didn't engage), join onto this each user's signup date, exclude user-date combinations falling before user signup
/* левое объединение таблицы пользователей и всех комбинаций user-date при совпадении идентификатора пользователя и даты (null для дней, когда пользователь не участвовал), объединить результат с датой регистрации 
каждого пользователя, исключить комбинации user-date, предшествующие регистрации пользователя */

t1 AS (
SELECT 
   a.dates - c.join_date AS day_no, 
   b.user_id
FROM all_users_dates a -- левое объединение с таблицей all_users_dates
LEFT JOIN users b -- таблицы users
ON a.user_id = b.user_id -- при условии, что a.user_id = b.user_id
AND a.dates = b.action_date -- и при условии, что a.dates = b.action_date
JOIN join_dates c -- и объединение с таблицей join_dates
ON a.user_id = c.user_id -- при условии, что a.user_id = c.user_id
WHERE a.dates - c.join_date >= 0 ) -- когда разница a.dates и c.join_date >= 0

-- grouping by days since signup, count (non-null) user IDs as active users, total users, and the quotient as retention rate
-- группировка по дням с момента регистрации, подсчет (non-null) идентификаторов пользователей как активных пользователей, общее количество пользователей и коэффициент удержания

SELECT 
   day_no, 
   COUNT(*) AS n_total, -- количество всех строк
   COUNT(DISTINCT user_id) AS n_active, -- количество уникальных значений
   ROUND(1.0*COUNT(DISTINCT user_id)/COUNT(*), 2) AS retention -- коэффициент ужержания округляем до 3 знаков после запятой
FROM t1
GROUP BY 1 -- группируем по первому столбцу
