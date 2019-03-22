USE [CRMManager2]
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetJobBookingMonth]    Script Date: 3/23/2019 4:24:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetJobBookingMonth]
	@Month INT,
	@Year INT,
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @FromDate DATE = CAST(@Year AS VARCHAR(4)) + '/' + CAST(@Month AS VARCHAR(2)) + '/' + '01';
	DECLARE @ToDate DATE = DATEADD(DAY, -1, DATEADD(MONTH, 1, @FromDate));

	SELECT DISTINCT   T.WorkingState,
                     T.UserID,
                     T.Date
	FROM	dbo.JobBooking AS T
	WHERE	(T.Date BETWEEN @FromDate AND @ToDate) AND t.UserID = @UserID
END
