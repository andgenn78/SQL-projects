INSERT INTO buyer
SELECT * FROM seller
WHERE userid IN (SELECT userid FROM users WHERE name LIKE 'A%');

UPDATE Orders
SET paymentState = 'Unpaid'
WHERE creationTime > '2017-01-01' AND totalAmount > 50;

UPDATE address
SET name = 'Awesome Lady', contactPhoneNumber ='1234567'
WHERE province = 'Quebec' AND city = 'Montreal';

DELETE FROM save_to_shopping_cart
WHERE addTime < '2017-01-01';

CREATE VIEW Products_Above_Average_Price AS
SELECT pid, name, price 
FROM Product
WHERE price > (SELECT AVG(price) FROM Product);

select * from products_above_average_price;

UPDATE Products_Above_Average_Price
SET price = 1
WHERE name = 'GoPro HERO5';

CREATE VIEW Product_Sales_For_2016 AS
SELECT pid, name, price
FROM Product
WHERE pid IN (SELECT pid FROM OrderItem WHERE itemid IN 
              (SELECT itemid FROM Contain WHERE orderNumber IN
               (SELECT orderNumber FROM Payment WHERE payTime > '2016-01-01' AND payTime < '2016-12-31')
              )
             );

SELECT * FROM product_sales_for_2016;

UPDATE product_sales_for_2016
SET price = 2
WHERE name = 'GoPro HERO5';

DROP TABLE Save_to_Shopping_Cart;
CREATE TABLE Save_to_Shopping_Cart
(
    userid INT NOT NULL
    ,pid INT NOT NULL
    ,addTime DATE
    ,quantity INT
    ,PRIMARY KEY (userid,pid)
    ,FOREIGN KEY(userid) REFERENCES Buyer(userid)
    ,FOREIGN KEY(pid) REFERENCES Product(pid)
    ,CHECK (quantity <= 10 OR addTime > '2017-01-01')
);

INSERT INTO Save_to_Shopping_Cart VALUES(18,67890123,'2016-11-23',9);
INSERT INTO Save_to_Shopping_Cart VALUES(24,67890123,'2017-02-22',8);
INSERT INTO Save_to_Shopping_Cart VALUES(5,56789012,'2016-10-17',11);

DROP VIEW Product_Sales_For_2016;

DROP TABLE Contain;
CREATE TABLE Contain
(
    orderNumber INT NOT NULL
    ,itemid INT NOT NULL
    ,quantity INT CHECK(quantity > 0 AND quantity <= 10)
    ,PRIMARY KEY (orderNumber,itemid)
    ,FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber)
    ,FOREIGN KEY(itemid) REFERENCES OrderItem(itemid)
);

INSERT INTO Contain VALUES (76023921,23543245,11);
INSERT INTO Contain VALUES (23924831,65738929,8);
