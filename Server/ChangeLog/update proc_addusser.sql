USE [CRMManager2]
GO
/****** Object:  StoredProcedure [dbo].[Proc_InsertUser]    Script Date: 3/28/2019 3:53:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Proc_InsertUser]
	@UserID UNIQUEIDENTIFIER,
    @UserName VARCHAR(50),
    @FullName NVARCHAR(150),
	@Password NVARCHAR(50),
    @IsLead BIGINT,
	@LeadID UNIQUEIDENTIFIER
AS

BEGIN
	DECLARE @PmID UNIQUEIDENTIFIER = 'CF577878-5B80-41C4-9901-B71B8B53C649';
	DECLARE @NewTaskID UNIQUEIDENTIFIER = NEWID();
    INSERT INTO dbo.[User]
    (
        UserID,
        UserName,
        FullName,
        IsLead,
		[Password]
    )
    VALUES
    (   @UserID,
		@UserName,
		@FullName,
		@IsLead,
		@Password
    )
	INSERT INTO dbo.UserLead
		(
			UserID,
			LeadID
		)
		VALUES
		(   @UserID, -- UserID - uniqueidentifier
			@LeadID  -- LeadID - uniqueidentifier
		 )
	IF @LeadID <> @PmID 
	BEGIN
		INSERT INTO dbo.UserLead
		(
			UserID,
			LeadID
		)
		VALUES
		(   @UserID, -- UserID - uniqueidentifier
			@PmID  -- LeadID - uniqueidentifier
		 )
	END
	BEGIN
	EXEC dbo.Proc_InsertTask @TaskID = @NewTaskID,                        -- uniqueidentifier
	                         @PBI = '',                             -- varchar(6)
	                         @TaskName = N'Ngày tạo user',                       -- nvarchar(100)
	                         @EffortScore = 0,                   -- decimal(5, 3)
	                         @MinusScore = 0,                    -- decimal(5, 3)
	                         @FinalScore = 0,                    -- decimal(5, 3)
	                         @Note = N'',                           -- nvarchar(255)
	                         @CreatedDate = '2019-03-28 09:29:51',  -- datetime
	                         @ModifiedDate = '2019-03-28 09:29:51', -- datetime
	                         @UserID = @UserID,                        -- uniqueidentifier
	                         @Week = 0,                             -- tinyint
	                         @DateWorking = '2019-03-28 09:29:51'   -- datetime
	
	END
    
END
