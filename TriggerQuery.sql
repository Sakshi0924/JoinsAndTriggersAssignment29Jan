use WFADotNet;

--Create PastEmpTable
create table pastEmpTable(
	empId int,
	ename varchar(20),
	esal float,
	dol datetime default getDate()
	)

--Create Trigger for update command on EmployeeTable
create trigger TriAfterUpdate
on EmployeeTable
after update
as
declare @empId int,
@ename varchar(20),
@esal float,
@dol Datetime
select @empId=deleted.EmpId,@ename=deleted.EmpName,@esal=deleted.Salary from deleted

insert  into Pastemptable(empid,ename,esal,dol) values(@empId,@ename,@esal,@dol)
print 'After Update trigger fired on EmpTable'

--Employee Table
select * from EmployeeTable;

--Update Query on Employee Table
Update EmployeeTable set Salary=8796.98
where EmpName='Sakshi'

--pastEmpTable
select * from pastEmpTable;





