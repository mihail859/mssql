/*SELECT 
[DepartmentID], COUNT(*) AS [Employees] 
FROM [Employees]
GROUP BY [DepartmentID]
HAVING COUNT(*) > 8
ORDER BY [Employees] DESC
*/
/*
SELECT  
		ROW_NUMBER() OVER (ORDER BY [Salary] DESC) AS [Id],
		[FirstName],
		[LastName],
		DENSE_RANK() OVER (ORDER BY [Salary] DESC) AS [DenseRank],
		RANK() OVER (ORDER BY [Salary] DESC) AS [Rank],
		NTILE(4) OVER(ORDER BY [Salary] DESC) AS [Quintile]
FROM 
[Employees] WHERE [DepartmentID] = 5
*/
-- ADDITIONAL EXERCISE
/*
SELECT 
	[DepartmentId],
	[Salary],
	COUNT(*)	
FROM [Employees]
GROUP BY DepartmentID, Salary
ORDER BY [DepartmentID], [Salary] DESC
*/
