USE TSQL;
GO

-- Wildcard I will use throughout just to data in the tables.
SELECT * FROM Sales.Customers;
--Exercise One
--Task 1: Queries that filter data using a WHERE clause.
-- A SELECT statement that will return the custid, companyname, contactname, address, city, country and phone columns from the Sales.Customer table.
SELECT custID, companyname, contactname, address, city, country, phone
FROM Sales.Customers;
-- Filter the results to include only the customers from the country Brazil.
SELECT custID, companyname, contactname, address, city, country, phone
FROM Sales.Customers
WHERE country = 'Brazil';

--Task 2: Write a SELECT statement that will return the custid, companyname, contactname,
--address, city, country, and phone columns from the Sales.Customers table.
SELECT custID, companyname, contactname, address, city, country, phone
FROM Sales.Customers;
-- Filter the results to only include customers from the countries Brazil, UK and the USA.
SELECT custID, companyname, contactname, address, city, country, phone
FROM Sales.Customers
--IN clause allows you to specify multiple values in a WHERE.
WHERE country IN ('Brazil', 'UK', 'USA');
--Task 3: Write a SELECT statement that will return the custid, companyname, contactname,
--address, city, country, and phone columns from the Sales.Customers table.
SELECT custID, companyname, contactname, address, city, country, phone
FROM Sales.Customers;
--Filter the results to include only the customers with a contact name starting with the
--letter A.
SELECT custID, companyname, contactname, address, city, country, phone
FROM Sales.Customers
--LIKE clause used to search for a specific string value.
WHERE contactname LIKE 'A%';
--Task 4: The IT department has written a T-SQL statement that retrieves the custid and
--companyname columns from the Sales.Customers table and the orderid column
--from the Sales.Orders table.
--• Execute the query. Notice two things:
--• First, the query retrieves all the rows from the Sales.Customers table.
--• Second, there is a comparison operator in the ON clause specifying that the
--city column should be equal to the value “Paris”.
SELECT
	c.custid, c.companyname, o.orderid
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid AND c.city = N'Paris';

SELECT
	c.custid, c.companyname, o.orderid
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid 
WHERE 
	c.city = N'Paris';
--Task 5: 
--• Write a T-SQL statement to retrieve customers from the Sales.Customers table that
--does not have matching orders in the Sales.Orders table.
--• Matching customers with orders is based on a comparison between the customer’s
--custid value and the order’s custid value.
--• Retrieve the custid and companyname columns from the Sales.Customers table.
--• (Hint: Use a T-SQL statement that is similar to the one in the previous task.)
--• Execute the written statement and compare the results that you got with the
--possible result(s) of the query
SELECT c.custid, c.companyname
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o on c.custid = o.custid
WHERE o.custid is NULL;
--Exercise Two
--Write Queries that Sort Data using an ORDER BY Clause.
--Task 1:
--Write a SELECT statement that Using ORDER BY city column ascending order from
--the Sales.Customers table
SELECT city
FROM Sales.Customers
ORDER BY city ASC;
--Write a SELECT statement that Using ORDER BY country column in descending order
--from the Sales.Customers table.
SELECT city
FROM Sales.Customers
ORDER BY city DESC;
--Task 2:
--Write a SELECT statement against the Sales.Orders table and retrieve the orderid and
--orderdate columns.

--Wildcard to check contents of orders table.
SELECT * FROM Sales.Orders;

SELECT orderid, orderdate
FROM Sales.Orders;
--Retrieve the 20 most recent orders, ordered by orderdate.
SELECT TOP 20 orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate
--Task 3:
--Write a SELECT statement to retrieve the same result as in task 2, but use the
--OFFSET-FETCH clause.
SELECT orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid
--OFFSET clause skips the first row - first orderid.
OFFSET 1 ROWS
--FETCH NEXT clause fetches the next two rows of the table only.
FETCH NEXT 2 ROWS ONLY;
--Task 4:
--Write a SELECT statement to retrieve the productname and unitprice columns from
--the Production.Products table.
--Wildcard to check contents of table.
SELECT * FROM Production.Products;

SELECT productname, unitprice 
FROM Production.Products;
--Modify the SELECT statement to include only the top 10 percent of products based
--on highest unitprice ordering.
--PERCENT clause to retrieve the top 10%.
SELECT TOP 10 PERCENT productname, unitprice
FROM Production.Products
ORDER BY unitprice DESC;
--Exercise 3
--Write Queries that filter data using the TOP option.
--Task 1:
--Write a SELECT statement against the Sales.Orders table and retrieve the custid,
--orderid and orderdate columns.
SELECT custid, orderid, orderdate 
FROM Sales.Orders;
--Retrieve the 20 most recent orders, ordered by orderdate.
SELECT TOP 20 custid, orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate DESC;
--Task 2:
--Write a SELECT statement to retrieve the same result as in task 1, but use the
--OFFSET-FETCH NEXT clause.
SELECT custid, orderid, orderdate
FROM Sales.Orders
ORDER BY orderDate DESC
OFFSET 1 ROWS
FETCH NEXT 20 ROWS ONLY;
--Exercise 4:
--Write Queries that Filter Data Using the OFFSET-FETCH Clause
--Write a SELECT statement to retrieve the custid, orderid, and orderdate columns
--from the Sales.Orders table. Order the rows by orderdate and orderid. Retrieve the
--first 20 rows.
SELECT custid, orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 0 ROWS
FETCH NEXT 20 ROWS ONLY;
--Copy the SELECT statement in task 1 and modify the OFFSET-FETCH clause to skip the
--first 20 rows and fetch the next 20 rows.
SELECT custid, orderid, orderdate
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 20 ROWS
FETCH NEXT 20 ROWS ONLY;