SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [dbo].[Proc_SummaryTask_Week]
	@Month INT,
	@Year INT,
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @StartDate DATETIME = CAST(@Year AS VARCHAR(4)) + '/' + CAST(@Month AS VARCHAR(2)) + '/' + '1';
	DECLARE @EndDate DATETIME = DATEADD(DAY, -1, DATEADD(MONTH, 1, @StartDate));

    SELECT	T.[Week],
			SUM(T.EffortScore) AS EffortScore,
			SUM(T.MinusScore) AS MinusScore,
			SUM(T.FinalScore) AS FinalScore,
			@UserID AS UserID
	INTO	#temp
	FROM	dbo.Task AS T
	JOIN	dbo.[User] AS U ON U.UserID = T.UserID
	WHERE	T.UserID = @UserID
			AND T.DateWorking BETWEEN @StartDate AND @EndDate
	GROUP BY T.[Week]

	SELECT	T.Week,
            T.EffortScore,
            T.MinusScore,
            T.FinalScore,
            T.UserID,
			U.UserID,
            U.UserName,
            U.FullName,
            U.IsLead
	FROM	#temp AS T
	JOIN	dbo.[User] AS U ON U.UserID = T.UserID
END



GO

