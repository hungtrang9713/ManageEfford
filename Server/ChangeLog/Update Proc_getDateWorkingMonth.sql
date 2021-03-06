USE [CRMManager]
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetDateWorkingMonth]    Script Date: 3/22/2019 9:08:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Proc_GetDateWorkingMonth]
	@Month INT,
	@Year INT,
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @FromDate DATE = CAST(@Year AS VARCHAR(4)) + '/' + CAST(@Month AS VARCHAR(2)) + '/' + '01';
	DECLARE @ToDate DATE = DATEADD(DAY, -1, DATEADD(MONTH, 1, @FromDate));

	SELECT	DISTINCT T.DateWorking
	FROM	dbo.Task AS T
	WHERE	(T.DateWorking BETWEEN @FromDate AND @ToDate) AND t.UserID = @UserID
END
