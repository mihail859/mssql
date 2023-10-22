CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith(
	@string NVARCHAR(50)
) AS
BEGIN
	SELECT	
		[Name]
	FROM Towns
	WHERE [Name] LIKE  @string + '%'
END

EXEC usp_GetTownsStartingWith B