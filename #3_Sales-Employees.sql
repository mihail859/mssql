--•	EmployeeID, FirstName, LastName, DepartmentName
--Sort them by EmployeeID in ascending order. 
--Select only employees from the "Sales" department.
SELECT
	e.EmployeeID,
	e.FirstName
	,e.LastName
	,d.[Name] AS [DepartmentName]
FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID

WHERE d.[Name] = 'Sales'
ORDER BY e.EmployeeID ASC