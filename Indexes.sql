--Index: Is an on-disk structure associated with a table that increases the retrieval speed of rows from a table

--Clustered: Physically sorts the data, one clustered index per table, associated with Primary key
--nonclustered: does not sort the data, can have more than one index, stored separately from Clustered, 
--create nonclusted on columns most used with "Where", join, amd aggregate fields

Create table Customers(
id int PRimary Key,
Fullname varchar(30) Unique,
City varchar (20))

Drop Table Customers

Select * from Customers

Create Clustered Index Cluster_IX_Customer_Id ON Customers(id)
Insert into Customers values(2, 'Bob Smith', 'Texas')
Insert Into Customers values(1, 'John Doe', 'Oregon')

Create Index Cluster_IX_Customer_City ON Customers(City)

--Pros:
--Indexes improve retrieval speed - Improves Performance of select Statements
--Cons: 
--1 Slows other DML statements (insert, update, delete) because indexes have to be restructured for 
--the other DML statements and can cost performance during restructuring.
--2. Extra Space Sql Server needs a bit of storage space for indexes so use them wisely
--3. Can slow down queries if you have too many indexes. A good theoretical number like 3-4

--Performance tuning:
--1. Look at the execution plan. Make sure you are not using a table scan but an index scan
-- Also useful for seeing how joins/subqueries are calcuated
--2. Choose index wisely. 
--3. Avoid unnecessary Joins 

--Student table: sId, sName
--Course Table: cId, CName
--StudentCourse: sId, cId
--Count the number of Courses

--4. Avoid select *
--5. Join to replace subquery (optimizer)
--6. Use derived table to avoid grouping a lot of non-aggregate fields

