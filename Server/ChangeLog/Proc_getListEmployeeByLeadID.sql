USE [CRMManager2]
GO
/****** Object:  StoredProcedure [dbo].[Proc_DeleteUser]    Script Date: 3/28/2019 4:41:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetListEmployeeByLeadID]
@LeadID UNIQUEIDENTIFIER
AS

BEGIN
	 SELECT U.UserID,u.UserName,u.FullName,L.LeadID
 FROM dbo.[User] AS U LEFT join dbo.UserLead AS L
  ON L.UserID = U.UserID 
  WHERE L.LeadID = @LeadID
END

   