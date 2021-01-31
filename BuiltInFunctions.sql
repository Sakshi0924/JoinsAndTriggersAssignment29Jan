use WFADotNet;

--String Functions

select CONCAT('S','A','K','S','H','I') as Name;
select lower('HELLOEVERYONE') as lowercase;
select replace('GoodMorning','Morning','Evening')as Replaces;
select reverse('Shegaon') as Reverses;

--Math Functions

select sqrt(9) as SquareRoot;
select CEILING(5.8) as CeilValue;
select Floor(5.8) as FloorValue;
select abs(-9) as Absolute;
select power(2,3) as Powers;

--Aggregate functions

Select * from EmployeeTable;

Select count(EmpId) as TotEmployees from EmployeeTable;
select min(salary) as MinSal from EmployeeTable;
select max(salary) as MaxSal from EmployeeTable;
select avg(Salary) as AvgSal from EmployeeTable;
select sum(salary) as SumSal from EmployeeTable;


