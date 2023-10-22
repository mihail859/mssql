CREATE OR ALTER PROCEDURE usp_GetHoldersFullName
AS
	SELECT
		CONCAT_WS(' ', FirstName, LastName) AS [Full Name]
	FROM AccountHolders
EXEC usp_GetHoldersFullName