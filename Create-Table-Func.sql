CREATE OR ALTER FUNCTION udf_AverageSalaryByDepartment(@MinSalary MONEY = 20000)
RETURNS TABLE AS
RETURN
(
	SELECT d.[Name] AS Department, AVG(e.Salary) AS AverageSalary
	FROM Departments AS d
	JOIN Employees AS e ON d.DepartmentID = e.DepartmentID
	GROUP BY d.DepartmentID, d.[Name]
	HAVING AVG(Salary) > @MinSalary
)