USE Day7_practice

SELECT * FROM Employees;

SELECT FirstName, LastName FROM Employees WHERE JobId = 'FI_ACCOUNT'
UNION
SELECT FirstName, LastName FROM Employees WHERE CommissionPct = 0;

SELECT FirstName, LastName FROM Employees WHERE JobId = 'FI_ACCOUNT'
UNION ALL
SELECT FirstName, LastName FROM Employees WHERE CommissionPct = 0;

SELECT FirstName, LastName FROM Employees WHERE JobId = 'SA_MAN'
INTERSECT
SELECT FirstName, LastName FROM Employees WHERE CommissionPct > 0.25;

SELECT FirstName, LastName FROM Employees WHERE JobId = 'SA_MAN'
EXCEPT
SELECT FirstName, LastName FROM Employees WHERE CommissionPct > 0.25;

USE Day6_practice

SELECT * FROM Employees
SELECT * FROM Departments

SELECT FirstName FROM Employees e 
INNER JOIN (SELECT DepartmentID, DepartmentName FROM Departments) AS Dept 
ON Dept.DepartmentID = e.DepartmentID;


SELECT * FROM Employees;

WITH Emp_details(FirstName, LastName)
AS 
(
SELECT FirstName, LastName FROM Employees WHERE EmployeeID IS NOT NULL
)
SELECT * FROM Emp_details;

USE AdventureWorks2012;

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)  
AS  
 
(  
    SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear  
    FROM Sales.SalesOrderHeader  
    WHERE SalesPersonID IS NOT NULL  
)  
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear  
FROM Sales_CTE  
GROUP BY SalesYear, SalesPersonID  
ORDER BY SalesPersonID, SalesYear; 


WITH Sales_CTE (SalesPersonID, NumberOfOrders)  
AS  
(  
    SELECT SalesPersonID, COUNT(*)  
    FROM Sales.SalesOrderHeader  
    WHERE SalesPersonID IS NOT NULL  
    GROUP BY SalesPersonID  
)  
SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"  
FROM Sales_CTE;  


WITH Sales_CTE (SalesPersonID, TotalSales, SalesYear)  
AS  
 
(  
    SELECT SalesPersonID, SUM(TotalDue) AS TotalSales, YEAR(OrderDate) AS SalesYear  
    FROM Sales.SalesOrderHeader  
    WHERE SalesPersonID IS NOT NULL  
       GROUP BY SalesPersonID, YEAR(OrderDate)  
  
)  
, 
  
Sales_Quota_CTE (BusinessEntityID, SalesQuota, SalesQuotaYear)  
AS  
(  
       SELECT BusinessEntityID, SUM(SalesQuota)AS SalesQuota, YEAR(QuotaDate) AS SalesQuotaYear  
       FROM Sales.SalesPersonQuotaHistory  
       GROUP BY BusinessEntityID, YEAR(QuotaDate)  
)  
    
SELECT SalesPersonID  
  , SalesYear  
  , FORMAT(TotalSales,'C','en-us') AS TotalSales  
  , SalesQuotaYear  
  , FORMAT (SalesQuota,'C','en-us') AS SalesQuota  
  , FORMAT (TotalSales -SalesQuota, 'C','en-us') AS Amt_Above_or_Below_Quota  
FROM Sales_CTE  
JOIN Sales_Quota_CTE ON Sales_Quota_CTE.BusinessEntityID = Sales_CTE.SalesPersonID  
                    AND Sales_CTE.SalesYear = Sales_Quota_CTE.SalesQuotaYear  
ORDER BY SalesPersonID, SalesYear;
