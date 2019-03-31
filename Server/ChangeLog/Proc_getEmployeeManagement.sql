
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_GetListEmployeeManagement]
	-- Add the parameters for the stored procedure here

AS
BEGIN
SELECT UserID,
       UserName,
       FullName,
       IsLead,
       Password FROM dbo.[User] WHERE IsLead=1	

SELECT U.UserID,
       U.UserName,
       U.FullName,
       U.IsLead,
       U.Password,  L.LeadID
 FROM dbo.[User] AS U LEFT join dbo.UserLead AS L
  ON L.UserID = U.UserID 

END
GO
