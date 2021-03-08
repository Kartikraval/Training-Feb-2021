USE AdventureWorks2012

/*Function*/
SELECT * FROM Person.Person

SELECT * FROM Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderDetail

SELECT * FROM Sales.SalesPerson;

SELECT FirstName,LastName, ISNULL(MiddleName,'Not Available') AS 'IsNullMiddleName',COALESCE(MiddleName,'Not Availabe') AS 'CoalesceMiddleName' FROM Person.Person;

/*PRACTICE*/

USE Day3_practice

SELECT ASCII('B') AS B;

SELECT CHAR(96) AS Value;

SELECT CHARINDEX ('V','MICROSOFT SQL SERVER 2018');

SELECT CONCAT('JOHN',' ','SMITH');

DECLARE @d DATETIME = '01/01/2012'; SELECT FORMAT (@d,'d','en-US');
	
SELECT LEFT ('MICROSOFT SQL SERVER',6);

SELECT LEN('John Smith');

SELECT LOWER('HELP EVERYONE');

SELECT LTRIM(' John Smith');

SELECT RTRIM('John Smith ');

SELECT PATINDEX('%VER%','SQL SERVER');

SELECT REPLACE('Hello World','World','Links');

SELECT SOUNDEX('HELLO HI WORLD');

SELECT SPACE(20);

SELECT STR(150);

SELECT STUFF('515.124.4169', 5, 3, '999');

SELECT SUBSTRING('SQL TUTORIAL', 1, 3);

SELECT TRANSLATE('Monday','Monday','Friday');

SELECT TRIM('           Hello              ');

SELECT UNICODE('Bombay');

SELECT REPLICATE('SQL Tutorial ', 2);

SELECT REVERSE('SQL Tutorial ');

SELECT RIGHT('SQL Tutorial', 8);

USE AdventureWorks2012
SELECT * FROM Person.Person;

SELECT Name = Title + ' ' + LEFT(FirstName,1) + '. ' + LastName FROM Person.Person;

SELECT DATEADD(mm,3,'2009-01-01');

SELECT DATENAME(month, convert(datetime,'2005-06-06'));

SELECT GETDATE();

SELECT Day('2009-01-05');

USE AdventureWorks2012

SELECT * FROM HumanResources.Employee;

SELECT CEILING(14.45);

SELECT FLOOR(14.45);

SELECT EXP(4.5);

SELECT POWER(4,2);

SELECT STR(15,10);


