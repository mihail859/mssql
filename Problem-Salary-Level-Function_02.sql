SELECT 
--	FirstName,
--	LastName,
--	Salary,
	dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel
	,COUNT(*)
FROM Employees
GROUP BY dbo.udf_GetSalaryLevel(Salary)