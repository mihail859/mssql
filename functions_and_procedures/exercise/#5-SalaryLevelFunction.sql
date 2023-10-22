CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18, 4))
RETURNS VARCHAR(20)
AS
	BEGIN
	DECLARE @message NVARCHAR(20)
		IF @salary  > 50000
			SET @message = 'High'
		ELSE IF @salary BETWEEN 30000 AND 50000
			SET @message = 'Average'
			
		ELSE
			SET @message ='Low'
		
		RETURN @message
	END

--	SELECT dbo.ufn_GetSalaryLevel(50001)