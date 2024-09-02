IF NOT EXISTS (SELECT 1
               from sys.databases
               where name = 'DemoData')
BEGIN
    CREATE DATABASE DemoData;
END
GO
USE DemoData;
GO
IF OBJECT_ID(N'Product', 'U') IS NULL
BEGIN
    CREATE TABLE Product(Id int IDENTITY(1,1), ProductName nvarchar(max), LastModified DATETIME2 DEFAULT(GETDATE()));
END
GO

INSERT INTO Product(ProductName)
VALUES('Apples'), ('Bananas'), ('Oranges');