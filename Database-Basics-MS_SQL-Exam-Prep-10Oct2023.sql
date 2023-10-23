USE master
CREATE DATABASE Accounting

USE Accounting

CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(10) NOT NULL
)

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY,
	StreetName NVARCHAR(20) NOT NULL,
	StreetNumber INT,
	PostCode INT NOT NULL,
	City VARCHAR(25) NOT NULL,
	CountryId INT FOREIGN KEY REFERENCES
	Countries(Id) NOT NULL
)

CREATE TABLE Vendors(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(25) NOT NULL,
	NumberVAT NVARCHAR(15) NOT NULL,
	AddressId INT FOREIGN KEY 
	REFERENCES Addresses(Id) NOT NULL
)

CREATE TABLE Clients(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(25) NOT NULL,
	NumberVAT NVARCHAR(15) NOT NULL,
	AddressId INT FOREIGN KEY
	REFERENCES Addresses(Id) NOT NULL
)

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(10) NOT NULL
)

CREATE TABLE Products(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(35) NOT NULL,
	Price DECIMAL(18, 2) NOT NULL,
	CategoryId INT FOREIGN KEY 
	REFERENCES  Categories(Id) NOT NULL,
	VendorId INT FOREIGN KEY
	REFERENCES Vendors(Id) NOT NULL
)

CREATE TABLE Invoices(
	Id INT PRIMARY KEY IDENTITY,
	Number INT UNIQUE NOT NULL,
	IssueDate DATETIME2 NOT NULL,
	DueDate DATETIME2 NOT NULL,
	Amount DECIMAL(18, 2) NOT NULL,
	Currency VARCHAR(5) NOT NULL,
	ClientId INT FOREIGN KEY
	REFERENCES Clients(Id) NOT NULL
)
CREATE TABLE ProductsClients(
	ProductId INT FOREIGN KEY REFERENCES 
	Products(Id) NOT NULL,
	ClientId INT FOREIGN KEY REFERENCES
	Clients(Id)
	PRIMARY KEY(ProductId, ClientId)
)

--02. Insert
INSERT INTO Products([Name], 
					 Price, 
					 CategoryId, 
					 VendorId)
VALUES
('SCANIA Oil Filter XD01', 78.69, 1, 1),
('MAN Air Filter XD01', 97.38, 1, 5),
('DAF Light Bulb 05FG87', 55.00, 2, 13),
('ADR Shoes 47-47.5', 49.85, 3, 5),
('Anti-slip pads S', 5.87, 5, 7)

INSERT INTO Invoices
(Number, IssueDate, DueDate, Amount, Currency, ClientId)
VALUES
(1219992181, '2023-03-01', '2023-04-30', 180.96, 'BGN', 3),
(1729252340, '2022-11-06', '2023-01-04', 158.18, 'EUR', 13),
(1950101013, '2023-02-17', '2023-04-18', 615.15, 'USD', 19)


--03. Update
--2023-04-01

UPDATE Invoices
SET DueDate = '2023-04-01'
WHERE YEAR(IssueDate) = 2022 
AND MONTH(IssueDate) = 11

UPDATE Clients
SET AddressId = (
	SELECT TOP(1) a.Id
	FROM Addresses AS a
	JOIN Countries AS c ON a.CountryId = c.Id
	WHERE StreetName = 'Industriestr'
	AND StreetNumber = 79
	AND PostCode = 2353
	AND City = 'Guntramsdorf'
	AND CountryId = (
						SELECT
						cou.Id
						FROM Countries AS cou
						WHERE [Name] = 'Austria'
					)
)
WHERE [Name] LIKE '%CO%'

--04_DELETE
BEGIN TRANSACTION

DELETE
FROM Invoices
WHERE ClientId IN (
					SELECT
					Id
					FROM Clients
					WHERE NumberVAT LIKE 'IT%'
				  )
DELETE FROM ProductsClients
WHERE ClientId IN (
					SELECT
					Id
					FROM Clients
					WHERE NumberVAT LIKE 'IT%'
					)


DELETE
FROM Clients
WHERE NumberVAT LIKE 'IT%'
COMMIT

--Section 3. Querying (40 pts)
--5.	Invoices by Amount and Date
SELECT
Number,
Currency
FROM Invoices
ORDER BY Amount DESC, DueDate ASC


