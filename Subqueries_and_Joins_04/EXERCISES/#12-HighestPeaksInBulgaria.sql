--•	CountryCode, MountainRange, PeakName, Elevation; 
--Filter all the peaks in Bulgaria, which have elevation over 2835
SELECT
	c.CountryCode
	,m.MountainRange
	,p.PeakName
	,p.Elevation
FROM Countries AS c
	JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	JOIN Mountains AS m ON mc.MountainId = m.Id
	JOIN Peaks AS p ON p.MountainId = m.Id
WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC