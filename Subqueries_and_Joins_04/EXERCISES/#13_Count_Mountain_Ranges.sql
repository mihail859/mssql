SELECT 
	c.CountryCode
	,COUNT(mc.MountainId) AS [MountainRanges]
FROM Countries AS c
	JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	JOIN Mountains AS m ON m.Id = mc.MountainId
GROUP BY  c.CountryCode
HAVING c.CountryCode IN ('BG', 'RU', 'US');

SELECT TOP(10) * FROM MountainsCountries;
SELECT TOP(10) * FROM Mountains;
SELECT TOP(10) * FROM Peaks;