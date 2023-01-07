DROP DATABASE DBMS_PROJECT;
Create Database DBMS_PROJECT;
USE `dbms_project`;

CREATE TABLE `billinginformation` (
  `BillNumber` int(11) NOT NULL AUTO_INCREMENT,
  `IncludedData` int(11) NOT NULL,
  `DataUsed` int(11) NOT NULL,
  `BalancedData` int(11) NOT NULL,
  `Tax` double NOT NULL,
  PRIMARY KEY (`BillNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
LOCK TABLES `billinginformation` WRITE;
INSERT INTO `billinginformation` VALUES (1,50,40,10,15.1),(2,100,60,40,20.3),(3,200,100,100,30.3),(4,500,200,300,40.3),(5,500,100,400,50),(6,1000,100,900,70),(7,800,300,500,60),(8,1200,400,800,100),(9,1500,400,1100,100),(10,1500,600,900,300),(11,1500,800,700,180),(12,2000,900,1100,180),(13,2000,500,1500,170),(14,2000,500,1500,200),(15,2000,1800,200,200);
UNLOCK tables;

CREATE TABLE `phonenumber` (
  `AccountNumber` int(11) NOT NULL,
  `PhoneNumber` int(11) NOT NULL,
  `PhoneBillNumber` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`AccountNumber`),
  KEY `PhoneBillNumber_idx` (`PhoneBillNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
LOCK TABLES `phonenumber` WRITE;
INSERT INTO `phonenumber` VALUES (10,1235465768,1),(11,1675849305,3),(12,1345267859,4),(13,1578893409,5),(14,1876509876,7),(15,1657483948,8),(16,1236564789,9),(17,1784967348,10),(18,1758483934,11),(19,1745889839,12);
UNLOCK TABLES;

CREATE TABLE `callrecords` (
  `CallId` int(11) NOT NULL AUTO_INCREMENT,
  `CallStartTime` time(6) NOT NULL,
  `CallEndTime` time(6) NOT NULL,
  `CallDuration` time(6) NOT NULL,
  `CallAccountNumber` int(11) NOT NULL,
  PRIMARY KEY (`CallId`),
  KEY `CallAccountNumber_idx` (`CallAccountNumber`),
  CONSTRAINT `CallAccountNumber` FOREIGN KEY (`CallAccountNumber`) REFERENCES `phonenumber` (`AccountNumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
LOCK TABLES `callrecords` WRITE;
INSERT INTO `callrecords` VALUES (1,'12:20:20.000000','12:21:20.000000','00:01:00.000000',10),(2,'11:23:24.000000','15:40:30.000000','04:17:06.000000',10),(3,'08:30:10.000000','08:32:20.000000','00:02:10.000000',11),(4,'21:45:30.000000','21:50:34.000000','00:05:04.000000',14),(5,'12:32:21.000000','12:34:20.000000','00:01:59.000000',10),(6,'19:10:13.000000','19:55:20.000000','00:45:07.000000',10),(7,'20:30:25.000000','21:21:20.000000','00:50:55.000000',10),(8,'13:40:56.000000','14:34:20.000000','00:53:24.000000',10),(9,'16:20:20.000000','18:21:20.000000','02:01:00.000000',10),(10,'17:42:59.000000','18:21:20.000000','00:38:21.000000',11),(12,'23:12:20.000000','23:33:45.000000','00:21:25.000000',11),(13,'17:15:20.000000','17:50:20.000000','00:35:00.000000',11),(14,'16:35:13.000000','16:59:59.000000','00:24:46.000000',10),(15,'14:36:54.000000','14:40:23.000000','00:03:29.000000',12),(16,'11:52:56.000000','12:21:20.000000','00:28:24.000000',12),(17,'09:31:43.000000','10:21:28.000000','00:49:45.000000',13),(18,'06:14:54.000000','06:57:56.000000','00:43:02.000000',13),(19,'22:48:13.000000','23:21:13.000000','00:33:00.000000',19),(20,'14:51:54.000000','14:59:23.000000','00:07:29.000000',17);
UNLOCK TABLES;

CREATE TABLE `department` (
  `DepartmentDId` int(11) NOT NULL,
  `DepartmentName` varchar(45) NOT NULL,
  `Salary` int(11) NOT NULL,
  PRIMARY KEY (`DepartmentDId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `department` WRITE;
INSERT INTO `department` VALUES (1,'Information Technology',10000),(2,'Sales & Marketing',5000),(3,'Finance',2500),(4,'Human Resource',7500),(5,'Customer Care',1000);
UNLOCK TABLES;

CREATE TABLE `employee` (
  `EmployeeId` int(11) NOT NULL,
  `Employee_Name` varchar(45) NOT NULL,
  `SSN` varchar(45) NOT NULL,
  `Age` int(11) NOT NULL,
  `DepartmentId` int(11) DEFAULT NULL,
  `Salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`EmployeeId`),
  KEY `EmployeeDepartmentId_idx` (`DepartmentId`),
  CONSTRAINT `DepartmentId` FOREIGN KEY (`DepartmentId`) REFERENCES `department` (`DepartmentDId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `employee` WRITE;
INSERT INTO `employee` VALUES (1,'Ojas Phansekar','123456789',24,1,1000),(2,'Shreyas Kalayanaraman','245987675',24,1,1000),(3,'Saurabh Kulkarni','734756953',24,1,1000),(4,'Vivek Shetye','572364526',26,1,1000),(5,'Mihir Patil','238745784',27,1,1000),(6,'Karan Thevar','968374657',28,4,7500),(7,'Chetan Mistry','623784983',30,4,7500),(8,'Shantanu Sawant','527473298',24,4,7500),(9,'Pooja Patil','286436778',24,4,7500),(10,'Kalpita Malvankar','863476236',34,4,7500),(11,'Vaibhav Parkar','123456789',24,2,5000),(12,'Sayali Sakhalkar','674378987',24,2,5000),(13,'Khushi Chavan','652134897',45,2,5000),(14,'Pratik Patre','677435432',24,2,5000),(15,'Pushkar','564321879',43,2,5000),(16,'Tushar Gupta','444777651',24,5,10000),(17,'Pranav Swaminathan','990077663',34,3,2500),(18,'Victor','563477778',44,3,2500),(19,'Yusuf Ozbek','995912563',45,3,2500),(20,'Sudharshan Poojary','763459876',24,3,2500),(21,'Parth Mehta','458787654',56,5,10000),(22,'Devdip Sen','458787654',56,5,10000),(23,'Devdip Sen','458787654',56,5,10000),(24,'Devdip Sen','458787654',56,5,10000),(26,'Devdip Sen','458787654',56,5,10000),(27,'Devdip Sen','458787654',56,5,10000),(28,'Alpana Sharan','987787654',45,3,2500),(29,'Priyanka Singh','238787654',43,3,2500),(30,'Ranjani Iyer','777787654',34,2,5000),(31,'Amlan Bhuyan','555787654',23,4,7500),(32,'Manoj Prabhakar','444787654',21,1,1000),(33,'Raj Phadke','999787654',56,5,10000),(34,'Priya Yadav','228787654',33,1,1000),(35,'Sayali Joshi','158787654',22,4,7500),(36,'Pranav Patil','658787654',25,5,10000),(37,'Rohit Patil','222787654',45,3,2500),(38,'Swanand Sapre','111787654',65,5,10000);
UNLOCK TABLES;

CREATE TABLE `salesperson` (
  `SalesPersonId` int(11) NOT NULL,
  `IdEmployeeSalesPerson` int(11) NOT NULL,
  PRIMARY KEY (`SalesPersonId`,`IdEmployeeSalesPerson`),
  KEY `IdEmployeeSalesPerson_idx` (`IdEmployeeSalesPerson`),
  CONSTRAINT `IdEmployeeSalesPerson` FOREIGN KEY (`IdEmployeeSalesPerson`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `salesperson` WRITE;
INSERT INTO `salesperson` VALUES (1,5),(2,6),(3,7),(4,8);
UNLOCK TABLES;

CREATE TABLE `customer` (
  `CustomerId` int(11) NOT NULL,
  `CustomerName` varchar(45) NOT NULL,
  `Sex` char(1) NOT NULL,
  `Age` int(11) NOT NULL,
  `DateOfBirth` date NOT NULL,
  `SocialSecurityNumber` int(11) NOT NULL,
  `CustomerSalesPersonId` int(11) NOT NULL,
  PRIMARY KEY (`CustomerId`),
  KEY `CustomerSalesPersonId_idx` (`CustomerSalesPersonId`),
  CONSTRAINT `CustomerSalesPersonId` FOREIGN KEY (`CustomerSalesPersonId`) REFERENCES `salesperson` (`SalesPersonId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `customer` WRITE;
INSERT INTO `customer` VALUES (1,'Jishnu Vasudevan','M',24,'1993-12-28',232498675,1),(2,'Harsh Shah','M',24,'1993-09-12',456498675,2),(3,'Rachana Rambhad','F',24,'1993-08-19',543498675,3),(4,'Lagan Gupta','F',24,'1993-08-08',765498675,4),(5,'Neha Verma','F',24,'1993-08-27',987498675,1),(6,'Aniel Patel','M',24,'1993-11-28',235468675,2),(7,'Anubhav Gupta','M',27,'1990-12-28',555698675,3),(8,'Aditya Joshi','M',24,'1993-10-28',232434575,4),(9,'Parnal Dighe','F',24,'1993-09-28',232498765,1),(10,'Dharit Shah','M',24,'1993-12-27',123498675,2),(11,'Girish Sanai','M',24,'1993-07-22',645498675,3),(12,'Kal Bugrara','M',57,'1960-12-28',145498675,4),(13,'Neeraj Rajput','M',27,'1990-10-28',232555675,1),(14,'Shruti Mehta','F',26,'1991-12-17',232444375,2),(15,'Sameer Goel','M',28,'1989-12-30',276578675,3),(16,'Vijayshree Uppili','F',26,'1991-08-23',654498675,4),(17,'Rohit Kamble','M',24,'1993-06-28',453498675,1),(18,'Priyanka Desai','F',26,'1991-04-23',189498675,2),(19,'Komal Shirodkar','F',26,'1991-02-27',678498675,3),(20,'Simmah Kazi','F',22,'1995-12-28',232834675,4);
UNLOCK TABLES;

DROP TABLE IF EXISTS `displaycallrecords`;
/*SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;*/
CREATE VIEW `displaycallrecords` AS SELECT 
 1 AS `CallId`,
 1 AS `CallStartTime`,
 1 AS `CallEndTime`,
 1 AS `CallDuration`,
 1 AS `CallAccountNumber`;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `displaydepartment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE VIEW `displaydepartment` AS SELECT 
 1 AS `EmployeeId`,
 1 AS `Employee_Name`,
 1 AS `DepartmentName`;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `displayorderstatus`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE VIEW `displayorderstatus` AS SELECT 
 1 AS `CustomerId`,
 1 AS `CustomerName`,
 1 AS `orderstatus`;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `displayphonenumber`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE VIEW `displayphonenumber` AS SELECT 
 1 AS `CustomerId`,
 1 AS `CustomerName`,
 1 AS `simnumber`,
 1 AS `PhoneNumber`;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `displayplans`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE VIEW `displayplans` AS SELECT 
 1 AS `PlanId`,
 1 AS `Data`,
 1 AS `Talktime`,
 1 AS `TextMessages`;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `displaysalespersonalloted`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE VIEW `displaysalespersonalloted` AS SELECT 
 1 AS `CustomerName`,
 1 AS `SalesPersonAlloted`;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `displaytrackingstatus`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE VIEW `displaytrackingstatus` AS SELECT 
 1 AS `customername`,
 1 AS `trackingid`,
 1 AS `trackingstatus`;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `displayworklocation`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE VIEW `displayworklocation` AS SELECT 
 1 AS `EmployeeId`,
 1 AS `Employee_Name`,
 1 AS `locationname`;
SET character_set_client = @saved_cs_client;


CREATE TABLE `worklocation` (
  `LocationId` int(11) NOT NULL,
  `LocationName` varchar(45) NOT NULL,
  `NumberOfEmployees` int(11) NOT NULL,
  PRIMARY KEY (`LocationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `worklocation` WRITE;
INSERT INTO `worklocation` VALUES (1,'Seattle',5),(2,'Washington DC',5),(3,'New York',5),(4,'Boston',5);
UNLOCK TABLES;

CREATE TABLE `employeeworklocation` (
  `WorkEmployeeId` int(11) NOT NULL,
  `LocationId` int(11) NOT NULL,
  KEY `WorkEmployeeId_idx` (`WorkEmployeeId`),
  KEY `LocationId_idx` (`LocationId`),
  CONSTRAINT `LocationId` FOREIGN KEY (`LocationId`) REFERENCES `worklocation` (`LocationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `WorkEmployeeId` FOREIGN KEY (`WorkEmployeeId`) REFERENCES `employee` (`EmployeeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `employeeworklocation` WRITE;
INSERT INTO `employeeworklocation` VALUES (1,2),(2,4),(3,3),(4,1),(5,2),(6,4),(7,3),(8,1),(9,2),(10,4),(11,3),(12,1),(13,2),(14,4),(15,3),(16,1),(17,2),(18,4),(19,3),(20,1);
UNLOCK TABLES;

CREATE TABLE `orders` (
  `OrderId` int(11) NOT NULL,
  `OrderType` varchar(45) NOT NULL,
  `OrderStatus` varchar(45) NOT NULL,
  `OrderCustomerId` int(11) NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `OrderCustomerId_idx` (`OrderCustomerId`),
  CONSTRAINT `OrderCustomerId` FOREIGN KEY (`OrderCustomerId`) REFERENCES `customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `orders` WRITE;
INSERT INTO `orders` VALUES (1,'2 day shipping','Shipped',1),(2,'Priority Shipping','Partially Shipped',2),(3,'Standard','Payment Incomplete',3),(4,'2 day shipping','Order Cancelled',4),(5,'Standard','Pending',5),(6,'Priority Shipping','Refund Initiated',6),(7,'2 day shipping','Order Cancelled',7),(8,'Standard','Pending',8),(9,'Priority Shipping','Partially Shipped',9),(10,'2 day shipping','Shipped',10),(11,'Standard','Order Cancelled',11),(12,'Priority Shipping','Partially Shipped',12),(13,'2 day shipping','Payment Incomplete',13),(14,'Standard','Shipped',14),(15,'Priority Shipping','On The way',15),(16,'2 day shipping','Order Cancelled',16),(17,'Standard','Order Decilned',17),(18,'Priority Shipping','Refund Initiated',18),(19,'2 day shipping','Pending',19),(20,'Standard','On The way',20);
UNLOCK TABLES;

CREATE TABLE `planinclusions` (
  `PlanId` int(11) NOT NULL,
  `Data` varchar(45) NOT NULL,
  `Talktime` varchar(45) NOT NULL,
  `TextMessages` varchar(45) NOT NULL,
  PRIMARY KEY (`PlanId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `planinclusions` WRITE;
INSERT INTO `planinclusions` VALUES (1,'500MB','60 Minutes','100'),(2,'500MB','120 Minutes','200'),(3,'500MB','180 Minutes','300'),(4,'500MB','240 Minutes','400'),(5,'500MB','300 Minutes','500'),(6,'1GB','360 Minutes','600'),(7,'1GB','420 Minutes','700'),(8,'1GB','480 Minutes','800'),(9,'1GB','540 Minutes','900'),(10,'1GB','600 Minutes','1000'),(11,'1.5 GB','660 Minutes','1100'),(12,'1.5 GB','720 Minutes','1200'),(13,'1.5 GB','780 Minutes','1300'),(14,'1.5 GB','840 Minutes','1400'),(15,'1.5 GB','900 Minutes','1500'),(16,'2 GB','960 Minutes','Unlimited'),(17,'2 GB','1020 Minutes','Unlimited'),(18,'2 GB','1080 Minutes','Unlimited'),(19,'2 GB','1140 Minutes','Unlimited'),(20,'2 GB','1200 Minutes','Unlimited');
UNLOCK TABLES;

CREATE TABLE `plans` (
  `PlansId` int(11) NOT NULL,
  `PlansType` varchar(45) NOT NULL,
  `PlanName` varchar(45) NOT NULL,
  `PlanInclusionId` int(11) NOT NULL,
  PRIMARY KEY (`PlansId`),
  KEY `PlanInclusionId_idx` (`PlanInclusionId`),
  CONSTRAINT `PlanInclusionId` FOREIGN KEY (`PlanInclusionId`) REFERENCES `planinclusions` (`PlanId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `plans` WRITE;
INSERT INTO `plans` VALUES (1,'Prepaid','Basic Plan',1),(2,'Prepaid','Every Minute Counts',2),(3,'Postpaid','Family',3),(4,'Postpaid','Enjoy Data',4),(5,'Postpaid','Finger tips',5),(6,'Prepaid','Talk For Hours',6),(7,'Postpaid','Do not disturb',7),(8,'Prepaid','Enjoy surfing',8),(9,'Prepaid','Continuous Texting',18),(10,'Postpaid','Powerful Speed',20);
UNLOCK TABLES;

CREATE TABLE `salary` (
  `EmployeeId` int(11) NOT NULL,
  `EmployeeName` varchar(45) NOT NULL,
  `DepartmentId` int(11) DEFAULT NULL,
  `Salary` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeId`),
  KEY `DepartmentId_idx` (`DepartmentId`),
  KEY `Salary_idx` (`Salary`),
  CONSTRAINT `fk_DepartmentId` FOREIGN KEY (`DepartmentId`) REFERENCES `employee` (`DepartmentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `salary` WRITE;
INSERT INTO `salary` VALUES (27,'Devdip Sen',5,10000),(28,'Alpana Sharan',3,2500),(29,'Priyanka Singh',3,2500),(30,'Ranjani Iyer',2,5000),(31,'Amlan Bhuyan',4,7500),(32,'Manoj Prabhakar',1,1000),(33,'Raj Phadke',5,10000),(34,'Priya Yadav',1,1000),(35,'Sayali Joshi',4,7500),(36,'Pranav Patil',5,10000),(37,'Rohit Patil',3,2500),(38,'Swanand Sapre',5,10000);
UNLOCK TABLES;

CREATE TABLE `simdata` (
  `SimNumber` bigint(16) NOT NULL,
  `SimType` varchar(45) NOT NULL,
  `SimCustomerId` int(11) NOT NULL,
  `SimAccountNumber` int(11) NOT NULL,
  `SimPlanNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`SimNumber`),
  KEY `SimCustomerId_idx` (`SimCustomerId`),
  KEY `SimAccountNumber_idx` (`SimAccountNumber`),
  KEY `SimPlanNumber_idx` (`SimPlanNumber`),
  CONSTRAINT `SimAccountNumber` FOREIGN KEY (`SimAccountNumber`) REFERENCES `phonenumber` (`AccountNumber`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `SimCustomerId` FOREIGN KEY (`SimCustomerId`) REFERENCES `customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `SimPlanNumber` FOREIGN KEY (`SimPlanNumber`) REFERENCES `plans` (`PlansId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `simdata` WRITE;
INSERT INTO `simdata` VALUES (1234567890123460,'Postpaid',2,19,3),(1234567890123461,'Prepaid',16,10,1),(1234567890123462,'Postpaid',14,12,3),(1234567890123463,'Postpaid',1,14,5),(1234567890123464,'Prepaid',12,16,8),(1234567890123465,'Postpaid',13,11,7),(1234567890123466,'Prepaid',15,13,9),(1234567890123467,'Postpaid',10,18,10),(1234567890123468,'Postpaid',7,15,4),(1234567890123469,'Prepaid',5,17,6);
UNLOCK TABLES;

CREATE TABLE `tracking` (
  `TrackingId` int(11) NOT NULL,
  `TrackingStatus` varchar(45) NOT NULL,
  `TrackingOrderId` int(11) NOT NULL,
  PRIMARY KEY (`TrackingId`),
  KEY `TrackingOrderId_idx` (`TrackingOrderId`),
  CONSTRAINT `TrackingOrderId` FOREIGN KEY (`TrackingOrderId`) REFERENCES `orders` (`OrderId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `tracking` WRITE;
INSERT INTO `tracking` VALUES (1,'On the way',10),(2,'Arrived to courier service',9),(3,'Near by closest dispatch location',14),(4,'Arrived to courier service',16),(5,'Arrived to courier service',17),(6,'On the way',19),(7,'Near by dispatch location',7),(8,'Arriving Tomorrow',2),(9,'Arriving Today',13);
UNLOCK TABLES;

DROP PROCEDURE IF EXISTS `enterBillinginformation`;
SET @saved_cs_client      = @@character_set_client;
SET @saved_cs_results     = @@character_set_results;
SET @saved_col_connection = @@collation_connection;
SET character_set_client  = utf8;
SET character_set_results = utf8;
SET collation_connection  = utf8_general_ci;
SET @saved_sql_mode       = @@sql_mode;