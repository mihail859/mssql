CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
SELECT
	FirstName,
	LastName
FROM Employees
WHERE Salary > 30000

EXEC usp_GetEmployeesSalaryAbove35000