use WFADotNet;

--First Table TblCustomer

create table TblCustomer(
	CustomerID varchar(20) not null primary Key,
	Name varchar(20),
	DOB date,
	City varchar(20)
	)

insert into TblCustomer values ('123456', 'David Letterman', '04-Apr-1949', 'Hartford');
insert into TblCustomer values ('123457', 'Barry Sanders', '12-Dec-1967','Detroit');
insert into TblCustomer values ('123458', 'Jean-Luc Picard', '9-Sep-1940', 'San Francisco');
insert into TblCustomer values ('123459', 'Jerry Seinfeld', '23-Nov-1965','New York City');
insert into TblCustomer values ('123460', 'Fox Mulder', '05-Nov-1962', 'Langley');
insert into TblCustomer values ('123461', 'Bruce Springsteen', '29-Dec-1960','Camden');
insert into TblCustomer values ('123462', 'Barry Sanders', '05-Aug-1974','Martha''s Vineyard');
insert into TblCustomer values ('123463', 'Benjamin Sisko', '23-Nov-1955','San Francisco');
insert into TblCustomer values ('123464', 'Barry Sanders', '19-Mar-1966','Langley');
insert into TblCustomer values ('123465', 'Martha Vineyard', '19-Mar-1963','Martha''s Vineyard');

select * from TblCustomer;

--Second Table TblAccountType

create table TblAccountType(
	TypeCode int not null primary key,
	TypeDesc varchar(20)
	)

insert into TblAccountType values (1, 'Checking');
insert into TblAccountType values (2, 'Saving');
insert into TblAccountType values (3, 'Money Market');
insert into TblAccountType values (4, 'Super Checking');

select * from TblAccountType;

--Third Table TblAccount

create table TblAccount(
	CustomerID varchar(20) foreign key references Tblcustomer(CustomerId) ,
	AccountNumber varchar(20) not null primary key,
	AccountTypeCode int foreign key references TblAccountType(TypeCode),
    DateOpened date default getdate(),
	Balance float
	)

insert into tblAccount values('123456', '123456-1', 1, '04-Apr-1993', 2200.33);
insert into tblAccount values('123456', '123456-2', 2, '04-Apr-1993', 12200.99);
insert into tblAccount values('123457', '123457-1', 3, '01-JAN-1998', 50000.00);
insert into tblAccount values('123458', '123458-1', 1, '19-FEB-1991', 9203.56);
insert into tblAccount values('123459', '123459-1', 1, '09-SEP-1990', 9999.99);
insert into tblAccount values('123459', '123459-2', 1, '12-MAR-1992', 5300.33);
insert into tblAccount values('123459', '123459-3', 2, '12-MAR-1992', 17900.42);
insert into tblAccount values('123459', '123459-4', 3, '09-SEP-1998', 500000.00);
insert into tblAccount values('123460', '123460-1', 1, '12-OCT-1997', 510.12);
insert into tblAccount values('123460', '123460-2', 2, '12-OCT-1997', 3412.33);
insert into tblAccount values('123461', '123461-1', 1, '09-MAY-1978', 1000.33);
insert into tblAccount values('123461', '123461-2', 2, '09-MAY-1978', 32890.33);
insert into tblAccount values('123461', '123461-3', 3, '13-JUN-1981', 51340.67);
insert into tblAccount values('123462', '123462-1', 1, '23-JUL-1981', 340.67);
insert into tblAccount values('123462', '123462-2', 2, '23-JUL-1981', 5340.67);
insert into tblAccount values('123463', '123463-1', 1, '1-MAY-1998', 513.90);
insert into tblAccount values('123463', '123463-2', 2, '1-MAY-1998', 1538.90);
insert into tblAccount values('123464', '123464-1', 1, '19-AUG-1994', 1533.47);
insert into tblAccount values('123464', '123464-2', 2, '19-AUG-1994', 8456.47);

select * from TblAccount;

--1.	Print customer id and balance of customers who have at least $5000 in any of their accounts. 

select CustomerId,balance 
from TblAccount
where balance>=5000;

--2.	Print names of customers whose names begin with a ‘B’. 

select Name 
from TblCustomer
where Name like'B%';

--3.	Print all the cities where the customers of this bank live. 

select city 
from TblCustomer;

--4.	Use IN [and NOT IN] clauses to list customers who live in [and don’t live in] San Francisco or Hartford. 

select * 
from tblCustomer 
where City In('San Francisco','Hartford');

select * 
from tblCustomer 
where City Not In('San Francisco','Hartford');

--5.	Show name and city of customers whose names contain the letter 'r' and who live in Langley. 

select Name,city
from TblCustomer
where name like '%r%' and City='Langley';

--6.	How many account types does the bank provide? 

select count(TypeCode) as NoOfAccountTypes
from TblAccountType

--7.	Show a list of accounts and their balance for account numbers that end in '-1' 

select balance,AccountNumber
from TblAccount
where AccountNumber like '%-1'

--8.	Show a list of accounts and their balance for accounts opened on or after July 1, 1990. 

select AccountNumber,balance,dateOpened
from TblAccount
where dateopened>='1-July-1990';

--9.	If all the customers decided to withdraw their money, how much cash would the bank need? 

select sum(balance) as TotAmount
from TblAccount

--10.	List account number(s) and balance in accounts held by ‘David Letterman’. 

select t1.AccountNumber,t1.balance,t2.Name
from TblAccount t1
join TblCustomer t2
on t1.CustomerID=t2.CustomerID
where t2.Name='David Letterman'

--11.	List the name of the customer who has the largest balance (in any account).

select t1.Name,t2.Balance
from TblCustomer t1
inner join TblAccount t2
on t1.CustomerID=t2.CustomerID
where t2.Balance=(Select max(balance) from TblAccount)

--12.	List customers who have a ‘Money Market’ account. 

select t1.Name,t2.CustomerID
from TblCustomer t1
join TblAccount t2
on t1.CustomerID=t2.CustomerID
join TblAccountType t3
on t2.AccountTypeCode=t3.TypeCode
where t3.TypeDesc='Money Market'

--13.	Produce a listing that shows the city and the number of people who live in that city. 

select City,count(city) as NoOfPeople
from TblCustomer
group by city;

--14.	Produce a listing showing customer name, the type of account they hold and the balance in that account. (Make use of Joins)

select t1.Name,t3.TypeDesc,t2.balance
from TblCustomer t1
join TblAccount t2 on t1.CustomerID=t2.CustomerID
join TblAccountType t3 on t2.AccountTypeCode=t3.TypeCode

--15.	Produce a listing that shows the customer name and the number of accounts they hold.(Make use of Joins)

select t1.Name,count(t2.AccountNumber) as NoOfAccounts
from TblCustomer t1
join TblAccount t2
on t1.CustomerID=t2.CustomerID
group by t1.name;

--16.	Produce a listing that shows an account type and the average balance in accounts of that type. (Make use of Joins)

select t2.TypeDesc,avg(t1.Balance) as AvgBalance
from TblAccount t1
join TblAccountType t2
on t1.AccountTypeCode=t2.TypeCode
group by t2.TypeDesc;

