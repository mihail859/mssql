CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount
(	
	@id INT, @rate FLOAT
)
AS
BEGIN
	DECLARE @years SMALLINT
	SET @years = 5
	SELECT 
		a.Id,
		ah.FirstName,
		ah.LastName,
		a.Balance AS [Current Balance],
		dbo.ufn_CalculateFutureValue(a.Balance, @rate, @years) AS [Balance in 5 years]
	FROM AccountHolders AS ah
	LEFT JOIN Accounts AS a
	ON ah.Id = a.AccountHolderId
	WHERE a.Id = @id


END

EXEC usp_CalculateFutureValueForAccount 1, 0.1