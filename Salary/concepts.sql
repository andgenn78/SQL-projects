--Inline Views
-----------------------------------
select Department_Name, count(*),
to_char((count(*)/No_of_Employees.cnt)*100, '90.99') Percentages
from Department,Employee, ( select count(*) cnt from Employee ) No_of_Employees
where Department.Department_Id = Employee.Employee_Id
group by Department_Name, No_of_Employees.cnt
/

---------------------------------------
--Materialized Views
-----------------------------------------
--Number of Employees with different degrees
---------------------------------------------
--create materialized view Education_View
--build immediate
--refresh on commit
--as
select Degree, count(Degree)
from Education
group by Degree;
	 
--Procedure
--Locations with less number of employees

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

--Explicit Cursor
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
 
 --Pre-Defined Exception
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

--Explicit Cursor and Pre-Defined Cursor Together
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


--External Table Нет доступа к локальной папке через браузер
/*create table Salary_External (
 Salary_Id NUMBER,
 Gross_Salary NUMBER,
 Hourly_Pay NUMBER,
 State_Tax NUMBER,
 Federal_Tax NUMBER,
 Account_Id NUMBER
)
organization external (
type oracle_loader
default directory ext_Salaries
access parameters (
fields terminated by ',' )
location ('Salary.csv')
)
reject limit unlimited
/*/

--Transaction
INSERT INTO Employee VALUES (111,'Priyanka','Jonas',to_date('14-NOV-16', 'dd-MON-yyyy'),'New YorkCity','New York');
commit;
INSERT INTO Employee VALUES (112,'John','Vincent',to_date('21-JUN-18', 'dd-MONyyyy'),'Boston','Massachusetts');

INSERT INTO Employee VALUES (113,'Pratik','Panhale',to_date('13-SEP-19', 'dd-MONyyyy'),'Chicago','Illinois');


--Ref Cursor
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


