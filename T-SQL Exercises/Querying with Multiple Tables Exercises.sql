USE TSQL;
GO
--Exercise One: Writing Queries That Use Inner Joins
--Task One: Write a SELECT statement that will return the productname column from the
--Production.Products table (use table alias “p”) and the categoryname column from
--the Production.Categories table (use table alias “c”) using an inner join
SELECT p.productname
FROM Production.Products AS p;

SELECT c.categoryname
FROM Production.Categories AS c;

SELECT p.productname, c.categoryname
FROM Production.Products AS p
INNER JOIN Production.Categories AS c 
ON p.categoryid = c.categoryid;
--Exercise Two: Writing Queries That Use Multiple-Table Inner Joins
--Task One: Execute the query exactly as written inside a query window and observe the result.
SELECT custid, contactname, orderid
FROM Sales.Customers
INNER JOIN Sales.Orders ON Customers.custid = Orders.custid;
--Ambiguous column name - custid.
-- It is ambiguous because running these wildcard queries shows that custid appears in both the customers and orders table.
SELECT * FROM Sales.Customers;
SELECT * FROM Sales.Orders;
-- Task Two: To fix the error, you can just add the table you want the specific custids to be selected from. In this case, it would be from the customers table.
SELECT Customers.custid, contactname, orderid
FROM Sales.Customers
INNER JOIN Sales.Orders ON Customers.custid = Orders.custid;
--Task Three: Copy the T-SQL statement from task 2 and modify it to use the table aliases “C” for
--the Sales.Custumers table and “O” for the Sales.Orders table.
SELECT c.custid, c.contactname, o.orderid
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o ON c.custid = o.custid;
--Task Four: Copy the T-SQL statement from task 3 and modify it to include three additional
--columns from the Sales.OrderDetails table: productid, qty, and unitprice.
SELECT c.custid, c.contactname, o.orderid, od.productid, od.qty, od.unitprice
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o ON c.custid = o.custid
INNER JOIN Sales.OrderDetails AS od ON o.orderid = od.orderid;

SELECT * FROM Sales.OrderDetails;
--Exercise Three: Writing Queries That Use Self Joins
--Task One: In order to better understand the needed tasks, you will first write a SELECT
--statement against the HR.Employees table showing the empid, lastname, firstname,
--title, and mgrid columns.
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid
FROM HR.Employees AS e;
--The mgrid column has a self-referencing relationship with the empid column.
--Task Two: Copy the SELECT statement from task 1 and modify it to include additional columns
--for the manager information (lastname, firstname) using a self-join. Assign the
--aliases mgrlastname and mgrfirstname, respectively, to distinguish the manager
--names from the employee names.
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid,
	m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = m.empid;
--Exercise Four:  Writing Queries That Use Outer Joins
--Task One: Write a SELECT statement to retrieve the custid and contactname columns from the
--Sales.Customers table and the orderid column from the Sales.Orders table. The
--statement should retrieve all rows from the Sales.Customers table.
SELECT c.custid, c.contactname, o.orderid
FROM Sales.Customers AS c
FULL OUTER JOIN Sales.Orders AS o
--join when the customer id from the customers table is equal to the customer id in the orders table (foreign key).
ON c.custid = o.custid;
--Exercise Five: Writing Queries That Use Cross Joins
--Task One: Execute the T-SQL code under Task 1. Do not worry if you do not understand the
--provided T-SQL code, as it is used here to provide a more realistic example for a
--cross join in the next task.
SET NOCOUNT ON;

IF OBJECT_ID('HR.Calendar') IS NOT NULL
	DROP TABLE HR.Calendar;

CREATE TABLE HR.Calendar (
	calendardate DATE CONSTRAINT PK_Calendar PRIMARY KEY
);

DECLARE
	@startdate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 1, 1),
	@enddate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31);
WHILE @startdate <= @enddate
BEGIN
	INSERT INTO HR.Calendar (calendardate)
	VALUES (@startdate);

	SET @startdate = DATEADD(DAY, 1, @startdate);
END;
SET NOCOUNT OFF;
-- observe the HR.Calendar table
SELECT
	calendardate
FROM HR.Calendar;
--Task Two: Write a SELECT statement to retrieve the empid, firstname, and lastname columns
--from the HR.Employees table and the calendardate column from the HR.Calendar
--table.
SELECT e.empid, e.firstname, e.lastname, c.calendardate
FROM HR.Employees AS e
--Joins two tables together without the need for a condition.
CROSS JOIN HR.Calendar AS c; 
--Task Three: Write a statement to remove the HR.Calendar table
DROP TABLE HR.Calendar;
s