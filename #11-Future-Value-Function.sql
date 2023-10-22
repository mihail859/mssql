

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue 
(@sum DECIMAL(18, 4), @yearlyInterestRate FLOAT, @years INT) 
RETURNS DECIMAL(18, 4) AS
BEGIN
	DECLARE @result FLOAT
	SET @result = @sum * POWER((1+@yearlyInterestRate), @years)
	RETURN @result
END

--SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
