CREATE DATABASE CRMManager2
GO

USE [CRMManager2]
GO
/****** Object:  Table [dbo].[JobBooking]    Script Date: 3/22/2019 9:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBooking](
	[JobBookingID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NULL,
	[WokingState] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 3/22/2019 9:46:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[TaskID] [uniqueidentifier] NOT NULL,
	[PBI] [varchar](6) NULL,
	[TaskName] [nvarchar](255) NULL,
	[EffortScore] [decimal](5, 3) NULL,
	[MinusScore] [decimal](5, 3) NULL,
	[FinalScore] [decimal](5, 3) NULL,
	[Note] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserID] [uniqueidentifier] NULL,
	[Week] [tinyint] NULL,
	[DateWorking] [date] NULL,
 CONSTRAINT [PK_Working] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[FullName] [nvarchar](100) NULL,
	[IsLead] [bit] NULL,
	[Password] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLead]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLead](
	[UserID] [uniqueidentifier] NOT NULL,
	[LeadID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Working_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Working_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[JobBooking]  WITH CHECK ADD  CONSTRAINT [FK_JobBooking_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[JobBooking] CHECK CONSTRAINT [FK_JobBooking_User]
GO
ALTER TABLE [dbo].[UserLead]  WITH CHECK ADD  CONSTRAINT [FK_UserLead_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserLead] CHECK CONSTRAINT [FK_UserLead_User]
GO
ALTER TABLE [dbo].[UserLead]  WITH CHECK ADD  CONSTRAINT [FK_UserLead_User1] FOREIGN KEY([LeadID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserLead] CHECK CONSTRAINT [FK_UserLead_User1]
GO
/****** Object:  StoredProcedure [dbo].[Proc_DeleteTask]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_DeleteTask]
	@TaskID UNIQUEIDENTIFIER
AS
BEGIN
    DELETE dbo.Task WHERE TaskID = @TaskID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetDateWorkingMonth]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetDateWorkingMonth]
	@Month INT,
	@Year INT,
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @FromDate DATE = CAST(@Year AS VARCHAR(4)) + '/' + CAST(@Month AS VARCHAR(2)) + '/' + '01';
	DECLARE @ToDate DATE = DATEADD(DAY, -1, DATEADD(MONTH, 1, @FromDate));

	SELECT	DISTINCT T.DateWorking
	FROM	dbo.Task AS T
	WHERE	T.DateWorking BETWEEN @FromDate AND @ToDate
			AND T.UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetTask_Day]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetTask_Day]
	@DateWorking Date,
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
   SELECT	T.TaskID,
			T.PBI,
			T.TaskName,
			T.EffortScore,
			T.MinusScore,
			T.FinalScore,
			T.Note,
			T.CreatedDate,
			T.ModifiedDate,
			T.UserID,
			T.Week,
			T.DateWorking 
   FROM		dbo.Task AS T 
   WHERE	T.UserID = @UserID 
			AND T.DateWorking = @DateWorking
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetUser_ByID]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetUser_ByID]
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
    SELECT  CASE WHEN U.UserID IS NOT NULL
				 THEN 1
				 ELSE 0 
			END AS Valid
	FROM	dbo.[User] AS U 
	WHERE	U.UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_InsertJobBooking]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_InsertJobBooking]
    @JobBookingID UNIQUEIDENTIFIER,
    @UserID UNIQUEIDENTIFIER,
    @Date DATETIME,
    @WokingState INT
AS
BEGIN
    INSERT INTO dbo.JobBooking
    (
        JobBookingID,
        UserID,
        [Date],
        WokingState
    )
    VALUES
    (
		@JobBookingID,
		@UserID,
		@Date,
		@WokingState
	);
END;
GO
/****** Object:  StoredProcedure [dbo].[Proc_InsertTask]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_InsertTask]
    @TaskID UNIQUEIDENTIFIER,
    @PBI VARCHAR(6),
    @TaskName NVARCHAR(100),
    @EffortScore DECIMAL(5,3),
    @MinusScore DECIMAL(5,3),
    @FinalScore DECIMAL(5,3),
    @Note NVARCHAR(255),
    @CreatedDate DATETIME,
    @ModifiedDate DATETIME,
    @UserID UNIQUEIDENTIFIER,
	@Week TINYINT,
	@DateWorking DATETIME
AS
BEGIN
    INSERT INTO	dbo.Task
    (
        TaskID,
        PBI,
        TaskName,
        EffortScore,
        MinusScore,
        FinalScore,
        Note,
        CreatedDate,
        ModifiedDate,
        UserID,
        Week,
        DateWorking
    )
    VALUES
    (   ISNULL(@TaskID, NEWID()),      -- TaskID - uniqueidentifier
        @PBI,        -- PBI - varchar(6)
        @TaskName,       -- TaskName - nvarchar(255)
        @EffortScore,      -- EffortScore - decimal(5, 3)
        @MinusScore,      -- MinusScore - decimal(5, 3)
        @FinalScore,      -- FinalScore - decimal(5, 3)
        @Note,       -- Note - nvarchar(255)
        ISNULL(@CreatedDate, GETDATE()), -- CreatedDate - datetime
        ISNULL(@ModifiedDate, GETDATE()), -- ModifiedDate - datetime
        @UserID,      -- UserID - uniqueidentifier
        @Week,         -- Week - tinyint
        ISNULL(@DateWorking, GETDATE())  -- DateWorking - datetime
        )
END;
GO
/****** Object:  StoredProcedure [dbo].[Proc_InsertUser]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_InsertUser]
	@UserID UNIQUEIDENTIFIER,
    @UserName VARCHAR(50),
    @FullName NVARCHAR(150),
	@Password NVARCHAR(50),
    @IsLead BIGINT
AS
BEGIN
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
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Login]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Login]
	@UserName NVARCHAR(50),
	@Password NVARCHAR(50)
AS
BEGIN
    SELECT * FROM dbo.[User] AS U
	WHERE U.UserName = @UserName AND U.[Password] = @Password
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_SummaryTask_Month]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Proc_SummaryTask_Month]
	@Month INT,
	@Year INT,
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @StartDate DATETIME = CAST(@Year AS VARCHAR(4)) + '/' + CAST(@Month AS VARCHAR(2)) + '/' + '1';
	DECLARE @EndDate DATETIME = DATEADD(DAY, -1, DATEADD(MONTH, 1, @StartDate));

	SELECT	UL.UserID
	INTO	#tempLead
	FROM	dbo.UserLead AS UL
	WHERE	UL.LeadID = @UserID

	SELECT 
		SUM(T.FinalScore) AS FinalScore,
		T.Week,
		T.UserID
	INTO #temp
	FROM dbo.Task AS T
	JOIN #tempLead AS TL ON TL.UserID = T.UserID
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
/****** Object:  StoredProcedure [dbo].[Proc_SummaryTask_Week]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_SummaryTask_Week]
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
/****** Object:  StoredProcedure [dbo].[Proc_UpdateTask]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_UpdateTask]
    @TaskID UNIQUEIDENTIFIER,
    @PBI VARCHAR(6),
    @TaskName NVARCHAR(100),
    @EffortScore DECIMAL(5,3),
    @MinusScore DECIMAL(5,3),
    @FinalScore DECIMAL(5,3),
    @Note NVARCHAR(255),
    @CreatedDate DATETIME,
    @ModifiedDate DATETIME,
    @UserID UNIQUEIDENTIFIER,
	@Week TINYINT,
	@DateWorking DATETIME
AS
BEGIN

	UPDATE	dbo.Task 
	SET	[PBI] = @PBI,
		[TaskName] = @TaskName,
		[EffortScore] = @EffortScore,
		[MinusScore] = @MinusScore,
		[FinalScore] = @FinalScore,
		[Note] = @Note,
		[ModifiedDate] = @ModifiedDate
	WHERE TaskID = @TaskID
END;

GO
/****** Object:  StoredProcedure [dbo].[Proc_ValidateToken]    Script Date: 3/22/2019 9:46:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_ValidateToken]
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
    SELECT  CASE WHEN U.UserID IS NOT NULL
				 THEN CAST(1 AS BIT)
				 ELSE CAST(0 AS BIT) 
			END AS Valid
	FROM	dbo.[User] AS U 
	WHERE	U.UserID = @UserID
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên công việc' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'TaskName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Điểm năng suất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'EffortScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Điểm phạt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'MinusScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Điểm cộng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'FinalScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ghi chú' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'Note'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày sửa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã nhân viên' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tuần' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'Week'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày chấm công' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'DateWorking'
GO
