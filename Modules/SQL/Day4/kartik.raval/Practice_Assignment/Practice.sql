USE Day4_practice;

SELECT * FROM Employees;

SELECT DENSE_RANK() OVER (ORDER BY Salary DESC) [d_rank], Salary FROM Employees;

SELECT RANK() OVER (ORDER BY Salary DESC) [d_rank], Salary FROM Employees;

SELECT ROW_NUMBER() OVER (ORDER BY Salary DESC) [d_rank], Salary FROM Employees;

SELECT NTILE(11) OVER (ORDER BY SALARY DESC) [d_rank], Salary FROM Employees;

SELECT SUM(Salary) FROM Employees;

SELECT COUNT(*) FROM Employees;

SELECT AVG(Salary) FROM Employees;

SELECT MAX(Salary) FROM Employees;

SELECT MIN(Salary) FROM Employees;

SELECT * FROM Employees;

SELECT  FirstName, LastName, Sum(Salary) AS TotalSalary FROM Employees GROUP BY ROLLUP(FirstName, LastName);

SELECT FirstName , MAX(Salary) AS 'Salary' FROM Employees GROUP BY FirstName;

SELECT * INTO Temp FROM Employees;