USE Day6_practice

/*
Employees, Departments, Locations, Countries, JobHistory
*/

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Locations;
SELECT * FROM Countries;
SELECT * FROM JobHistory;

/*1. Select employee details from employee table if data exists in incentive table ?*/

SELECT * FROM Employees WHERE EXISTS (SELECT * from Employees WHERE CommissionPct IS NOT NULL);

/*2. Find Salary of the employee whose salary is more than John Salary*/

SELECT Salary FROM Employees WHERE Salary > (SELECT MAX(e.Salary) FROM Employees e WHERE FirstName = 'John');

/*3. Create a view to select FirstName,LastName,Salary,JoiningDate,IncentiveDate and IncentiveAmount*/

SELECT FirstName, LastName, Salary, JoiningDate, IncentiveDate, IncentiveAmount FROM A5_View;

/*4. Create a view to select Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000*/

SELECT FirstName, LastName, Salary, JoiningDate, IncentiveDate, IncentiveAmount FROM A5_View WHERe IncentiveAmount > 3000;

/*5. Create a View to Find the names (first_name, last_name), job, department number, and department name of the employees who work in London*/

CREATE VIEW LondonCity AS
SELECT FirstName, LastName, JobID FROM Employees WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE LocationID = (SELECT LocationID FROM Locations WHERE City = 'London'));
SELECT * FROM LondonCity;

/*6. Create a View to get the department name and number of employees in the department.*/

SELECT DepartmentName, COUNT(EmployeeID) AS Employees From A2_View GROUP BY DepartmentName

/*7. Find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90 from job history.*/

SELECT EmployeeID, JobId
FROM Employees e WHERE e.DepartmentID IN (SELECT DATEDIFF(DAY, StartDate, EndDate) AS NumberOfDays FROM JobHistory j WHERE j.DepartmentID = 90);

/*8. Write a View to display the department name, manager name, and city.*/

SELECT DISTINCT FirstName AS Manager, DepartmentName, City FROM A3_View;

/*9. Create a View to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.*/

SELECT DepartmentName, FirstName, LastName, DateDiff(YY,HireDate,CURRENT_TIMESTAMP) 'Experience', Salary FROM A4_View WHERE DateDiff(YY,HireDate,CURRENT_TIMESTAMP) > 15;