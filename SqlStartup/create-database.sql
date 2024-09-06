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

IF OBJECT_ID(N'People','U') IS NULL
BEGIN
    CREATE TABLE People(
        PersonId INT IDENTITY(1,1) PRIMARY KEY,
        GivenNames NVARCHAR(100) NOT NULL,
        Surname NVARCHAR(100) NOT NULL,
        AddressLine1 NVARCHAR(100) NOT NULL,
        AddressLine2 NVARCHAR(100) NOT NULL,
        City NVARCHAR(100) NOT NULL,
        State NVARCHAR(100) NOT NULL,
        PostCode VARCHAR(10) NOT NULL,
        LastModified DATETIME2 NOT NULL DEFAULT(GetDate())
    )
END
GO