USE [CRMManager2]
GO
/****** Object:  StoredProcedure [dbo].[Proc_UpdateUser]    Script Date: 3/31/2019 9:02:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Proc_UpdateUser]
	@UserID UNIQUEIDENTIFIER,
    @UserName VARCHAR(50),
    @FullName NVARCHAR(150),
	@Password NVARCHAR(50),
    @IsLead BIGINT,
	@LeadID UNIQUEIDENTIFIER
AS

BEGIN
	DECLARE @PmID UNIQUEIDENTIFIER = 'CF577878-5B80-41C4-9901-B71B8B53C649';
		Update dbo.UserLead	
		SET
		LeadID=@LeadID 
		WHERE UserID=@UserID AND LeadID <> @PmID
END
BEGIN
    UPDATE dbo.[User] 
		SET   
        UserName=@UserName,
        FullName=@FullName,
        IsLead=@IsLead,
		[Password]=@Password
		WHERE UserID =@UserID
END
	--EXEC dbo.Proc_UpdateUser @UserID = 'aeafed18-54d7-4ab0-9626-23f57b0df96a',  -- uniqueidentifier
	--                         @UserName = 'lcluc',  -- varchar(50)
	--                         @FullName = N'Lê Chí Lực', -- nvarchar(150)
	--                         @Password = N'lcluc', -- nvarchar(50)
	--                         @IsLead = 0,     -- bigint
	--                         @LeadID = '939e205f-df2b-4ff1-a64a-2126fe900a3f'   -- uniqueidentifier
	