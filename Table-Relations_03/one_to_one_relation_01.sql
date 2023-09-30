CREATE TABLE [Passports](
	[PassportID] INT PRIMARY KEY IDENTITY(101, 1), 
	[PassportNumber] NVARCHAR(20)
)

CREATE TABLE [Persons](
	[PersonID] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(30),
	[Salary] DECIMAL(8, 2),
	[PassportID] INT UNIQUE FOREIGN KEY REFERENCES [Passports](PassportID)
)

INSERT INTO [Passports]([PassportNumber])
VALUES
('N34FG21B'), 
('K65LO4R7'),
('ZE657QP2')
SET IDENTITY_INSERT [Persons] ON
INSERT INTO [Persons]([PersonID], [FirstName], [Salary], [PassportID])
VALUES
(1, 'Roberto', 43300.00, 102),
(2,	'Tom', 56100.00, 103),
(3,	'Yana',	60200.00, 101)

SELECT p.[FirstName], pass.PassportNumber FROM [Persons] AS p JOIN [Passports] AS pass
ON p.PassportID = pass.PassportID