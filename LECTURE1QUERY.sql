
CREATE DATABASE [Minions2023]


USE [Minions2023]


CREATE TABLE [Minions] (
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] INT NOT NULL
)

CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY,
	[NAME] NVARCHAR(70) NOT NULL,
)

ALTER TABLE [Minions]
ADD [TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL

ALTER TABLE [Minions]
ALTER COLUMN [Age] INT

GO

INSERT INTO [Towns]([Id], [NAME])
	VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO [Minions] ([Id], [Name], [Age], [TownId])
	VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

SELECT * FROM [Towns]
SELECT * FROM [Minions]

TRUNCATE TABLE [Minions]

DROP TABLE [Towns]


CREATE TABLE [People](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR (200) NOT NULL,
	[Picture] VARBINARY(MAX),
	CHECK (DATALENGTH([Picture]) <= 2000000),
	[Height] DECIMAL(3, 2),
	[Weight] DECIMAL(5, 2),
	[Gender] CHAR(1) NOT NULL,
	CHECK ([Gender] = 'm' OR [Gender] = 'f'),
	[Birthdate] DATE NOT NULL,
	[Biography] NVARCHAR(MAX)

)

INSERT INTO [People]([Name], [Height], [Weight], [Gender], [Birthdate])
VALUES
('PESHO', 1.77, 75.2, 'm', '1998-05-04'),
('IVAN', 1.54, 54.21 ,'m', '1998-05-04'),
('VIKI', NULL, NULL, 'f', '1998-05-04'),
('MARIO', NULL, NULL, 'm', '1998-05-04'),
('VANCHO', NULL, NULL, 'm', '1998-05-04')

CREATE TABLE [Users](
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) NOT NULL, 
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY(MAX),
	CHECK (DATALENGTH([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT NOT NULL

)
INSERT INTO [Users]([Username], [Password], [IsDeleted])
	VALUES
	('õäõäõäõõêô', 'õäñõôõêê', 1),
	('Kñäêêãêî', 'äñòããèàúà', 1),
	('ôãùêôùêôôÿ', 'õñêõôêôêñôñÿ', 0),
	('õõõñÿàî', 'íäçäñõñõõÿ', 0),
	('äçñäññå', 'ïäõñäõõ', 0)
SELECT * FROM [Users]
--9
ALTER TABLE [Users] DROP CONSTRAINT PK__Users__3214EC07E4DCA995
ALTER TABLE [Users] ADD CONSTRAINT PK_IdUsername PRIMARY KEY ([Id], [Username])

SELECT * FROM [Users]

-- 10 Using SQL queries modify table Users. Add check constraint to ensure 
--that the values in the Password field are at least 5 symbols long. 
ALTER TABLE [Users] ADD CONSTRAINT CHK_PasswordMinLen CHECK(LEN([Password]) >= 5)

INSERT INTO [Users]([Username], [Password], [IsDeleted])
	VALUES
	('Ìèõàèë Æåëÿçêîâ', 'ÍÄÂ', 1)


SELECT * FROM [Users]
--11 

--11 Using SQL queries modify table Users. Make the default value of LastLoginTime
--field to be the current time.

--ALTER TABLE Persons
--ADD CONSTRAINT df_City
--DEFAULT 'Sandnes' FOR City;

ALTER TABLE [Users] 
ADD CONSTRAINT df_LastLoginTime 
DEFAULT GETDATE() FOR [LastLoginTime]

INSERT INTO [Users]([Username], [Password], [IsDeleted])
	VALUES
	('Ïåòêàí', 'ÓÅÈÕÑÀ', 1)
SELECT * FROM [Users]

--12
--Using SQL queries modify table Users. Remove Username field 
--from the primary key so only the field Id would be primary key.
--Now add unique constraint to the Username
--field to ensure that the values there are at least 3 symbols long.
ALTER TABLE [Users]
ADD CONSTRAINT UC_Username UNIQUE([Username])

ALTER TABLE [Users]
ADD CONSTRAINT CHK_UsernameLEN CHECK(LEN([Username]) >= 3)

--15
CREATE DATABASE Hotel
USE Hotel

--Employees (Id, FirstName, LastName, Title, Notes
CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY, 
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Title] NVARCHAR(50),
	[Notes] NVARCHAR(MAX)
)
--•	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
CREATE TABLE [Customers](
	[AccountNumber] INT PRIMARY KEY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[PhoneNumber] VARCHAR(15) NOT NULL,
	[EmergencyName] NVARCHAR(20) NOT NULL,
	[EmergencyNumber] VARCHAR(10) NOT NULL,
	[Notes] NVARCHAR(MAX)
)
--•	RoomStatus (RoomStatus, Notes)
CREATE TABLE [RoomStatus](
	[RoomStatus] INT PRIMARY KEY,
	[Notes] NVARCHAR(MAX)
)

--•	RoomTypes (RoomType, Notes
CREATE TABLE [RoomTypes](
	[RoomType] INT PRIMARY KEY,
	[Notes] NVARCHAR(MAX)
)
--•	BedTypes (BedType, Notes
CREATE TABLE [BedTypes](
	[BedType] INT PRIMARY KEY,
	[Notes] NVARCHAR(MAX)

)

--•	Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
CREATE TABLE [Rooms](
	[RoomNumber] INT PRIMARY KEY,
	[RoomType] NVARCHAR(30) NOT NULL,
	[BedType] NVARCHAR(30) NOT NULL,
	[Rate] TINYINT NOT NULL,
	[RoomStatus] NVARCHAR(30) NOT NULL,
	[Notes] NVARCHAR(MAX) 
)
--•	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, 
--TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
CREATE TABLE [Payments](
	[Id] INT PRIMARY KEY,
	[EmployeeId] INT NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[AccountNumber] VARCHAR(15) NOT NULL,
	[FirstDateOccupied] DATE NOT NULL,
	[LastDateOccupied] DATE NOT NULL,
	[TotalDays] INT NOT NULL,
	[AmountCharged] SMALLMONEY NOT NULL,
	[TaxRate] TINYINT NOT NULL,
	[TaxAmount] SMALLMONEY NOT NULL,
	[PaymentTotal] MONEY NOT NULL,
	[Notes] NVARCHAR(MAX)
)
--•	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
CREATE TABLE [Occupancies](
	[Id] INT PRIMARY KEY,
	[EmployeeId] INT NOT NULL,
	[DateOccupied] DATE NOT NULL,
	[AccountNumber] VARCHAR(10) NOT NULL,
	[RoomNumber] TINYINT NOT NULL,
	[RateApplied] TINYINT NOT NULL,
	[PhoneCharge] SMALLMONEY,
	[Notes] NVARCHAR(MAX)

)

INSERT INTO [BedTypes]([BedType], [Notes])
	VALUES
	(1, 'CLEAN'), 
	(2, 'DIRT'), 
	(3, 'CLEAN')

INSERT INTO [Customers]([AccountNumber], [FirstName], [LastName], 
[PhoneNumber], [EmergencyName], [EmergencyNumber])
VALUES 
(1, 'KIKO', 'Kostov', '0879514677', 'KOK', '685'),
(2, 'Petko', 'Petkov', '041526798', 'KOL', '741'),
(3, 'Gogo', 'Popov', '0123456', 'LOP', '789')

INSERT INTO [Employees]([Id], [FirstName], [LastName])
VALUES
(10, 'MICHAIL', 'WestON'),
(15, 'John', 'Abrusti'),
(20, 'Paolena', 'Ruseva')

INSERT INTO [Occupancies]([Id], [EmployeeId], [DateOccupied], [AccountNumber], [RoomNumber], [RateApplied])
VALUES
(1, 125, '2001-05-06', 'W78595', 145, 7),
(2, 126, '2001-05-07', 'Q74855', 146, 10),
(3, 127, '2001-05-08', 'A41526', 147, 8)

INSERT INTO [Payments]([Id], [EmployeeId], [PaymentDate], [AccountNumber], [FirstDateOccupied], [LastDateOccupied],
[TotalDays], [AmountCharged], [TaxRate], [TaxAmount], [PaymentTotal])
VALUES
(1, 245, '2001-05-06', 'W78595', '2001-05-04', '2001-05-08', 4, 80.25, 5, 12.21, 92.46),
(2, 246, '2001-05-06', 'E78595', '2001-05-04', '2001-05-09', 5, 90.26, 5, 13.22, 103.48),
(3, 247, '2001-05-06', 'W78I95', '2001-05-05', '2001-05-10', 5, 145.21, 5, 30.56, 175.77)

INSERT INTO [Rooms]([RoomNumber], [RoomType], [BedType], [Rate], [RoomStatus])
VALUES
(321, 'DOUBLE', '2 SINGLE BEDS', 10, 'BUSY'), 
(323, 'TRIPLE', 'BEDROOM', 9, 'FREE'),
(325, 'SINGLE', 'SINGLE BED', 5, 'BUSY')

INSERT INTO [RoomStatus]([RoomStatus])
VALUES
(2),
(5), 
(6)
INSERT INTO [RoomTypes]([RoomType])
VALUES 
(50),
(64),
(98)

SELECT * FROM [RoomTypes]