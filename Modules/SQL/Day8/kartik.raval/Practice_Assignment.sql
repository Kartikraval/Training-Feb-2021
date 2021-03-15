USE AdventureWorks2012;

SELECT * FROM Person.ContactType;

SELECT Name FROM Person.ContactType WHERE Name like 'Account%';

DECLARE @sql nvarchar(500) = 'SELECT Name FROM Person.ContactType WHERE Name = @Name';

DECLARE @parameterDefinitions nvarchar(500) = '@Name nvarchar(50)';

EXECUTE sp_executesql @sql, @parameterDefinitions, @Name = 'Owner';

USE Day2_practice;

GO  

CREATE TABLE dbo.TestTable  
    (TestCol1 int NOT NULL,  
     TestCol2 nchar(10) NULL,  
     TestCol3 nvarchar(50) NULL);  
GO  
CREATE CLUSTERED INDEX IX_TestTable_TestCol1   
    ON dbo.TestTable (TestCol1);   
GO  

USE AdventureWorks2012;  
GO  
 
IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'IX_ProductVendor_VendorID')   
    DROP INDEX IX_ProductVendor_VendorID ON Purchasing.ProductVendor;   
GO  
  
CREATE NONCLUSTERED INDEX IX_ProductVendor_VendorID   
    ON Purchasing.ProductVendor (BusinessEntityID);   
GO  

EXECUTE sp_helpindex Employees