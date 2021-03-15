USE Day6_practice;

SELECT * FROM Employees;

SELECT * FROM Employees a, Employees b WHERE a.FirstName = 'John' AND b.LastName = 'Chen' AND a.Salary > b.Salary;  

SELECT FirstName, Salary FROM Employees WHERE Salary > (SELECT Salary FROM Employees WHERE FirstName = 'Nancy');

USE AdventureWorks2012

SELECT * FROM HumanResources.Employee;

SELECT * FROM HumanResources.EmployeeDepartmentHistory

SELECT * FROM Person.Person;

SELECT JobTitle FROM HumanResources.Employee WHERE BusinessEntityID IN(SELECT BusinessEntityID FROM HumanResources.EmployeeDepartmentHistory Where DepartmentID = 40);

USE Day6_practice

SELECT * FROM Employees;

SELECT * FROM Employees e Where Salary = (SELECT MAX(Salary) FROM Employees WHERE DepartmentID = e.DepartmentID);


