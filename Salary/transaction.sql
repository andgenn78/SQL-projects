CREATE TABLE Employee( 
  Employee_Id NUMBER(6), 
  First_Name VARCHAR2(25), 
  Last_Name VARCHAR2(25), 
  Hire_Date DATE, 
  City VARCHAR2(25), 
  State VARCHAR2(25), 
  CONSTRAINT EMPLOYEE_PK PRIMARY KEY (Employee_Id));

  CREATE TABLE Department( 
  Department_Id NUMBER, 
  Department_Name VARCHAR2(30), 
  CONSTRAINT DEPARTMENT_PK PRIMARY KEY (Department_Id) 
  );

  CREATE TABLE AccountDetails( 
  Account_Id NUMBER, 
  Bank_Name VARCHAR2(50), 
  Account_Number VARCHAR2(50), 
  Employee_Id NUMBER, 
  CONSTRAINT Account_PK PRIMARY KEY (Account_Id), 
  FOREIGN KEY (Employee_Id) 
        REFERENCES Employee(Employee_Id) 
  );

  CREATE TABLE Salary( 
  Salary_Id NUMBER, 
  Gross_Salary NUMBER, 
  Hourly_Pay NUMBER, 
  State_Tax NUMBER, 
  Federal_Tax NUMBER, 
  Account_Id NUMBER, 
  CONSTRAINT SALARY_PK PRIMARY KEY (Salary_Id), 
  FOREIGN KEY (Account_Id) 
        REFERENCES ACCOUNTDETAILS(Account_Id) 
  );

  CREATE TABLE Project( 
  Project_Id NUMBER, 
  Project_Name VARCHAR2(50), 
  Project_Description VARCHAR2(50), 
  CONSTRAINT Project_PK PRIMARY KEY (Project_Id) 
  );

  CREATE TABLE DepartmentProject( 
  Department_Id NUMBER, 
  Project_Id NUMBER, 
  CONSTRAINT DEPTPROJECT_PK PRIMARY KEY (Department_Id,Project_Id), 
  FOREIGN KEY (Department_Id) 
        REFERENCES Department(Department_Id), 
  FOREIGN KEY (Project_Id) 
        REFERENCES Project(Project_Id) 
  );

  CREATE TABLE Education( 
  Education_Id NUMBER, 
  Employee_Id NUMBER, 
  Degree VARCHAR(30), 
  Graduation_Year NUMBER(4), 
  CONSTRAINT Location_PK PRIMARY KEY (Education_Id), 
  FOREIGN KEY (Employee_Id) 
        REFERENCES Employee(Employee_Id) 
  );

  CREATE TABLE Leave( 
  Leave_Id NUMBER, 
  Employee_Id NUMBER, 
  Leave_date DATE, 
  CONSTRAINT Leave_PK PRIMARY KEY (Leave_Id), 
  FOREIGN KEY (Employee_Id) 
        REFERENCES Employee(Employee_Id) 
  );

  CREATE TABLE Attendance( 
  Attendance_Id NUMBER, 
  Hours_Worked NUMBER, 
  CONSTRAINT Attendance_PK PRIMARY KEY (Attendance_Id) 
  );

  CREATE TABLE Employee_Attendance( 
  Employee_Id NUMBER, 
  Attendance_Id NUMBER, 
  CONSTRAINT DEPARTMENTPROJECT_PK PRIMARY KEY (Employee_Id,Attendance_Id), 
  FOREIGN KEY (Employee_Id) 
        REFERENCES Employee(Employee_Id), 
  FOREIGN KEY (Attendance_Id) 
        REFERENCES Attendance(Attendance_Id) 
  );

  CREATE TABLE Work_Location( 
  Location_Id NUMBER, 
  Location VARCHAR2(25), 
  Number_Of_Employees NUMBER, 
  City VARCHAR2(25), 
  State VARCHAR2(25), 
  CONSTRAINT Loc_PK PRIMARY KEY (Location_Id) 
  );

