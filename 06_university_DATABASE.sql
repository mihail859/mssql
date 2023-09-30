CREATE TABLE [Majors](
	[MajorID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)
CREATE TABLE [Subjects](
	[subjectID] INT PRIMARY KEY IDENTITY,
	[SubjectName] NVARCHAR(50) NOT NULL
)
CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY IDENTITY,
	[StudentNumber] NVARCHAR(100) NOT NULL,
	[StudentName] NVARCHAR(100) NOT NULL,
	[MajorID] INT,
	FOREIGN KEY ([MajorID]) REFERENCES [Majors]([MajorID])
)
CREATE TABLE [Payments](
	[PaymentsID] INT PRIMARY KEY IDENTITY,
	[PaymentDate] DATETIME2 NOT NULL,
	[PaymentAmount] DECIMAL(8, 2) NOT NULL,
	[StudentID] INT NOT NULL,
	FOREIGN KEY ([StudentID]) REFERENCES [Students]([StudentID])
)
CREATE TABLE [Agenda](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID]),
	PRIMARY KEY([StudentID], [SubjectID])
)