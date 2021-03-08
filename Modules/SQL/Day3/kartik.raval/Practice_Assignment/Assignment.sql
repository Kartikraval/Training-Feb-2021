
USE Day3_practice

/*1. Write a query that displays the FirstName and the length of the FirstName for all employees whose name starts with the letters ‘A’, ‘J’ or ‘M’. Give each column an appropriate label. Sort the results by the employees’ FirstName*/

SELECT FirstName, LENGTH = LEN(FirstName) FROM Employees WHERE FirstName LIKE 'A%' OR FirstName LIKE 'J%' OR FirstName LIKE 'M%';

/*2. Write a query to display the FirstName and Salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY.*/

SELECT FirstName, Concat('$', Salary, '0000') AS SALARY FROM Employees;

/*3. Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year.*/

SELECT EmployeeID, FirstName, LastName, HireDate FROM Employees where day(HireDate) = day(DATEADD(day, 7, getdate()));

/*5. Write a query to extract the last 4 character of PhoneNumber.*/

SELECT RIGHT (PhoneNumber,4) FROM Employees;

/*6. Write a query to update the portion of the PhoneNumber in the employees table, within the phone number the substring ‘124’ will be replaced by ‘999’.*/
UPDATE Employees SET PhoneNumber = STUFF(PhoneNumber, 5, 3, '999') WHERE PhoneNumber = Stuff(PhoneNumber,5,3,'124'); 

SELECT * FROM Employees;

/*8. Write a query to get the distinct Mondays from HireDate in employees tables.*/

SELECT DISTINCT {fn TIMESTAMPDIFF(SQL_TSI_WEEK, {fn CURDATE()}, HireDate)} AS Mondays FROM Employees;

/*9. Write a query to get the FirstName and HireDate from Employees table where HireDate between ‘1987-06-01’ and ‘1987-07-30’*/

SELECT FirstName, HireDate from Employees WHERE HireDate BETWEEN '1987-06-01' AND '1987-07-30';

/*10. Write a query to display the current date in the following format.
  11. Sample output : 12:00 AM Sep 5, 2014*/

Select FORMAT (GETDATE(), 'hh:mm tt MMM dd'+', '+'yyyy' ) AS DATE;

/*12. Write a query to get the FirstName, LastName who joined in the month of June.*/

SELECT FirstName, LastName FROM Employees WHERE MONTH(HireDate) = 6;

/*13. Write a query to get first name, hire date and experience of the employees.*/

SELECT  DATEDIFF(MM, 08-03-2021, HireDate)/12 FROM Employees;

/*14. Write a query to get first name of employees who joined in 1987.*/

SELECT FirstName from Employees where HireDate Between '1987-01-01' AND '1987-12-31';

SELECT * FROM Employees;