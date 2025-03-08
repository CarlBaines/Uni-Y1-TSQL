--1. Creates Database
CREATE DATABASE PracticeDB;
GO

--2. Creates a table called Employees inside PracticeDB.
CREATE TABLE dbo.Employees (
	EmpID INT IDENTITY (1,1) PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Department NVARCHAR(50) NOT NULL,
	HireDate DATE NOT NULL
);
GO

DROP TABLE dbo.Employees;
GO

-- Insert rows into the 'Employees' table without specifying the EmpID
INSERT INTO dbo.Employees(FirstName, LastName, Department, HireDate)
VALUES
	('Luke', 'Eastwood', 'HR', '2020-03-15'),
	('Carl', 'Baines', 'IT', '2019-06-22'),
	('Reese', 'Johnson', 'Sales', '2021-11-30'),
	('Prabhjot', 'Dhaliwal', 'Management', '2018-07-19'),
	('Ryan', 'Carter', 'Finance', '2022-02-10');
GO

--Exercise 3: Query Data with Conditions
--SELECT STATEMENT TO RETRIEVE ALL DATA FROM THE 'EMPLOYEES' TABLE
SELECT * FROM Employees;

SELECT * FROM Employees 
WHERE HireDate > '2020-01-01';

SELECT * FROM Employees 
WHERE LastName LIKE 'J%';
GO

--Exercise 4: Update Data 
-- Update my department to sales
UPDATE Employees
SET Department = 'Sales'
WHERE FirstName = 'Carl' AND LastName = 'Baines';
GO
-- Update the hire date of my friend to 2018-05-14.
UPDATE Employees
SET HireDate = '2018-05-14'
WHERE FirstName = 'Luke' AND LastName = 'Eastwood';
GO
--Exercise 5: Add Constraints to a Table
ALTER TABLE Employees
ADD CONSTRAINT chk_Department CHECK (Department IN('HR', 'IT','Sales','Management','Finance'));

ALTER TABLE Employees
ADD CONSTRAINT chk_HireDate CHECK (HireDate > '2000-01-01');

ALTER TABLE Employees
ALTER COLUMN FirstName NVARCHAR(30) NOT NULL;
GO
--Exercise 6: Insert invalid data to test constraint errors
INSERT INTO Employees (FirstName, LastName, Department, HireDate)
VALUES('Joe', 'Mama', 'Engineering', '2022-05-01');
GO

INSERT INTO Employees(FirstName, LastName, Department, HireDate)
VALUES('John', 'Doe', 'Security', '1995-12-31');
GO
--Exercise 7: Use Date Functions
-- Calculate years worked for employee
SELECT FirstName, LastName, Department,
DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorked
FROM Employees;
GO

-- Retrieve employees who have worked for 5+ years
SELECT FirstName, LastName, Department, HireDate
FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) >= 5;
GO
--Exercise 8: Delete Data
DELETE FROM Employees
WHERE Department = 'Sales';
GO
-- Delete employees hired before 2019
DELETE FROM Employees
WHERE HireDate < '2019-01-01';
GO

--Exercise 9: Drop a table
--Drop the employees table
DROP TABLE Employees;
GO

CREATE PROCEDURE GetEmployeesByDepartment
	@Dept NVARCHAR(50)
AS
BEGIN
	SELECT * FROM Employees
	WHERE Department = @Dept;
END;
GO

EXEC GetEmployeesByDepartment @Dept = 'IT';
GO

