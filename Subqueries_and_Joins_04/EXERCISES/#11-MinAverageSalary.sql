SELECT
MIN(AvgSalary.s) AS [MinAverageSalary]
FROM
(SELECT
AVG(e.Salary) AS s
FROM Employees AS e
GROUP BY e.DepartmentID) AS AvgSalary;