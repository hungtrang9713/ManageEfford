USE [CRMManager2]
GO
/****** Object:  StoredProcedure [dbo].[Proc_DeleteUser]    Script Date: 3/28/2019 4:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Proc_DeleteUser]
	@UserID UNIQUEIDENTIFIER
AS

BEGIN
		  DELETE FROM dbo.UserLead WHERE UserID = @UserID
		  DELETE FROM dbo.[User] WHERE UserID = @UserID
    
END
