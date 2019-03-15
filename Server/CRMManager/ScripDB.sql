USE [CRMManager]
GO
/****** Object:  Table [dbo].[JobBooking]    Script Date: 3/14/2019 4:43:48 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 3/14/2019 4:43:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[FullName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLead]    Script Date: 3/14/2019 4:43:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLead](
	[UserID] [uniqueidentifier] NOT NULL,
	[LeadID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Working]    Script Date: 3/14/2019 4:43:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Working](
	[WorkingID] [uniqueidentifier] NOT NULL,
	[PBIID] [varchar](6) NULL,
	[PBIName] [nvarchar](255) NULL,
	[ProductivityScore] [float] NULL,
	[PenaltyScore] [float] NULL,
	[PlusScore] [float] NULL,
	[Note] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Working] PRIMARY KEY CLUSTERED 
(
	[WorkingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Working] ADD  CONSTRAINT [DF_Working_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Working] ADD  CONSTRAINT [DF_Working_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
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
ALTER TABLE [dbo].[Working]  WITH CHECK ADD  CONSTRAINT [FK_Working_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Working] CHECK CONSTRAINT [FK_Working_User]
GO
/****** Object:  StoredProcedure [dbo].[Proc_InsertJobBooking]    Script Date: 3/14/2019 4:43:49 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_InsertWorking]    Script Date: 3/14/2019 4:43:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_InsertWorking]
    @WorkingID UNIQUEIDENTIFIER,
    @PBIID VARCHAR(10),
    @PBIName NVARCHAR(100),
    @ProductivityScore FLOAT,
    @PenaltyScore FLOAT,
    @PlusScore FLOAT,
    @Note NVARCHAR(255),
    @CreatedDate DATETIME,
    @ModifiedDate DATETIME,
    @UserID UNIQUEIDENTIFIER
AS
BEGIN
    INSERT INTO dbo.Working
    (
        WorkingID,
        PBIID,
        PBIName,
        ProductivityScore,
        PenaltyScore,
        PlusScore,
        Note,
        CreatedDate,
        ModifiedDate,
        UserID
    )
    VALUES
    (   @WorkingID,
		@PBIID,
		@PBIName,
		@ProductivityScore,
		@PenaltyScore,
		@PlusScore,
		@Note,
		@CreatedDate,
		@ModifiedDate,
		@UserID
    );
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên PBI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'PBIName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Điểm năng suất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'ProductivityScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Điểm phạt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'PenaltyScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Điểm cộng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'PlusScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ghi chú' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'Note'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày tạo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'CreatedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày sửa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã nhân viên' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Working', @level2type=N'COLUMN',@level2name=N'UserID'
GO
