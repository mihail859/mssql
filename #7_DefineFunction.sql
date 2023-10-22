CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(100), @word NVARCHAR(100)) 
RETURNS BIT
BEGIN
	DECLARE @ANSWER BIT
	DECLARE @i INT
	DECLARE @letter NVARCHAR(1)

	SET @ANSWER = 1
	SET @i = 1

	WHILE @i <= LEN(@word)
	BEGIN
		SET @letter = SUBSTRING(@word, @i, 1)
		IF CHARINDEX(@letter, @setOfLetters) = 0
		BEGIN
			SET @ANSWER = 0
			BREAK
		END
		SET @i = @i + 1
	END
	RETURN @ANSWER
	
END

--SELECT dbo.ufn_IsWordComprised(N'oistmiahf', N'halves')
--SELECT dbo.ufn_IsWordComprised(N'oistmiahf', N'Sofia') AS IsComprised