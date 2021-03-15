USE Day5_practice;

CREATE TABLE Cars
(
CarId INT NOT NULL CONSTRAINT Pkcarid PRIMARY KEY IDENTITY,
VIN VARCHAR(20) NOT NULL,
Make VARCHAR(20) NOT NULL,
YEAR Date NOT NULL,
Mileage INT,
AskPrice MONEY,
InvoicePrice MONEY
)


CREATE TABLE Dealerships 
(
DealershipId INT NOT NULL CONSTRAINT PkdId PRIMARY KEY IDENTITY,
Name VARCHAR(20) NOT NULL,
Address VARCHAR(50) NOT NULL,
City VARCHAR(20) NOT NULL,
State VARCHAR(20) NOT NULL
)


CREATE TABLE SalesPersons
(
SalesPersonsId INT NOT NULL CONSTRAINT PkSalesId PRIMARY KEY IDENTITY,
Name VARCHAR(20)
)

DROP TABLE SalesPersons;

CREATE TABLE Customers
(
CustomerId INT NOT NULL CONSTRAINT PkCustId PRIMARY KEY IDENTITY,
Name VARCHAR(20) NOT NULL,
Address VARCHAR(30) NOT NULL,
City VARCHAR(20) NOT NULL,
State VARCHAR(20) NOT NULL
)

CREATE TABLE ReportsTo 
(
ReportsToId INT NOT NULL CONSTRAINT PkReportId PRIMARY KEY IDENTITY,
SalesPersonsId INT CONSTRAINT FKsalesId FOREIGN KEY REFERENCES SalesPersons(SalesPersonsId),
ManagingSalesPersonId INT NOT NULL
)
DROP TABLE ReportsTo
CREATE TABLE WorkSat
(
WorksatId INT NOT NULL CONSTRAINT PkWorkId PRIMARY KEY IDENTITY,
SalesPersonsId INT CONSTRAINT FKsaleswId FOREIGN KEY REFERENCES SalesPersons(SalesPersonsId),
DealershipId INT CONSTRAINT FKdealerId FOREIGN KEY REFERENCES Dealerships(DealershipId), 
MonthWorked INT,
BaseSalaryForMonth MONEY
)

CREATE TABLE Inventory
(
InventoryId INT NOT NULL CONSTRAINT PkInvId PRIMARY KEY IDENTITY,
Vin VARCHAR(20) NOT NULL,
CarId INT CONSTRAINT FKCarId FOREIGN KEY REFERENCES Cars(CarId),
DealershipId INT CONSTRAINT FKdealerInvId FOREIGN KEY REFERENCES Dealerships(DealershipId)
)

CREATE TABLE Sales
(
SalesId INT NOT NULL CONSTRAINT PksaleId PRIMARY KEY IDENTITY,
VIN VARCHAR(20) NOT NULL,
CustomerId INT CONSTRAINT FKCustId FOREIGN KEY REFERENCES Customers(CustomerId),
SalesPersonsId INT CONSTRAINT FKsalesSalesId FOREIGN KEY REFERENCES SalesPersons(SalesPersonsId),
DealershipId INT CONSTRAINT FKdealerSalesId FOREIGN KEY REFERENCES Dealerships(DealershipId),
SalesPrice MONEY NOT NULL,
SalesDate Date NOT NULL
)

/* Find the names of all salespeople who have ever worked for the company at any dealership.*/

SELECT * FROM SalesPersons;
SELECT * FROM Sales;
SELECT * FROM Dealerships;

SELECT sp.Name FROM Sales AS s
INNER JOIN SalesPersons AS sp ON s.SalesPersonsId = sp.SalesPersonsId
INNER JOIN Dealerships AS d ON s.DealershipId = d.DealershipId AND d.DealershipId IS NOT NULL;
	
/* List the Name, Street Address, and City of each customer who lives in Ahmedabad.*/

SELECT * FROM Customers;

SELECT Name, Address, City FROM Customers WHERE City = 'Ahmedabad'; 

