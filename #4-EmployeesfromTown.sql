CREATE OR ALTER PROCEDURE usp_GetEmployeesFromTown(
	@townName NVARCHAR(100)
) AS 
BEGIN
	SELECT 
		FirstName,
		LastName
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON t.TownID = a.TownID
	WHERE t.[Name] LIKE '%' + @townName + '%'
END

EXEC usp_GetEmployeesFromTown Sofia
	