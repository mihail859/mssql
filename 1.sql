SELECT TOP(100)
	CONCAT_WS(' ', [FirstName], [MiddleName], [LastName]) AS [Име]
	--CONCAT([FirstName], ' ', [LastName]) AS [Име]
	--,[LastName] AS [Фамилия]
	,[Salary] AS [Заплата]
	,d.[Name] AS [Отдел]
	, t.[Name] AS [Град]
FROM [Employees] AS e JOIN [Departments] AS d ON
e.DepartmentID = d.DepartmentID JOIN [Addresses] AS a ON e.[AddressID] = a.AddressID 
JOIN [Towns] AS t ON a.TownID = t.[TownID]

WHERE e.[DepartmentID] <> 1

ORDER BY [Salary] DESC