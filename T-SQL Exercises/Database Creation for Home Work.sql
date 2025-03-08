-- Create the TSQL database
CREATE DATABASE TSQL;
GO

-- Use the TSQL database
USE TSQL;
GO

-- Create Sales schema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Sales')
BEGIN
    EXEC('CREATE SCHEMA Sales');
END;
GO

-- Create Customers table
CREATE TABLE Sales.Customers (
    custid INT IDENTITY(1,1) PRIMARY KEY,
    companyname NVARCHAR(255) NOT NULL,
    contactname NVARCHAR(255) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    city NVARCHAR(100) NOT NULL,
    country NVARCHAR(100) NOT NULL,
    phone NVARCHAR(50) NOT NULL
);
GO

-- Create Orders table
CREATE TABLE Sales.Orders (
    orderid INT IDENTITY(1,1) PRIMARY KEY,
    custid INT NULL,
    orderdate DATE NOT NULL,
    FOREIGN KEY (custid) REFERENCES Sales.Customers(custid) ON DELETE CASCADE
);
GO

-- Insert sample data into Customers
INSERT INTO Sales.Customers (companyname, contactname, address, city, country, phone)
VALUES
    ('Alimentos Brasil', 'Ana Souza', 'Av. Paulista, 1000', 'São Paulo', 'Brazil', '+55 11 1234-5678'),
    ('London Food Ltd', 'Alice Brown', '10 Downing St', 'London', 'UK', '+44 20 7946 0123'),
    ('USA Grocery Inc.', 'Andrew Johnson', '5th Avenue', 'New York', 'USA', '+1 212-555-0199'),
    ('French Bakery', 'Marie Curie', 'Rue de Paris', 'Paris', 'France', '+33 1 2345 6789');
GO

-- Insert sample data into Orders
INSERT INTO Sales.Orders (custid, orderdate)
VALUES
    (1, '2024-01-15'),
    (2, '2024-02-10'),
    (3, '2024-02-25'); -- Customer 4 (Paris) has no orders
GO

-- Create Production schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Production')
BEGIN
    EXEC('CREATE SCHEMA Production');
END;
GO

-- Create Products table
CREATE TABLE Production.Products (
    productid INT IDENTITY(1,1) PRIMARY KEY,
    productname NVARCHAR(255) NOT NULL,
    unitprice DECIMAL(10,2) NOT NULL CHECK (unitprice >= 0),
    stockquantity INT NOT NULL CHECK (stockquantity >= 0)
);
GO

-- Insert sample data into Products table
INSERT INTO Production.Products (productname, unitprice, stockquantity)
VALUES
    ('Organic Apples', 3.50, 500),
    ('Whole Wheat Bread', 2.75, 200),
    ('Almond Milk', 5.99, 150),
    ('Cheddar Cheese', 4.50, 300),
    ('Olive Oil', 10.25, 100),
    ('Dark Chocolate', 8.40, 50),
    ('Ground Coffee', 12.75, 250),
    ('Green Tea', 6.99, 120),
    ('Fresh Salmon', 15.50, 80),
    ('Quinoa', 7.30, 90),
    ('Basmati Rice', 5.60, 400),
    ('Greek Yogurt', 4.20, 180),
    ('Maple Syrup', 9.80, 60),
    ('Cashew Butter', 14.99, 40),
    ('Chia Seeds', 6.25, 70);
GO

