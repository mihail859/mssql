CREATE TABLE [Teachers](
	[TeacherID] INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[ManagerID] INT REFERENCES [Teachers](TeacherID)
)

INSERT INTO [Teachers]([Name], [ManagerID])
VALUES
('John', NULL),
('Maya', 106), 
('Silvia', 106), 
('Ted', 105), 
('Mark', 101), 
('Greta', 101)

SELECT 
t.[Name], t1.[Name]
FROM [Teachers] AS t JOIN [Teachers] AS t1
ON t.TeacherID = t1.ManagerID