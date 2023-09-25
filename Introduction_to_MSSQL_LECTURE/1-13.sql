CREATE DATABASE [Movies]
USE [Movies]

--•	Directors (Id, DirectorName, Notes)
CREATE TABLE [Directors](
	[Id] INT PRIMARY KEY NOT NULL,
	[DirectorName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(MAX)
)
--•	Genres (Id, GenreName, Notes)
CREATE TABLE [Genres](
	[Id] INT PRIMARY KEY NOT NULL, 
	[GenreName] NVARCHAR(30) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

--•	Categories (Id, CategoryName, Notes)
CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY NOT NULL,
	[CategoryName] NVARCHAR(30) NOT NULL, 
	[Notes] NVARCHAR(MAX)
)

--•	Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
CREATE TABLE [Movies](
	[Id] INT PRIMARY KEY NOT NULL,
	[Title] NVARCHAR(30) NOT NULL,
	[DirectorId] INT NOT NULL,
	[CopyrightYear] SMALLINT NOT NULL,
	[Length] TINYINT NOT NULL,
	[GenreId] TINYINT NOT NULL,
	[CategoryId] TINYINT NOT NULL,
	[Rating] TINYINT NOT NULL,
	[Notes] NVARCHAR(MAX) 
)

INSERT INTO [Categories]([Id], [CategoryName])
VALUES
(11, 'ACTION'),
(21, 'COMEDY'), 
(1, 'ACTION'),
(2, 'COMEDY'), 
(3, 'HOROR')

INSERT INTO [Directors]([Id], [DirectorName])
	VALUES
	(11, 'SpiELBERG'),
	(21, 'Pastor'),
	(1, 'SpiELBERG'),
	(2, 'Pastor'),
	(3, 'Becker')

INSERT INTO [Genres]([Id], [GenreName])
	VALUES 
	(12, 'Comedy Film'),
	(21, 'Horor Film'),
	(1, 'Comedy Film'),
	(2, 'Horor Film'),
	(3, 'Survival Film')
INSERT INTO [Movies]([Id], [Title], [DirectorId], [CopyrightYear], [Length], [GenreId], [CategoryId], [Rating])
	VALUES
	(14, 'NEW NEIGHBOURS', 20, 2012, 180, 5, 110, 4),
	(23, 'Prison Break', 25, 2005, 90, 6, 112, 4),
	(1, 'NEW NEIGHBOURS', 20, 2012, 180, 5, 110, 4),
	(2, 'Prison Break', 25, 2015, 90, 6, 112, 4),
	(3, 'Alf', 30, 1980, 60, 7, 115, 4)

SELECT * FROM [Categories]
SELECT * FROM [Directors]
SELECT * FROM [Genres]
SELECT * FROM [Movies]