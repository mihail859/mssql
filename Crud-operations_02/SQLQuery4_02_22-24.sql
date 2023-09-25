SELECT [PeakName] FROM [Peaks]
ORDER BY [PeakName] ASC;

--23
SELECT TOP(30) 
[CountryName], 
[Population] 
FROM [Countries]
WHERE [ContinentCode] = 'EU'
ORDER BY [Population] DESC, [CountryName] ASC

--24
SELECT [CountryName], 
		[CountryCode],
		CASE [CurrencyCode] WHEN 'EUR' THEN 'Euro'
		ELSE 'Not Euro' END AS [Currency]
		FROM [Countries]
		ORDER BY [CountryName] ASC


