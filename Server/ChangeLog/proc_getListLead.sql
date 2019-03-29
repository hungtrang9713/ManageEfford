USE [CRMManager2]
GO
/****** Object:  StoredProcedure [dbo].[Proc_DeleteUser]    Script Date: 3/28/2019 4:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Proc_GetListLead]
AS

BEGIN
	 SELECT UserID, FullName FROM dbo.[User] WHERE IsLead =1
END
