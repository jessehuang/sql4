Select * Into #YoinkEmployees From Employees

Create database DbEmp
Use DbEmp
Create table Employees(
EmployeeID int, Name varchar(100), Title varchar(50), City varchar(20), ReportsTo int)
Insert into Employees Select EmployeeId, FirstName + ' '  + LastName, Title, City, ReportsTo
From #YoinkEmployees

Select * From Employees

--Anonymous Block

--Begin SImilar to {
--} similar End

Begin
Declare @var Int
Set @var = 5
Print 5
End

--Stored Procedure: Prepared Query that is Reusable
--Create Procedure (or you can just say)
Create Proc spHello
As
Begin
Print 'Hello world from SSMS'
End

Exec spHello

--Advantages of Stored procedures is that it can be stored and used whenever
--Another advantage is the usage of Parameters
/*
Create Proc spHello
As
Begin
Select * From Employees
End*/

--SQL Injection: Some hackers inject malicious code it our SQL Queries, more or less to cause harm or
--destruction to the database.

--To get User by Id
/*
Select Id, Name 
From User
Where Id = _

Select Id, Name 
From User
Where Id = 500 or 1=1

Select Id, Name
From User
Where id = 500; Drop Table User --Drop Database DbEmp

Select Id, Name
From User
Where id = 500 Union Select Id, Name From User

Use Northwind 
go
Select Table_Name From INFORMATION_SCHEMA.TABLES*/

--How to use parameters in Stored Procedures
Create Proc spAddNumbers
@a int,
@b int 
As 
Begin
Print @a + @b
End

Exec spAddNumbers 10, 20

--'500 Union by Select * From User' will be contained inside a parameter
--It will not run independently and secure that alien code will not work

Use DbEmp
Select * From Employees

Create Proc spGetEmpByCity
@City varchar (30)
As
Begin
Select * From Employees
Where City = @City
End

Declare @cityVar varchar(30)
Set @cityVar = 'London'
Exec spGetEmpByCity @cityVar

--USing Out For SP
Create Proc spGetEmpName
@id int,
@ename varchar(20) Out
As
Begin 
Select @ename = Name From Employees Where EmployeeID = @id
End

Declare @name varchar(30)
Exec spGetEmpName 1, @name out
Print @name
Select * From Employees

-- Using Return for SP
Create Proc spGetEmpRecord
As 
Begin
Declare @EmployeeRow as Int
Select @EmployeeRow = Count(*) From Employees
Return @EmployeeRow
End

Declare @result int
Exec @result = spGetEmpRecord
Print @result

Select * From Employees --Confirm 9 rows

--Return vs Out
--Both are used to retrieve a value out (return can only give back 1 integer, while out can be multiple values)
--Return in sp can only return an "Int"
--For any other type, use Out


--Triggers: They automatically Fire when an event occurs
--DML Triggers: Modify Data
--DDL Triggers: Create alter Drop
--Logon Triggers: Fires on authentication


--Functions:
Use Northwind
Go

Create Function GetTotalRevenue(@price money, @discount real, @quantity smallint)
Returns Money
As 
Begin
	Declare @revenue money
	Set @revenue = @Price * @quantity * (1- @discount)
	Return @revenue
End

Select UnitPrice, Discount, Quantity, dbo.GetTotalRevenue(UnitPrice, Discount, Quantity) [Total Revenue]
From [Order Details]

Create Function ExpensiveProduct(@threshold money)
Returns Table
AS
Return Select * From Products Where UnitPrice > @Threshold


select * From dbo.ExpensiveProduct(15)

--Sp vs Functions
--Usage: Sp is for DML statements while functions are for calculations
--Calling: Sp uses Execute, Function require Query as well as input parameters
--input: Sp may or may not need any inputs, while Functions do require one
--Output: Sp may or may not need any output, but functions must have output paramters
--Sp can call functions, but functions cannot call SP

--ORM: Object relational mapping Entity Framework Core


--Constraints:
--So what are constraints: are rules that the SQL Server Database engine enforces for you.

Use dbEmp
Go

Drop Table Employees

Create Table employees( 
id Int Primary Key,
Name varchar(30) Not Null,
Age int)

Insert into employees values(1, 'Sam', 45)

Insert into employees values(Null, 'Becca', Null)
Select * From employees

--Difference between Pk and Unique
--Unique can accept one and only null value, Primary key is Not null
--One table can have multiple unique keys, but also one primary key
--Primary key will sort the data by default while unique will not

Insert Into employees values(4, 'Sally', 26)
Insert Into employees values(3, 'Vannessa', 46)
Insert Into employees values(2, 'Becca', 86)
SElect * From employees

--Primary key will create a clustered index, while unique will create a non-clustered index.

Alter Table Employees
Add Constraint Chk_Age_Employees Check(Age between 18 and 65)

--Identity Property
--Featuere that allows us to auto increment with a starting value then increment value
--Drop table Products
Create Table Products(
Id int Primary Key Identity(100,10),
ProductName Varchar(30) unique Not Null,
UnitPrice Money Check(unitPrice < 10))

Insert into Products values('Black Tea', 4)
Insert into Products values('Blue Tea', 3)
Insert into Products values('Red Tea', 2)
Insert into Products values('Purple Tea', 5)

Select * From Products

--Delete and Truncate
--1. Delete is used to remove one or many reords, it can be used with Where cluase for specificity
--2. Delete is a DML Statement, it will not reset identity, but Truncate as a DDL statement will reset identity
--3. Truncate will remove all records and cannot be used with "Where"

Delete Products where UnitPrice = 5
Delete Products

Truncate Table Products

--Integrities:
--Referential Integrity: Build and maintain the logical relation between tables to avoid logical 
--Corruption of data

Create Table departments(
Id int primary key,
dName varchar(20) not null,
loc varchar (30))


Create Table Employees(
id int primary Key,
Ename varchar (20) not null,
Age Int check (Age Between 18 and 65),
DeptID int foreign key references Departments(id))

insert into departments values(1, 'IT', 'Va')
insert into departments values(2, 'HR', 'TX')
insert into departments values(3, 'Marketing', 'CA')

Insert Into Employees Values(1, 'fred', 34, 1)
Insert Into Employees Values(2, 'Peter', 44, 3)

Select * from departments
Select * from employees
Delete From departments Where Id = 2;

