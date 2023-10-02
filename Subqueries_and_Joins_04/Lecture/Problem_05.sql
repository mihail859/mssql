--MinAverageSalary
SELECT MIN(dt.avgSALARY) AS [MinAverageSalary]
FROM
(SELECT
	AVG(Salary) AS avgSALARY
FROM Employees AS e
GROUP BY e.DepartmentID) AS dt