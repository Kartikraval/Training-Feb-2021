/*1. Write a query to rank employees based on their salary for a month*/

	SELECT RANK() OVER (ORDER BY Salary DESC) [Salary], Salary FROM Temp;

/*2. Select 4th Highest salary from employee table using ranking function*/
	/*S_rank = 3 because 2 rank is having same salary*/

	SELECT Salary FROM(SELECT Salary,DENSE_RANK() over(ORDER BY Salary DESC) AS S_rank FROM Temp) as a where S_rank=3;

/*3. Get department, total salary with respect to a department from employee table.*/
      
	SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Temp GROUP BY DepartmentID;

/*4. Get department, total salary with respect to a department from employee table order by total salary descending*/

	SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Temp GROUP BY DepartmentID ORDER BY TotalSalary DESC;

/*5. Get department wise maximum salary from employee table order by salary ascending*/

	SELECT DepartmentID, MAX(Salary) FROM TEMP GROUP BY DepartmentID;

/*6. Get department wise minimum salary from employee table order by salary ascending*/

	SELECT DepartmentID, MIN(Salary) FROM TEMP GROUP BY DepartmentID;

/*7. Select department, total salary with respect to a department from employee table where total salary greater than 50000 order by TotalSalary descending*/

	SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Temp Where Salary >= 5000 GROUP BY DepartmentID ;