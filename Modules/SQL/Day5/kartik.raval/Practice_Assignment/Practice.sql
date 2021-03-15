USE AdventureWorks2012

SELECT * FROM Production.ProductCategory;

SELECT * FROM Production.ProductSubcategory;

SELECT pc.Name, pc.ModifiedDate, psc.Name, psc.rowguid
FROM Production.ProductCategory AS pc
INNER JOIN Production.ProductSubcategory AS psc ON pc.ProductCategoryID = psc.ProductCategoryID;

SELECT pc.Name, pc.ModifiedDate, psc.Name, psc.rowguid
FROM Production.ProductCategory AS pc
LEFT OUTER JOIN Production.ProductSubcategory AS psc ON pc.ProductCategoryID = psc.ProductCategoryID;

SELECT pc.Name, pc.ModifiedDate, psc.Name, psc.rowguid
FROM Production.ProductCategory AS pc
RIGHT OUTER JOIN Production.ProductSubcategory AS psc ON pc.ProductCategoryID = psc.ProductCategoryID;

Select BusinessEntityID, HireDate from HumanResources.Employee where HireDate = '2009-02-08'; 

SELECT lhs.BusinessEntityID AS 'lhs.BusinessEntityID', lhs.HireDate, 
	   rhs.BusinessEntityID AS 'rhs.BusinessEntityID'
	   FROM HumanResources.Employee lhs INNER JOIN HumanResources.Employee rhs ON lhs.HireDate = rhs.HireDate AND lhs.BusinessEntityID < rhs.BusinessEntityID;

SELECT * FROM HumanResources.Employee;
