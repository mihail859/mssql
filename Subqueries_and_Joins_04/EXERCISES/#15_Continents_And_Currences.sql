--•	ContinentCode, CurrencyCode, CurrencyUsage
SELECT 
	ContinentCode, 
	CurrencyCode,
	CurrencyUsage
FROM 
	(SELECT 
		*,
		DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY CurrencyUsage DESC) AS 
		[CurrencyRank]
	FROM
		(SELECT 
			c.ContinentCode
			,c.CurrencyCode
			,COUNT(c.CurrencyCode) AS CurrencyUsage
			FROM Countries AS c
			GROUP BY c.ContinentCode, c.CurrencyCode) AS SubQuery
	WHERE CurrencyUsage > 1) AS SecondSubQuery
WHERE CurrencyRank = 1
ORDER BY ContinentCode ASC