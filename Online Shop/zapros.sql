SELECT streetaddr,starttime,endtime
FROM ServicePoint
WHERE ServicePoint.city IN (SELECT Address.city FROM Address WHERE userid=5);

SELECT *
FROM Product
WHERE type='laptop';

SELECT SUM(quantity) AS totalQuantity
FROM Save_to_Shopping_Cart
WHERE Save_to_Shopping_Cart.pid IN (SELECT Product.pid FROM Product WHERE sid=8);

SELECT name, streetaddr, city
FROM Address
WHERE addrid IN (SELECT addrid FROM Deliver_To WHERE TimeDelivered = '2017-02-17');

 SELECT *
 FROM Comments
 WHERE pid = 12345678; 
 
