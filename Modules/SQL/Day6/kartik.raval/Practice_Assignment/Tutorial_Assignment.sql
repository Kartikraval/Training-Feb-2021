USE Day6_practice


/*SubQuery*/


/*1. Write a query to find the names (first_name, last_name) and salaries of the employees who have higher salary than the employee whose last_name='Bull'. */

SELECT Firstname, LastName, Salary FROM Employees WHERE Salary > (SELECT Salary FROM Employees WHERE LastName = 'Bull');

/*2. Find the names (first_name, last_name) of all employees who works in the IT department. */
SELECT * FROM Departments;

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName From Employees e Where DepartmentID IN (SELECT DepartmentID FROM Departments d WHERE DepartmentName LIKE 'IT%');

/*3. Find the names (first_name, last_name) of the employees who have a manager who works for a department based in United States. 
	 Hint : Write single-row and multiple-row subqueries
*/
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Locations;
SELECT * FROM Countries;
SELECT * FROM JobHistory;

SELECT FirstName, LastName FROM Employees 
WHERE ManagerID in (select EmployeeID 
FROM Employees WHERE DepartmentID 
IN (SELECT DepartmentID FROM Departments WHERE LocationID 
IN (select LocationID from Locations where CountryID='US')));


/*4. Find the names (first_name, last_name) of the employees who are managers. */

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName FROM Employees Where EmployeeID IN (SELECT ManagerID FROM Employees WHERE ManagerID != 0);

/*5. Find the names (first_name, last_name), salary of the employees whose salary is greater than the average salary. */

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName, Salary FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);

/*6. Find the names (first_name, last_name), salary of the employees whose salary is equal to the minimum salary for their job grade. */

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName, Salary FROM Employees WHERE Employees.Salary IN (SELECT MIN(Salary) FROM Employees);

/*7. Find the names (first_name, last_name), salary of the employees who earn more than the average salary and who works in any of the IT departments. */

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName, Salary FROM Employees WHERE DepartmentID IN (SELECT DepartmentName FROM Departments WHERE DepartmentName LIKE 'IT%') AND Salary > (SELECT AVG(Salary) FROM Employees);

/*8. Find the names (first_name, last_name), salary of the employees who earn more than Mr. Bell.*/

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName, Salary FROM Employees WHERE Salary > (SELECT Salary FROM Employees WHERE LastName = 'Bell');

/*9. Find the names (first_name, last_name), salary of the employees who earn the same salary as the minimum salary for all departments.*/

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName, Salary FROM Employees WHERE Salary = (SELECT MIN(Salary) FROM Employees);

/*10. Find the names (first_name, last_name), salary of the employees whose salary greater than average salary of all department. */

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName, Salary FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees);

/*11. Write a query to find the names (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results on salary from the lowest to highest. */

SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName, Salary FROM Employees WHERE Salary > ALL (SELECT Salary FROM Employees WHERE JobId = 'SH_CLERK') ORDER BY Salary;

/*12. Write a query to find the names (first_name, last_name) of the employees who are not supervisors.*/

SELECT b.FirstName,b.FirstName 
FROM Employees b 
WHERE NOT EXISTS (SELECT 'X' FROM Employees a WHERE a.ManagerID = b.EmployeeID);

/*13. Write a query to display the employee ID, first name, last names, and department names of all employees. */

SELECT EmployeeID, FirstName, LastName, (SELECT DepartmentName FROM Departments d Where e.DepartmentID = d.DepartmentID) FROM Employees e;

/*14. Write a query to display the employee ID, first name, last names, salary of all employees whose salary is above average for their departments. */

SELECT EmployeeID, FirstName, LastName FROM Employees e WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE DepartmentID = e.DepartmentID);

/*16. Write a query to find the 5th maximum salary in the employees table. */

SELECT DISTINCT Salary FROM Employees e WHERE 5 = (SELECT COUNT(DISTINCT Salary) FROM Employees s WHERE e.Salary >= s.Salary);

/*17. Write a query to find the 4th minimum salary in the employees table.*/

SELECT DISTINCT Salary FROM Employees e WHERE 4 = (SELECT COUNT(DISTINCT Salary) FROM Employees s WHERE e.Salary <= s.Salary);

/*18. Write a query to select last 10 records from a table. */

SELECT * FROM Employees ORDER BY EmployeeID DESC LIMIT 10;

/*19. Write a query to list department number, name for all the departments in which there are no employees in the department. */

SELECT * FROM Departments WHERE DepartmentId NOT IN (SELECT DepartmentId FROM Employees);

/*20. Write a query to get 3 maximum salaries. */

SELECT TOP 3 Salary FROM Employees;

/*21. Write a query to get 3 minimum salaries.*/

