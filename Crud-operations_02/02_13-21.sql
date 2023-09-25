CREATE VIEW [V_EmployeeNameJobTitle]
AS
SELECT
	[FirstName] + ' ' + ISNULL([MIddleName], '') + ' ' + [LastName] AS [Full Name],
	[JobTitle]
	FROM [Employees]