INSERT INTO Employee VALUES (101,'Ojas','Phansekar',to_date('14-APR-16', 'dd-MON-yyyy'),'New York City','New York');

INSERT INTO Employee VALUES (102,'Vrushali','Patil',to_date('21-JUN-18', 'dd-MON-yyyy'),'Boston','Massachusetts');

INSERT INTO Employee VALUES (103,'Pratik','Parija',to_date('13-SEP-19', 'dd-MON-yyyy'),'Chicago','Illinois');

INSERT INTO Employee VALUES (104,'Chetan','Mistry',to_date('12-APR-11', 'dd-MON-yyyy'),'Miami','Florida');

INSERT INTO Employee VALUES (105,'Anugraha','Varkey',to_date('16-AUG-17', 'dd-MON-yyyy'),'Atlanta','Georgia');

INSERT INTO Employee VALUES (106,'Rasagnya','Reddy',to_date('25-JUL-18', 'dd-MON-yyyy'),'San Mateo','California');

INSERT INTO Employee VALUES (107,'Aishwarya','Boralkar',to_date('18-DEC-10', 'dd-MON-yyyy'),'San Francisco','California');

INSERT INTO Employee VALUES (108,'Shantanu','Savant',to_date('27-NOV-15', 'dd-MON-yyyy'),'Seattle','Washington');

INSERT INTO Employee VALUES (109,'Kalpita','Malvankar',to_date('24-APR-16', 'dd-MON-yyyy'),'Boston','Massachusetts');

INSERT INTO Employee VALUES (110,'Saylee','Bhagat',to_date('21-MAY-14', 'dd-MON-yyyy'),'San Francisco','California');

INSERT INTO Department VALUES (1,'Human Resources');

INSERT INTO Department VALUES (2,'Software Development');

INSERT INTO Department VALUES (3,'Data Analysis');

INSERT INTO Department VALUES (4,'Data Science');

INSERT INTO Department VALUES (5,'Business Intelligence');

INSERT INTO Department VALUES (6,'Data Engineering');

INSERT INTO Department VALUES (7,'Manufacturing');

INSERT INTO Department VALUES (8,'Quality Control');

INSERT INTO Project VALUES (21,'Dev','Whatever');

INSERT INTO Project VALUES (22,'Prod','do something');

INSERT INTO Project VALUES (23,'Test','focus');

INSERT INTO Project VALUES (24,'Nothing','do nothing');

INSERT INTO Project VALUES (25,'Research','focus on everything');

INSERT INTO Project VALUES (26,'Next Steps','find some way out');

INSERT INTO AccountDetails VALUES (40,'Santander','S12344',101);

INSERT INTO AccountDetails VALUES (41,'Santander','S12345',102);

INSERT INTO AccountDetails VALUES (42,'Santander','S12346',103);

INSERT INTO AccountDetails VALUES (43,'Santander','S12347',104);

INSERT INTO AccountDetails VALUES (44,'Chase','C12344',105);

INSERT INTO AccountDetails VALUES (45,'Chase','C12345',106);

INSERT INTO AccountDetails VALUES (46,'Chase','C12347',107);

INSERT INTO AccountDetails VALUES (47,'Chase','C12334',108);

INSERT INTO AccountDetails VALUES (48,'BOFA','C12378',109);

INSERT INTO AccountDetails VALUES (49,'BOFA','C12390',110);

INSERT INTO Education VALUES (10,101,'MS',2017);

INSERT INTO Education VALUES (11,102,'MS',2019);

INSERT INTO Education VALUES (12,104,'MS',2011);

INSERT INTO Education VALUES (13,108,'MS',2015);

INSERT INTO Education VALUES (14,109,'Bachelor',2013);

INSERT INTO Education VALUES (15,107,'Bachelor',2008);

INSERT INTO Education VALUES (16,106,'Bachelor',2007);

