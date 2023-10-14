SELECT TOP(10)
	FirstName,
	LastName,
	DepartmentID
FROM Employees AS ex
WHERE Salary > (
	SELECT AVG(Salary) AS AverageSalary
	FROM Employees AS ein
	WHERE ein.DepartmentID = ex.DepartmentID
	GROUP BY DepartmentID
)
ORDER BY DepartmentID
