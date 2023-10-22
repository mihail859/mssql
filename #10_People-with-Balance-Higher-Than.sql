CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan(
	@balance MONEY
) AS
BEGIN
	SELECT 
		dt.FirstName,
		dt.LastName
	
	FROM 
		(SELECT 
		ah.FirstName,
		ah.LastName
		,SUM(Balance) AS SumBalance

		FROM AccountHolders AS ah
		LEFT JOIN Accounts AS a
		ON ah.Id = a.AccountHolderId
		GROUP BY  FIRSTNAME, LastName , AccountHolderId
		HAVING SUM(Balance) > @balance) AS dt
	ORDER BY dt.FirstName, dt.LastName

	
END

EXEC usp_GetHoldersWithBalanceHigherThan 10000