INSERT INTO Leave VALUES (51,104,to_date('1-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (52,108,to_date('2-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (53,109,to_date('3-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (54,107,to_date('4-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (55,106,to_date('5-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (56,104,to_date('6-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (57,108,to_date('7-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (58,109,to_date('7-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (59,107,to_date('8-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Leave VALUES (60,106,to_date('9-DEC-19', 'dd-MON-yyyy'));

INSERT INTO Attendance VALUES (90,10);

INSERT INTO Attendance VALUES (91,20);

INSERT INTO Attendance VALUES (92,30);

INSERT INTO Attendance VALUES (93,40);

INSERT INTO Attendance VALUES (94,45);

INSERT INTO Attendance VALUES (95,56);

INSERT INTO Attendance VALUES (96,58);

INSERT INTO Work_Location VALUES (71,'North',4,'New York City','New York');

INSERT INTO Work_Location VALUES (72,'North',4,'Boston','Massachusetts');

INSERT INTO Work_Location VALUES (73,'North',4,'Chicago','Illinois');

INSERT INTO Work_Location VALUES (74,'North',89,'Miami','Florida');

INSERT INTO Work_Location VALUES (75,'South',90,'Atlanta','Georgia');

INSERT INTO Work_Location VALUES (76,'South',100,'San Mateo','California');

INSERT INTO Work_Location VALUES (77,'South',4,'San Francisco','California');

INSERT INTO Work_Location VALUES (78,'South',2,'Seattle','Washington');

INSERT INTO Work_Location VALUES (79,'South',25,'Alpharetta','Georgia');

INSERT INTO Work_Location VALUES (80,'South',20,'Keene','New Hampshire');

INSERT INTO Work_Location VALUES (81,'South',22,'Hampton','New Hampshire');

INSERT INTO Employee_Attendance VALUES (101,90);

INSERT INTO Employee_Attendance VALUES (102,91);

INSERT INTO Employee_Attendance VALUES (103,92);

INSERT INTO Employee_Attendance VALUES (104,93);

INSERT INTO Employee_Attendance VALUES (105,94);

INSERT INTO Employee_Attendance VALUES (106,95);

INSERT INTO Employee_Attendance VALUES (107,96);

INSERT INTO Employee_Attendance VALUES (108,91);

INSERT INTO Employee_Attendance VALUES (109,92);

INSERT INTO Employee_Attendance VALUES (110,93);

INSERT INTO DepartmentProject VALUES (1,21);

INSERT INTO DepartmentProject VALUES (2,22);

INSERT INTO DepartmentProject VALUES (3,23);

INSERT INTO DepartmentProject VALUES (4,24);

INSERT INTO DepartmentProject VALUES (5,25);

INSERT INTO DepartmentProject VALUES (6,26);

INSERT INTO DepartmentProject VALUES (7,21);

INSERT INTO DepartmentProject VALUES (8,24);

INSERT INTO Salary VALUES (1,57600,30,200,1000,40);

INSERT INTO Salary VALUES (2,76800,40,300,1300,41);

INSERT INTO Salary VALUES (3,96000,50,400,1500,42);

INSERT INTO Salary VALUES (4,115200,60,500,1700,43);

INSERT INTO Salary VALUES (5,57600,30,200,1000,44);

INSERT INTO Salary VALUES (6,76800,40,300,1300,45);

INSERT INTO Salary VALUES (7,96000,50,400,1500,46);

INSERT INTO Salary VALUES (8,115200,60,500,1700,47);

INSERT INTO Salary VALUES (9,57600,30,200,1000,48);

INSERT INTO Salary VALUES (10,76800,40,300,1300,49);

Update employee 
	set First_Name = 'Vlad' 
	where First_Name = 'Ojas';

select Department_Name, count(*), 
to_char((count(*)/No_of_Employees.cnt)*100, '90.99') Percentages 
from Department,Employee, ( select count(*) cnt from Employee ) No_of_Employees 
where Department.Department_Id = Employee.Employee_Id 
group by Department_Name, No_of_Employees.cnt ;

select Degree, count(Degree) 
from Education 
group by Degree;

CREATE OR REPLACE PROCEDURE Unimportant_Locations(l_NOFEmployees IN Number) 
IS 
 l_wl NUMBER; 
 l_emp NUMBER; 
 
BEGIN 
 SELECT COUNT(*) INTO l_wl 
 FROM Work_Location 
 WHERE Number_Of_Employees LIKE l_NOFEmployees; 
 
 
 select count(*) 
 into l_emp 
 from Employee e 
 inner join Work_Location w 
 on e.Employee_Id = w.Location_Id 
 where w.Number_Of_Employees LIKE l_NOFEmployees; 
 
 IF l_wl < 5 THEN 
 DELETE FROM Work_Location 
 WHERE Number_Of_Employees = l_NOFEmployees; 
END IF; 
 EXCEPTION WHEN no_data_found THEN 
 DBMS_OUTPUT.PUT_LINE('No Such Data Available'); 
END;
/

declare 
 cursor salaries(p_hourly in number) 
 is select * 
 from Salary 
 where Hourly_Pay=p_hourly; 
 
 l_sal Salary%rowtype; 
 begin 
 dbms_output.put_line(' Extracting hourly pay'); 
 open salaries(30); 
 loop 
 fetch salaries into l_sal; 
exit when salaries%notfound; 
dbms_output.put('For Account ' || l_sal.Account_Id || ' Hourly Pay is '); 
 dbms_output.put_line(l_sal.hourly_pay); 
end loop; 
close salaries; 
 end; 
/

 /


declare 
l_attendance Attendance%rowtype; 
New_Exception exception; 
begin 
l_attendance.Attendance_Id := 90; 
l_attendance.Hours_Worked := 'AS'; 
insert into Attendance (Attendance_Id,Hours_Worked) 
values ( l_attendance.Attendance_Id, l_attendance.Hours_Worked ); 
exception 
when VALUE_ERROR then 
dbms_output.put_line('We encountered the VALUE_ERROR exception'); 
end; 
/

declare 
 cursor salaries(p_hourly in number) 
 is select * 
 from Salary 
 where Hourly_Pay=p_hourly; 
 
 l_sal Salary%rowtype; 
 begin 
 dbms_output.put_line('Getting hourly pay'); 
 open salaries(30); 
 loop 
 fetch salaries into l_sal; 
exit when salaries%notfound; 
dbms_output.put('For Account ' || l_sal.Account_Id || ' Hourly Pay is '); 
 dbms_output.put_line(l_sal.hourly_pay); 
end loop; 
open salaries(30); 
exception 
when CURSOR_ALREADY_OPEN then 
dbms_output.put_line('No Need to open cursor again'); 
close salaries; 
 end; 
/

 /


INSERT INTO Employee VALUES (111,'Priyanka','Jonas',to_date('14-NOV-16', 'dd-MON-yyyy'),'New YorkCity','New York');

INSERT INTO Employee VALUES (112,'John','Vincent',to_date('21-JUN-18', 'dd-MONyyyy'),'Boston','Massachusetts');

INSERT INTO Employee VALUES (113,'Pratik','Panhale',to_date('13-SEP-19', 'dd-MONyyyy'),'Chicago','Illinois');

commit;

declare 
type emp_dept_rec is record( 
Employee_Id number, 
First_Name varchar2(66), 
Department_Name varchar2(37) 
); 
type emp_dept_refcur_type is ref cursor 
return emp_dept_rec; 
employee_refcur emp_dept_refcur_type; 
emp_dept emp_dept_rec; 
begin 
open employee_refcur for 
select e.Employee_Id, 
 e.First_Name || ' ' || e.Last_Name "Employee Name", 
 d.Department_Name 
from Employee e, Department d 
where e.Employee_Id = d.Department_Id 
and rownum < 5 
order by e.Employee_Id; 
fetch employee_refcur into emp_dept; 
while employee_refcur%FOUND loop 
dbms_output.put(emp_dept.First_Name || '''s department is '); 
dbms_output.put_line(emp_dept.Department_Name); 
fetch employee_refcur into emp_dept; 
end loop; 
end; 
/

