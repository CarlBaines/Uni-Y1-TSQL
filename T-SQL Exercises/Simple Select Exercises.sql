USE TSQL
GO

-- Simple SELECT Statement with wildcard.
SELECT * FROM Sales.Customers;

-- Distinct Statement
SELECT DISTINCT Country FROM Sales.Customers;

-- SELECT statement that uisng column and table aliases from the Sales.Customers and Production.Products table.
SELECT contactname, contacttitle, companyname FROM Sales.Customers;
SELECT productname FROM Production.Products;

-- SIMPLE CASE STATEMENT
-- ADD COLUMNS TO TABLE THEN SELECTING THE NEW COLUMNS FROM THE TABLE
ALTER TABLE Production.Products
ADD iscampaign varchar(255),
categoryname varchar(255);

SELECT categoryid, productname, categoryname, iscampaign FROM Production.Products;

SELECT Production.Products.categoryid, productname, Production.Categories.categoryname,
CASE
	WHEN Production.Products.categoryid = 1 THEN 'Campaign Products'
	WHEN Production.Products.categoryid > 6 THEN 'Campaign Products'
	ELSE 'Non-Campaign Products'
END AS iscampaign
FROM Production.Products
-- LEFT JOIN STATEMENT
-- Left join the Categories table from the Production database to the Products table from the Production database where the categoryID is the same in both tables.
LEFT JOIN Production.Categories ON Production.Products.categoryid = Production.Categories.categoryid;




