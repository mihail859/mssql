CREATE OR ALTER FUNCTION ufn_CashInUsersGames
(
	@gameName NVARCHAR(50)
)
RETURNS TABLE 
AS
RETURN(
	SELECT
		SUM(dt.Cash) AS SumCash
		FROM 
		(SELECT
			g.[Name],
			ug.Cash,
			ROW_NUMBER() OVER (ORDER BY ug.Cash DESC) AS RN
		FROM UsersGames AS ug
		JOIN Games AS g ON ug.GameId = g.Id
		WHERE g.[Name] = @gameName) AS dt
		WHERE dt.RN % 2 <> 0)

--SELECT  * FROM dbo.ufn_CashInUsersGames(N'Love in a mist')