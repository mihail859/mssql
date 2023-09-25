SELECT TOP(100)
	CONCAT_WS(' ', [FirstName], [MiddleName], [LastName]) AS [���]
	--CONCAT([FirstName], ' ', [LastName]) AS [���]
	--,[LastName] AS [�������]
	,[Salary] AS [�������]
	,d.[Name] AS [�����]
	, t.[Name] AS [����]
FROM [Employees] AS e JOIN [Departments] AS d ON
e.DepartmentID = d.DepartmentID JOIN [Addresses] AS a ON e.[AddressID] = a.AddressID 
JOIN [Towns] AS t ON a.TownID = t.[TownID]

WHERE e.[DepartmentID] <> 1

ORDER BY [Salary] DESC