--06. Products by Category
SELECT
	p.Id,
	p.[Name],
	p.Price,
	c.[Name]
FROM Products AS p
INNER JOIN Categories AS c 
ON p.CategoryId = c.Id
WHERE c.[Name] IN ('ADR', 'Others')
ORDER BY p.Price DESC


--07. Clients without Products
SELECT
	dt.Id,
	dt.Client,
	CONCAT_WS(', ',CONCAT(dt.StreetName, ' ', dt.StreetNumber), dt.City, dt.PostCode, dt.[Name])
	AS [Address]
	FROM

		(SELECT
			c.Id AS Id,
			c.[Name] AS Client,
			a.StreetName,
			a.StreetNumber,
			a.PostCode,
			a.City,
			cou.[Name]
		FROM Clients AS c
		LEFT JOIN ProductsClients AS pc
		ON c.Id = pc.ClientId
		INNER JOIN Addresses AS a
		ON A.Id = C.AddressId
		INNER JOIN Countries AS cou
		ON cou.Id = a.CountryId
		WHERE pc.ProductId IS NULL) AS dt
ORDER BY dt.Client ASC


--08. First 7 Invoices
SELECT TOP(7)
	i.Number,
	i.Amount,
	c.[Name] AS Client
FROM Invoices AS i
JOIN Clients AS c ON i.ClientId = c.Id
WHERE YEAR(i.IssueDate) < 2023
AND 
(i.Currency = 'EUR' OR (i.Amount >500) AND c.NumberVAT LIKE 'DE%' )
ORDER BY i.Number ASC,
i.Amount DESC

--09. Clients with VAT

SELECT
	c.[Name] AS Client,
	Max(p.Price) AS Price,
	c.NumberVAT
FROM Clients AS c
JOIN Invoices AS i ON c.Id = i.ClientId
JOIN ProductsClients AS pc ON pc.ClientId = c.Id
JOIN Products AS p ON p.Id = pc.ProductId
GROUP BY c.[Name], c.NumberVAT
HAVING  c.[Name] NOT LIKE '%KG'
ORDER BY Price DESC


--10. Clients by Price
SELECT
dt.Client,
FLOOR(dt.[Average Price]) AS [Average Price]
FROM 
	(SELECT
	c.[Name] AS Client,
	SUM(p.Price)  / (COUNT(p.Id)) AS [Average Price]
	FROM Clients AS c
	JOIN ProductsClients AS pr ON pr.ClientId = c.Id
	JOIN Products AS p ON p.Id = pr.ProductId
	JOIN Vendors AS v ON v.Id = p.VendorId
	WHERE v.NumberVAT LIKE '%FR%'
	GROUP BY c.[Name]) AS dt
ORDER BY dt.[Average Price] ASC, dt.Client DESC

--Section 4. Programmability (20 pts)
--11. Product with Clients
GO
CREATE OR ALTER FUNCTION udf_ProductWithClients
(
	@name NVARCHAR(35)
)
RETURNS INT
AS 
BEGIN
	DECLARE @count INT
	SET @count = (
					SELECT 
					COUNT(*)
					FROM ProductsClients
					WHERE ProductId IN
					(SELECT
					Id
					FROM Products
					WHERE [Name] = @name)
				 )
	RETURN @count
END
GO
SELECT dbo.udf_ProductWithClients('DAF FILTER HU12103X')

--12. Search for Vendors from a Specific Country
GO

CREATE OR ALTER PROCEDURE usp_SearchByCountry
(
	@country VARCHAR(10)
) AS 
BEGIN
	SELECT
	v.[Name] AS Vendor,
	v.NumberVAT AS VAT,
	CONCAT(a.StreetName, ' ', a.StreetNumber) AS [Street Info],
	CONCAT(a.City, ' ', a.PostCode) AS [City Info]
	FROM Addresses AS a
	JOIN Vendors AS v ON a.Id = v.AddressId
	WHERE a.CountryId = (
							SELECT
							cou.Id
							FROM Countries AS cou
							WHERE cou.[Name] = @country
						)
	ORDER BY v.[Name] ASC, a.City ASC

END


GO
EXEC usp_SearchByCountry 'France'








