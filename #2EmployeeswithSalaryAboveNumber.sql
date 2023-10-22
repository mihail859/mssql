CREATE OR ALTER PROC usp_GetEmployeesSalaryAboveNumber
@salaryLevel DECIMAL(18, 4)
AS
	SELECT
		FirstName,
		LastName
	FROM Employees
	WHERE Salary >= @salaryLevel;

EXEC usp_GetEmployeesSalaryAboveNumber 50000
