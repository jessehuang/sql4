--1.
CREATE VIEW view_product_order_huang As
Select productName, SUM(od.Quantity) as quantity
From [Order Details] od
join products p on p.ProductID = od.ProductID
GROUP BY p.ProductName

--2.

Create Proc sp_product_order_quantity_huang
@id int,
@quant int Out
As
Begin
Select @quant = SUM(od.quantity) From [Order Details] od Where od.ProductID = @id
End

--3.

Create Proc sp_product_order_city_huang
@pName varchar(40),
@quant int Out
As
Begin
with ranked as (
    SELECT c.city, rank() over (order by sum(od.Quantity)) as rnk, sum(od.Quantity) as q
    from Products p join [Order Details] od on od.ProductID = p.ProductID
    join orders o on o.OrderID = od.OrderID
    join Customers c on c.CustomerID = o.CustomerID
    Where p.ProductName = @pName
    GROUP by c.city
)
Select @quant = SUM(r.q) From ranked r Where r.rnk <=5
End

--4.

Create Table city_huang( 
cityid Int Primary Key,
Name varchar(30) Not Null)

Insert into city_huang values(1, 'Seattle')
Insert into city_huang values(2, 'Green Bay')

Create Table people_huang( 
id Int Primary Key,
Name varchar(30) Not Null,
cityid int)

Insert into people_huang values(1, 'Aaron Rodgers', 2)
Insert into people_huang values(2, 'Russell Wilson', 1)
Insert into people_huang values(3, 'Jody Nelson', 2)

delete city_huang where name = 'Seattle'

update city_huang
set name = 'Madison'
where name = 'Seattle'

-- run on own
CREATE VIEW Packers_huang As
Select ph.name
From people_huang ph join city_huang ch
on ph.cityid = ch.cityid
where ch.name = 'Green Bay'

drop table people_huang
drop table city_huang

--5.

create proc sp_birthday_employees_huang
as
begin
Create table birthday_employees_huang(
EmployeeID int, Name varchar(100))
INSERT into birthday_employees_huang 
    Select e.EmployeeID, e.FirstName + e.LastName as [eName]
    from Employees e 
    where MONTH(e.BirthDate) = 2
end

exec sp_birthday_employees_huang
select * from birthday_employees_huang
Drop table birthday_employees_huang

--6.

-- We could except the two tables and verify that no rows are returned
