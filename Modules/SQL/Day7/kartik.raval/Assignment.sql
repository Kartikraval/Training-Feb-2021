														
														
														--Derived Table for Day4

USE Day7_practice;
/*1. Write a query to rank employees based on their salary for a month*/

SELECT * FROM (SELECT Salary, RANK() OVER (ORDER BY Salary DESC) [RankSalary] FROM Employees) [EmpSalary] Where Salary  IS NOT NULL;

/*2. Select 4th Highest salary from employee table using ranking function*/
	/*S_rank = 3 because 2 rank is having same salary*/

SELECT * FROM (SELECT Salary FROM(SELECT Salary,DENSE_RANK() OVER (ORDER BY Salary DESC) AS S_rank FROM Employees) AS a WHERE S_rank=3) [EmpRank] WHERE Salary IS NOT NULL;

/*3. Get department, total salary with respect to a department from employee table.*/

SELECT * FROM (SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID) [EmpDept];	

/*4. Get department, total salary with respect to a department from employee table order by total salary descending*/

SELECT * FROM (SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID) [Emp_Dept] ORDER BY TotalSalary DESC;

/*5. Get department wise maximum salary from employee table order by salary ascending*/


SELECT * FROM (SELECT DepartmentID, MAX(Salary) 'Max_salary' FROM Employees GROUP BY DepartmentID) [MaxSalary];

/*6. Get department wise minimum salary from employee table order by salary ascending*/

SELECT * FROM (SELECT DepartmentID, MIN(Salary) 'Min_salary' FROM Employees GROUP BY DepartmentID) [MinSalary];
 
/*7. Select department, total salary with respect to a department from employee table where total salary greater than 50000 order by TotalSalary descending*/

SELECT * FROM (SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID) [Emp] WHERE TotalSalary > 5000;

														--Common Table Expression for Day4

USE Day7_practice;
/*1. Write a query to rank employees based on their salary for a month*/

WITH Query1(Salary_Rank,Salary)
AS
(
SELECT RANK() OVER (ORDER BY Salary DESC) [Salary_Rank], Salary FROM Employees
)

SELECT * FROM Query1;

/*2. Select 4th Highest salary from employee table using ranking function*/
	/*S_rank = 3 because 2 rank is having same salary*/

WITH Query2(Salary,S_rank)
AS
(
	SELECT Salary,DENSE_RANK() OVER (ORDER BY Salary DESC) AS S_rank FROM Employees
)
SELECT * FROM Query2 Where S_rank = 3;

/*3. Get department, total salary with respect to a department from employee table.*/

WITH Query3(DepartmentID, TotalSalary)
AS
(
SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID
)
SELECT * FROM Query3;

/*4. Get department, total salary with respect to a department from employee table order by total salary descending*/

WITH Query4(DepartmentID, TotalSalary)
AS
(
SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID
)
SELECT * FROM Query4 ORDER BY TotalSalary DESC;

/*5. Get department wise maximum salary from employee table order by salary ascending*/

WITH Query5(DepartmentID, Max_salary)
AS
(
SELECT DepartmentID, MAX(Salary) 'Max_Salary' FROM Employees GROUP BY DepartmentID
)
SELECT * FROM Query5;

/*6. Get department wise minimum salary from employee table order by salary ascending*/

WITH Query6(DepartmentID, Min_salary)
AS
(
SELECT DepartmentID, MIN(Salary) 'Min_Salary' FROM Employees GROUP BY DepartmentID
)
SELECT * FROM Query6;


/*7. Select department, total salary with respect to a department from employee table where total salary greater than 50000 order by TotalSalary descending*/

WITH Query7(DepartmentID, TotalSalary)
AS
(
SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees Where Salary >= 5000 GROUP BY DepartmentID
)
SELECT * FROM Query7;

														--Derived Table for Day5

USE Day5_practice;

/*1. Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table*/
SELECT e.JoiningDate, i.IncentiveDate, DATEDIFF(MONTH, e.JoiningDate, i.IncentiveDate) AS MONTHDIFF
FROM Employees As e INNER JOIN (SELECT EmployeeID,IncentiveDate FROM Incentives) AS i ON e.EmployeeId = i.EmployeeID;

/*2. Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000*/

SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e JOIN (SELECT EmployeeID, IncentiveAmount FROM Incentives) As i ON e.EmployeeId = i.EmployeeID WHERE i.IncentiveAmount > 3000;

/*3. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.*/

SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e LEFT OUTER JOIN (SELECT EmployeeID, IncentiveAmount FROM Incentives) As i ON e.EmployeeId = i.EmployeeID;

/*4. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.*/

UPDATE i SET IncentiveAmount = 0 FROM Incentives i LEFT OUTER JOIN Employees e ON i.EmployeeId = e.EmployeeID  WHERE i.IncentiveAmount IS NULL;

SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e LEFT OUTER JOIN (SELECT EmployeeID, IncentiveAmount FROM Incentives) As i ON e.EmployeeId = i.EmployeeID;

														--Common Table Expression for Day5


/*1. Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table*/

WITH CQuery1(JoiningDate, IncentiveDate, MonthDiff)
AS
(
SELECT e.JoiningDate, i.IncentiveDate, DATEDIFF(MONTH, e.JoiningDate, i.IncentiveDate) AS MonthDiff
FROM Employees As e INNER JOIN Incentives AS i ON e.EmployeeId = i.EmployeeID
)
SELECT * FROM CQuery1;


/*2. Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000*/

WITH CQuery2(FirstName, IncentiveAmount)
AS
(
SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e JOIN Incentives As i ON e.EmployeeId = i.EmployeeID WHERE i.IncentiveAmount > 3000
)
SELECT * FROM CQuery2;

/*3. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.*/

WITH CQuery3(FirstName, IncentiveAmount)
AS
(
SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e LEFT OUTER JOIN Incentives As i ON e.EmployeeId = i.EmployeeID
)
SELECT * FROM CQuery3;

/*4. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.*/

WITH CQuery4(FirstName, IncentiveAmount)
AS
(
SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e LEFT OUTER JOIN Incentives As i ON e.EmployeeId = i.EmployeeID
)
SELECT * FROM CQuery4;