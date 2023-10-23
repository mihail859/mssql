---Database Basics MS SQL Exam – 12 Feb 2023
--Section 1. DDL (30 pts)
GO
CREATE DATABASE Boardgames

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY,
	StreetName NVARCHAR(100) NOT NULL,
	StreetNumber INT NOT NULL,
	Town VARCHAR(30) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	ZIP INT NOT NULL
)

CREATE TABLE Publishers(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) UNIQUE NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id) NOT NULL,
	Website NVARCHAR(40),
	Phone NVARCHAR(20)
)

CREATE TABLE PlayersRanges(
	Id INT PRIMARY KEY IDENTITY,
	PlayersMin INT NOT NULL,
	PlayersMax INT NOT NULL
)

CREATE TABLE Boardgames(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	YearPublished INT NOT NULL,
	Rating DECIMAL(8, 2) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES 
	Categories(Id) NOT NULL,
	PublisherId INT FOREIGN KEY REFERENCES 
	Publishers(Id) NOT NULL,
	PlayersRangeId INT FOREIGN KEY REFERENCES
	PlayersRanges(Id) NOT NULL
)
CREATE TABLE Creators(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Email NVARCHAR(30) NOT NULL
)

CREATE TABLE CreatorsBoardgames(
	CreatorId INT FOREIGN KEY REFERENCES Creators(Id) NOT NULL,
	BoardgameId INT FOREIGN KEY REFERENCES Boardgames(Id) NOT NULL,
	PRIMARY KEY(CreatorId, BoardgameId)
)

GO

--02_Insert
INSERT INTO Boardgames([Name], 
						YearPublished,
						Rating,
						CategoryId,
						PublisherId,
						PlayersRangeId)
	VALUES
	('Deep Blue', 2019, 5.67, 1, 15, 7),
	('Paris', 2016, 9.78, 7, 1, 5),
	('Catan: Starfarers',2021,  9.87, 7, 13, 6),
	('Bleeding Kansas', 2020, 3.25, 3,  7, 4), 
	('One Small Step',2019,  5.75, 5, 9, 2)

INSERT INTO Publishers([Name], AddressId, Website, Phone)
VALUES
('Agman Games', 5, 'www.agmangames.com', '+16546135542'),
('Amethyst Games', 7, 'www.amethystgames.com', '+15558889992'),
('BattleBooks', 13, 'www.battlebooks.com', '+12345678907')

--03_Update



UPDATE PlayersRanges
SET PlayersMax = PlayersMax + 1
WHERE PlayersMin = 2 AND PlayersMax = 2

UPDATE Boardgames
SET [Name] += 'V2'
WHERE YearPublished>=2020

--04_DELETE
DELETE FROM CreatorsBoardgames
WHERE BoardgameId IN(
						SELECT b.Id
						FROM Boardgames AS b
						JOIN Publishers AS p ON b.PublisherId = p.Id
						JOIN Addresses AS a ON p.AddressId = a.Id
						WHERE a.Town LIKE 'L%'
					
					)

DELETE
FROM Boardgames
WHERE PublisherId IN (
						SELECT
						p.Id
						FROM Publishers AS p
						JOIN Addresses AS a ON p.AddressId = a.Id
						WHERE a.Town LIKE 'L%'
					)

DELETE
FROM Publishers
WHERE AddressId = (SELECT
						[Id]
					FROM Addresses
					WHERE Town LIKE 'L%')
DELETE
FROM Addresses
WHERE Town LIKE 'L%'

--05_ Boardgames by Year of Publication
SELECT
	[Name],
	Rating
FROM Boardgames
ORDER BY YearPublished ASC,
		 [Name] DESC

--06-Boardgames by Category
SELECT 
	b.Id,
	b.[Name],
	YearPublished,
	c.[Name] AS CategoryName
FROM Boardgames AS b
JOIN Categories AS c ON b.CategoryId = c.Id
WHERE c.[Name] IN('Strategy Games', 'Wargames')
ORDER BY YearPublished DESC

--07. Creators without Boardgames
SELECT
	*
FROM CreatorsBoardgames


SELECT
	c.Id,
	CONCAT(c.FirstName, ' ',c.LastName) AS CreatorName,
	c.Email
FROM Creators AS c
LEFT JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
WHERE cb.CreatorId IS NULL
ORDER BY c.FirstName ASC

--08_First 5 Boardgames
SELECT TOP(5)
	b.[Name],
	b.Rating,
	c.[Name] AS CategoryName
FROM Boardgames AS b
JOIN Categories AS c ON b.CategoryId = c.Id
JOIN PlayersRanges AS pr ON pr.Id = b.PlayersRangeId
WHERE (Rating > 7.00 AND b.[Name] LIKE '%a%')
OR (b.Rating > 7.50 AND (pr.PlayersMin = 2 AND pr.PlayersMax = 5))
ORDER BY b.[Name] ASC,
		b.Rating DESC


--09_Creators with Emails
SELECT
	CONCAT_WS(' ', dt.FirstName, dt.LastName) AS FullName,
	dt.Email,
	dt.Rating
	FROM

		(SELECT
			c.FirstName,
			c.LastName,
			c.Email,
			MAX(Rating) AS Rating
		FROM Creators AS c
		JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
		JOIN Boardgames AS b ON b.Id = cb.BoardgameId
		GROUP BY c.FirstName, c.LastName, c.Email) AS dt
WHERE dt.Email LIKE '%.com'


--10. Creators by Rating
SELECT
dt.LastName,
CEILING(dt.AverageRating) AS AverageRating,
dt.PublisherName
FROM
	(SELECT
		c.LastName,
		AVG(b.Rating) AS AverageRating,
		p.[Name] AS PublisherName
	FROM Creators AS c
	JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
	JOIN Boardgames AS b ON b.Id = cb.BoardgameId
	JOIN Publishers AS p ON p.Id = b.PublisherId
	GROUP BY c.LastName,p.[Name]) AS dt
WHERE dt.PublisherName = 'Stonemaier Games'
ORDER BY dt.AverageRating DESC

--11. Creator with Boardgames
GO
CREATE OR ALTER FUNCTION udf_CreatorWithBoardgames(@name NVARCHAR(30))
RETURNS INT
AS 
BEGIN
	DECLARE @boardgames INT
	SET @boardgames = (
						SELECT
						COUNT(Id)
						FROM Creators AS c
						JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
						GROUP BY FirstName
						HAVING FirstName = @name
						)
	RETURN @boardgames
END

GO

SELECT dbo.udf_CreatorWithBoardgames('Bruno')
GO
CREATE OR ALTER PROCEDURE usp_SearchByCategory
(
	@category VARCHAR(50)
) AS
BEGIN
	SELECT
	b.[Name],
	b.YearPublished,
	b.Rating,
	c.[Name] AS CategoryName,
	p.[Name] AS PublisherName,
	CONCAT(pr.PlayersMin,' ', 'people') AS MinPlayers,
	CONCAT(pr.PlayersMax,' ', 'people') AS MaxPlayers 
	FROM Boardgames AS b
	JOIN Categories AS c
	ON b.CategoryId = c.Id
	JOIN Publishers AS p 
	ON p.Id = b.PublisherId
	JOIN PlayersRanges AS pr
	ON pr.Id = b.PlayersRangeId
	WHERE c.[Name] = @category
	ORDER BY PublisherName ASC,
	YearPublished DESC
END
GO
EXEC usp_SearchByCategory 'Wargames'