SELECT DISTINCT Salary FROM Employees a 
WHERE  3 >= (SELECT COUNT(DISTINCT Salary) 
FROM Employees b 
WHERE b.Salary <= a.Salary) 
ORDER BY a.Salary DESC;

/*22. Write a query to get nth max salaries of employees.*/

SELECT * FROM Employees emp1
WHERE (1) = ( SELECT COUNT(DISTINCT(emp2.Salary))
FROM Employees emp2
WHERE emp2.Salary > emp1.Salary);




/*View*/

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Locations;
SELECT * FROM Countries;
SELECT * FROM JobHistory;

/*1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.*/

ALTER VIEW Query1 AS
SELECT LocationId, StreetAddress, City, StateProvince,(Select CountryName FROM Countries Where CountryID = l.CountryID) AS CountryName FROM Locations l;
SELECT * FROM Query1;

/*2. Write a query to find the names (first_name, last name), department ID and name of all the employees. */

ALTER VIEW Query2 AS
SELECT CONCAT(FirstName, ' ', LastName) AS EmployeeName, DepartmentId, (SELECT DepartmentName FROM Departments Where DepartmentID= e.DepartmentID) AS Department FROM Employees e;
SELECT * FROM Query2;

/*3. Find the names (first_name, last_name), job, department number, and department name of the employees who work in London. */

CREATE VIEW Query3 AS
SELECT FirstName, LastName, JobID FROM Employees WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE LocationID = (SELECT LocationID FROM Locations WHERE City = 'London'));
SELECT * FROM Query3;

/*4. Write a query to find the employee id, name (last_name) along with their manager_id, manager name (last_name). */

ALTER VIEW Query4 AS
SELECT DISTINCT e.EmployeeId, e.LastName, m.ManagerID, m.LastName AS Manager FROM Employees e JOIN Employees m ON (e.ManagerID = m.ManagerID);
SELECT * FROM Query4;

/*5. Find the names (first_name, last_name) and hire date of the employees who were hired after 'Jones'. */

CREATE VIEW Query5 AS
SELECT e.FirstName, e.LastName, e.HireDate FROM Employees e JOIN Employees j ON (j.LastName = 'Jones') WHERE j.HireDate < e.HireDate;
SELECT * FROM Query5;

/*6. Write a query to get the department name and number of employees in the department. */

CREATE VIEW Query6 AS
SELECT DepartmentName, COUNT(*) AS NoOFEmployees FROM Departments INNER JOIN Employees ON Employees.DepartmentID = Departments.DepartmentID GROUP BY Departments.DepartmentID, DepartmentName;
SELECT * FROM Query6;

/*7. Find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90 from job history.*/ 

CREATE VIEW Query7 AS
SELECT EmployeeId, JobID AS 'Jobs', DATEDIFF(DAY, StartDate, EndDate) AS 'Days' FROM JobHistory WHERE DepartmentID = 90;
SELECT * FROM Query7;

/*8. Write a query to display the department ID, department name and manager first name. */

CREATE VIEW Query9 AS
SELECT d.DepartmentID, d.DepartmentName, d.ManagerID, e.FirstName FROM Departments d INNER JOIN Employees e ON (d.ManagerID = e.EmployeeID);
SELECT * FROM Query9;

/*9. Write a query to display the department name, manager name, and city. */

CREATE VIEW Query8 AS
SELECT d.DepartmentName, e.FirstName, l.City FROM Departments d 
INNER JOIN Locations l ON d.LocationID = l.LocationID
INNER JOIN Employees e ON e.ManagerID = d.ManagerID;
SELECT * FROM Query8;

/*10. Write a query to display the job title and average salary of employees. */

CREATE VIEW Query10 AS
SELECT JobId, AVG(Salary) AS 'Salary' FROM Employees GROUP BY JobId;
SELECT * FROM Query10;

/*11. Display job title, employee name, and the difference between salary of the employee and minimum salary for the job. */

CREATE VIEW Query12 AS
SELECT JobId, FirstName, LastName, (Salary - MIN(Salary)) AS 'SalaryDifference' FROM Employees;
SELECT * FROM Query13;

/*12. Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary. */

CREATE VIEW Query12 AS
SELECT j.* FROM JobHistory j INNER JOIN Employees e ON (j.EmployeeID = e.EmployeeID) WHERE salary > 10000;
SELECT * FROM Query11;

/*13. Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years. */
/*Already Done in Assignment*/
SELECT DepartmentName, FirstName, LastName, DateDiff(YY,HireDate,CURRENT_TIMESTAMP) 'Experience', Salary FROM A4_View WHERE DateDiff(YY,HireDate,CURRENT_TIMESTAMP) > 15;

