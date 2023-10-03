SELECT TOP(5)
	c.CountryName
	,r.RiverName
FROM Countries AS c
	LEFT JOIN Continents AS cnt ON c.ContinentCode = cnt.ContinentCode
	LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
WHERE cnt.ContinentName = 'Africa'
ORDER BY c.CountryName ASC