/* List the VIN, make, model, year, and mileage of all cars in the inventory of the dealership named "Hero Honda Car World".*/

SELECT * FROM Cars;
SELECT * FROM Inventory;
SELECT * FROM Dealerships;
	
ALTER TABLE Dealerships
    ADD CarId INT,
    FOREIGN KEY(CarId) REFERENCES Cars(CarId);

SELECT DISTINCT c.VIN, c.Make, c.YEAR, c.Mileage, d.Name FROM Cars AS c 
INNER JOIN Inventory AS i ON c.CarId = i.CarId
INNER JOIN Dealerships AS d ON c.CarId = d.CarId WHERE Name = 'Hero Honda Car World';

/* List names of all customers who have ever bought cars from the dealership named "Concept Hyundai".*/
SELECT * FROM Customers;
SELECT * FROM Dealerships;

ALTER TABLE Dealerships
    ADD CustomerId INT,
    FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId);

SELECT DISTINCT c.Name FROM Customers AS c 
INNER JOIN Dealerships AS d ON c.CustomerId = d.CustomerId WHERE d.Name = 'Concept Hyundai';

/* For each car in the inventory of any dealership, list the VIN, make, model, and year of the car, along with the name, city, 
and state of the dealership whose inventory contains the car.*/

/* Find the names of all salespeople who are managed by a salesperson named "Adam Smith".*/

SELECT s.Name FROM SalesPersons AS s 
INNER JOIN ReportsTo AS r ON s.SalesPersonsId = r.SalesPersonsId WHERE ManagingSalesPersonID = 1; /*Because ADAM SMITH ID is 1*/

/* Find the names of all salespeople who do not have a manager.*/

SELECT * FROM SalesPersons;
SELECT * FROM ReportsTo;

SELECT s.Name FROM SalesPersons AS s 
INNER JOIN ReportsTo AS r ON s.SalesPersonsId = r.SalesPersonsId WHERE r.ManagingSalesPersonId IS NULL;

/*. Find the total number of dealerships.*/

SELECT COUNT(DealershipId) 'Total Dealership' FROM Dealerships;

/* List the VIN, year, and mileage of all "Toyota Camrys" in the inventory of the dealership named "Toyota Performance". (Note that a "Toyota Camry" is indicated by the make being "Toyota" and the model being "Camry".)*/

SELECT * FROM Cars;

SELECT c.VIN, c.Year, c.Mileage FROM Cars AS c 
INNER JOIN Dealerships d ON c.CarId = d.CarId WHERE d.Name LIKE 'Toyoto%';

/* Find the name of all customers who bought a car at a dealership located in a state other than the state in which they live.*/

SELECT c.Name FROM Customers AS c 
JOIN Dealerships d ON c.CustomerId = d.CustomerId WHERE d.State != 'Gujarat';

/* List the name, street address, city, and state of any customer who has bought more than two cars from all dealerships combined since January 1, 2010.*/

SELECT * FROM Dealerships;
SELECT * FROM Customers;
/*Remaining*/
SELECT  COUNT(d.CustomerId), c.Name, c.Address, c.City, c.State FROM Customers AS c
JOIN Dealerships AS d ON c.CustomerId = d.CustomerId GROUP BY d.CustomerId;

/* List the name, salesperson ID, and total sales amount for each salesperson who has ever sold at least one car. The total sales amount for a salesperson is the sum of the sale prices of all cars ever sold by that salesperson.*/

SELECT sp.SalesPersonsId, sp.Name, SUM(s.Salesprice) FROM Sales s
INNER JOIN SalesPersons sp ON s.SalesPersonsId = sp.SalesPersonsId GROUP BY sp.SalesPersonsId, sp.Name;

/* Find the names of all customers who bought cars during 2010 who were also salespeople during 2010. For the purpose of this query, assume that no two people have the same name.*/

SELECT c.Name FROM Customers AS c
INNER JOIN Sales AS s ON c.CustomerId = s.CustomerId WHERE s.SalesDate BETWEEN '2010-01-01' AND '2010-12-31';


