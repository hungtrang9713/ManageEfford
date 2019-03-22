SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER procedure [dbo].[Proc_SummaryTask_Month]
	@Month INT,
	@Year INT
AS
BEGIN
	DECLARE @StartDate DATETIME = CAST(@Year AS VARCHAR(4)) + '/' + CAST(@Month AS VARCHAR(2)) + '/' + '1';
	DECLARE @EndDate DATETIME = DATEADD(DAY, -1, DATEADD(MONTH, 1, @StartDate));

	SELECT 
		SUM(T.FinalScore) AS FinalScore,
		T.Week,
		T.UserID
	INTO #temp
	FROM dbo.Task AS T
	JOIN dbo.[User] AS U ON U.UserID = T.UserID
	WHERE T.DateWorking BETWEEN @StartDate AND @EndDate
	GROUP BY T.UserID, T.[Week]

	SELECT 
		U.FullName,
		U.UserName,
		U.UserID,
		P.[1] AS Week1,
		P.[2] AS Week2,
		P.[3] AS Week3,
		P.[4] AS Week4,
		(ISNULL(P.[1], 0) + ISNULL(P.[2], 0) + ISNULL(P.[3], 0) + ISNULL(P.[4], 0)) AS Total
	FROM #temp AS T PIVOT (SUM(FinalScore) FOR [Week] IN ([1],[2],[3],[4])) AS P
	JOIN dbo.[User] AS U ON U.UserID = P.UserID
END


GO

