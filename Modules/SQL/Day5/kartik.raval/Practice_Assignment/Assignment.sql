CREATE TABLE Employee
(
	EmployeeId INT NOT NULL CONSTRAINT PKEmpid PRIMARY KEY IDENTITY,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	Salary MONEY,
	JoiningDate Date NOT NULL,
	Department VARCHAR(20),
	ManagerID int 
)

CREATE TABLE Incentives
(
	IncentiveID INT NOT NULL CONSTRAINT PKIncId PRIMARY KEY IDENTITY, 
	EmployeeID INT CONSTRAINT FKEmpid FOREIGN KEY REFERENCES Employees(EmployeeId),
	IncentiveDate Date NOT NULL,
	IncentiveAmount MONEY
)

SELECT * FROM Employees;

SELECT * FROM Incentives;

/*1. Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table*/

SELECT e.JoiningDate, i.IncentiveDate, DATEDIFF(MONTH, e.JoiningDate, i.IncentiveDate) AS MONTHDIFF
FROM Employees As e INNER JOIN Incentives AS i ON e.EmployeeId = i.EmployeeID;

/*2. Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000*/

SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e JOIN Incentives As i ON e.EmployeeId = i.EmployeeID WHERE i.IncentiveAmount > 3000;

/*3. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.*/

SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e LEFT OUTER JOIN Incentives As i ON e.EmployeeId = i.EmployeeID;

/*4. Select EmployeeName, ManagerName from the employee table.*/

SELECT CONCAT(FirstName,' ', LastName), ManagerID from Employees;

/*5. Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives and set incentive amount as 0 for those employees who didn’t get incentives.*/

UPDATE i SET IncentiveAmount = 0 FROM Incentives i LEFT OUTER JOIN Employees e ON i.EmployeeId = e.EmployeeID  WHERE i.IncentiveAmount IS NULL;

SELECT e.FirstName, i.IncentiveAmount 
FROM Employees As e LEFT OUTER JOIN Incentives As i ON e.EmployeeId = i.EmployeeID;