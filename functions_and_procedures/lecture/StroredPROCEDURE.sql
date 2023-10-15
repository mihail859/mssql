CREATE OR ALTER PROC usp_MultipleResults
(@DepartmentId INT = 4)
AS 
SELECT * FROM Employees AS e 
WHERE e.DepartmentID = @DepartmentId
SELECT * FROM Departments AS d 
WHERE d.DepartmentID = @DepartmentId

GO
EXEC usp_MultipleResults 6