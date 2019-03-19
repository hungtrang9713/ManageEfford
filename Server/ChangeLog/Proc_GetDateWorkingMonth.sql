CREATE PROCEDURE Proc_GetDateWorkingMonth
	@Month INT,
	@Year INT
AS
BEGIN
    DECLARE @FromDate DATE = CAST(@Year AS VARCHAR(4)) + '/' + CAST(@Month AS VARCHAR(2)) + '/' + '01';
	DECLARE @ToDate DATE = DATEADD(DAY, -1, DATEADD(MONTH, 1, @FromDate));

	SELECT	DISTINCT T.DateWorking
	FROM	dbo.Task AS T
	WHERE	T.DateWorking BETWEEN @FromDate AND @ToDate
END
GO

