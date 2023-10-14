WITH CTE_SalaryRanking AS(
    SELECT DepartmentID, Salary,
           DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT DISTINCT DepartmentID, Salary AS ThirdHighestSalary
FROM CTE_SalaryRanking
WHERE SalaryRank = 3;
 

