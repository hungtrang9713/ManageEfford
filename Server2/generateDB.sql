USE [master]
GO
/****** Object:  Database [CRMManager2]    Script Date: 3/31/2019 10:33:41 PM ******/
CREATE DATABASE [CRMManager2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CRMManager2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CRMManager2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CRMManager2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CRMManager2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CRMManager2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CRMManager2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CRMManager2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CRMManager2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CRMManager2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CRMManager2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CRMManager2] SET ARITHABORT OFF 
GO
ALTER DATABASE [CRMManager2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CRMManager2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CRMManager2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CRMManager2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CRMManager2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CRMManager2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CRMManager2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CRMManager2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CRMManager2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CRMManager2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CRMManager2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CRMManager2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CRMManager2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CRMManager2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CRMManager2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CRMManager2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CRMManager2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CRMManager2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CRMManager2] SET  MULTI_USER 
GO
ALTER DATABASE [CRMManager2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CRMManager2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CRMManager2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CRMManager2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CRMManager2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CRMManager2] SET QUERY_STORE = OFF
GO
USE [CRMManager2]
GO
/****** Object:  Table [dbo].[JobBooking]    Script Date: 3/31/2019 10:33:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobBooking](
	[JobBookingID] [uniqueidentifier] NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NULL,
	[WorkingState] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  Table [dbo].[UserLead]    Script Date: 3/31/2019 10:33:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLead](
	[UserID] [uniqueidentifier] NOT NULL,
	[LeadID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'333377a6-5be8-41d7-bb03-ea0a9ada945d', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-03-23T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'29bde072-8b73-458e-9b32-2099e4c3b301', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-03-29T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'b4bf6f93-34c3-4ef6-b021-a90776962918', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-03-30T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'60a473f0-b277-4bb2-b498-06489d444e7b', N'cf577878-5b80-41c4-9901-b71b8b53c649', CAST(N'2019-03-28T00:00:00.000' AS DateTime), 4, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'60c3c8e3-fd94-41c5-af9e-dd6f91355c64', N'cf577878-5b80-41c4-9901-b71b8b53c649', CAST(N'2019-04-08T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'cb63f317-d67f-4299-af32-4dae0f599550', N'cf577878-5b80-41c4-9901-b71b8b53c649', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'6aa2abe3-c8fc-4d47-b434-2e7a094cffb0', N'cf577878-5b80-41c4-9901-b71b8b53c649', CAST(N'2019-04-11T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'57980722-5189-4aec-b122-242cff0fb4e2', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-04-08T00:00:00.000' AS DateTime), 2, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'0cd74df4-c691-4e4b-83f7-e8bc815b1a18', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-04-10T00:00:00.000' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'a1349a09-d8bc-460a-adb0-fc4db5d801f9', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-03-25T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'd1454887-6078-4185-bdd4-c56769041a10', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-03-21T00:00:00.000' AS DateTime), 2, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'c2a37d56-a05a-4909-9b09-d375355d67bc', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-03-28T00:00:00.000' AS DateTime), 4, NULL, NULL)
INSERT [dbo].[JobBooking] ([JobBookingID], [UserID], [Date], [WorkingState], [CreatedDate], [ModifiedDate]) VALUES (N'ad8967c5-9b2a-4bde-a332-998aa09f239f', N'2b20daef-bc04-49e6-888f-485fc256538d', CAST(N'2019-04-11T00:00:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'baf47fc8-fc11-42f4-9b4a-02f88eca3510', N'', N' ', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-24T00:00:00.000' AS DateTime), CAST(N'2019-03-24T00:00:00.000' AS DateTime), N'e441d984-657c-4c8e-81ef-e4e079b94ead', 4, CAST(N'2019-03-24' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'78e4099c-c076-42f3-b55c-511708040723', N'', N'mới', CAST(3.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(3.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 3, CAST(N'2019-03-22' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'24e1ef4f-afc4-426b-83f3-5734332d884b', N'', N'Ngày tạo user', NULL, NULL, NULL, N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), N'0927441d-293e-4e2d-ac8b-781bfc5ed73e', 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'3a32ba5e-c50b-44b8-8118-65fd89f4d15a', N'', N'thế nào nhỉ', CAST(3.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(3.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-27T00:00:00.000' AS DateTime), CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 3, CAST(N'2019-03-21' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'0cc1daee-5f09-414b-a644-67d2b858499f', N'', N'siêu phầm', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 4, CAST(N'2019-03-26' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'6a79101d-e582-4c54-8cd4-713160598668', N'', N'Ngày tạo user', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), N'8048789f-43c9-490b-8139-264c42058a2d', 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'afe0ccf1-ac9c-4b76-bb47-748ad9cafa93', N'', N'Ngày tạo user', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), N'a51f2095-85b3-4fd3-b2f2-0c7b011e3bea', 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'b7dc75e3-e9b7-4cc9-a7ba-769f7d192da5', N'', N'thêm mới', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-27T00:00:00.000' AS DateTime), CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 3, CAST(N'2019-03-20' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'c405f15f-2eb4-4f4b-9e5e-77a3e18e6d6f', N'', N'Ngày tạo user', NULL, NULL, NULL, N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), N'cf577878-5b80-41c4-9901-b71b8333c444', 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'50e67b50-bdb3-4204-bd30-77bf51774dd3', N'', N'test', CAST(1.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(1.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 3, CAST(N'2019-03-20' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'8370642f-6b70-472a-8f47-80a05c4e0a2f', N'', N'test bug', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-24T00:00:00.000' AS DateTime), CAST(N'2019-03-24T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 4, CAST(N'2019-03-25' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'b50155b1-433e-4a36-9fce-86035927093e', N'', N' ', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), NULL, CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'aeafed18-54d7-4ab0-9626-23f57b0df96a', 2, CAST(N'2019-03-23' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'80f57507-c0c4-4e22-af00-8a414727b8e2', N'1234', N'Danh sách liên hệ', CAST(10.000 AS Decimal(5, 3)), CAST(0.500 AS Decimal(5, 3)), CAST(9.500 AS Decimal(5, 3)), NULL, CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'939e205f-df2b-4ff1-a64a-2126fe900a3f', 2, CAST(N'2019-03-23' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'44dde243-19aa-482e-866d-8bfc78f0ff67', N'1234', N'Danh sách liên hệ', CAST(7.000 AS Decimal(5, 3)), CAST(1.000 AS Decimal(5, 3)), CAST(6.000 AS Decimal(5, 3)), NULL, CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'939e205f-df2b-4ff1-a64a-2126fe900a3f', 2, CAST(N'2019-03-23' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'fe6ac62b-b19e-440c-a48e-914e2cdf5bdf', N'', N'thuyết trình', CAST(7.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(7.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 4, CAST(N'2019-03-24' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'abaf6ae1-e3e1-4b06-99ee-9fa9ccc15275', N'', N'Ngày tạo user', NULL, NULL, NULL, N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), N'7612c5e6-80be-4d8e-98c6-3d0596380a43', 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'627fb85a-b0aa-4dab-8446-a8a90912565b', N'', N'Ngày tạo user', NULL, NULL, NULL, N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), NULL, 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'f5ddf58a-f899-4607-916c-ad7634ad970a', N'', N'cv tháng 3', CAST(9.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(9.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-24T00:00:00.000' AS DateTime), CAST(N'2019-03-24T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 3, CAST(N'2019-02-20' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'3443c43c-eb54-4195-b019-b314d16a29e0', N'', N'cv này đang bug', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-24T00:00:00.000' AS DateTime), CAST(N'2019-03-24T00:00:00.000' AS DateTime), N'e441d984-657c-4c8e-81ef-e4e079b94ead', 4, CAST(N'2019-03-25' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'3f82de8a-de73-403e-a7ab-b45c001872e4', N'', N'Ngày tạo user', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), N'd7f0bd00-3a60-499d-a796-a229354e408f', 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'87150265-bfdf-45bf-a22e-b8ac1695605b', N'  ', N' ', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-24T00:00:00.000' AS DateTime), CAST(N'2019-03-24T00:00:00.000' AS DateTime), N'882db6bd-07d0-4538-93c2-4e645eff9f9d', 4, CAST(N'2019-03-24' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'0a2a64c5-62b8-42eb-bb3a-b96dfb0db643', N'', N'chuẩn bị demo', CAST(4.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(4.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-31T00:00:00.000' AS DateTime), CAST(N'2019-03-31T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 0, CAST(N'2019-04-01' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'4d983ac6-0fe0-419e-be16-bc64b8595fa0', N'1234', N'Danh sách liên hệ', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), NULL, CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'aeafed18-54d7-4ab0-9626-23f57b0df96a', 2, CAST(N'2019-03-23' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'382dff6d-4ef1-48c8-a1bc-bf9d89c4ea09', N'', N'Ngày tạo user', CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-28T09:29:51.000' AS DateTime), CAST(N'2019-03-28T09:29:51.000' AS DateTime), N'03135cfd-a374-4e86-aff7-caab3b9c6547', 0, CAST(N'2019-03-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'359fea93-7c34-4bb5-98d3-c1d644cf776a', N'', N'anh nghĩa thêm', CAST(10.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(10.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-27T00:00:00.000' AS DateTime), CAST(N'2019-03-27T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 4, CAST(N'2019-02-28' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'5a218efc-5fc2-453d-bf3b-d4d3be6dfeea', N'1234', N'Danh sách liên hệ', CAST(5.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(5.000 AS Decimal(5, 3)), NULL, CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 2, CAST(N'2019-03-23' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'3633ba5d-3ecd-44d9-b69d-e32cc35e088d', N'1234', N'olala', CAST(7.000 AS Decimal(5, 3)), CAST(1.000 AS Decimal(5, 3)), CAST(6.000 AS Decimal(5, 3)), NULL, CAST(N'2019-03-23T00:00:00.000' AS DateTime), CAST(N'2019-03-23T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 2, CAST(N'2019-03-23' AS Date))
INSERT [dbo].[Task] ([TaskID], [PBI], [TaskName], [EffortScore], [MinusScore], [FinalScore], [Note], [CreatedDate], [ModifiedDate], [UserID], [Week], [DateWorking]) VALUES (N'7b7e0b37-a8f1-477e-89c0-f5577472846e', N'', N'tháng 3', CAST(5.000 AS Decimal(5, 3)), CAST(0.000 AS Decimal(5, 3)), CAST(5.000 AS Decimal(5, 3)), N'', CAST(N'2019-03-24T00:00:00.000' AS DateTime), CAST(N'2019-03-24T00:00:00.000' AS DateTime), N'2b20daef-bc04-49e6-888f-485fc256538d', 3, CAST(N'2019-03-18' AS Date))
INSERT [dbo].[User] ([UserID], [UserName], [FullName], [IsLead], [Password]) VALUES (N'939e205f-df2b-4ff1-a64a-2126fe900a3f', N'ptdat', N'Phạm Tiến Thành Đạt', 1, N'ptdat')
INSERT [dbo].[User] ([UserID], [UserName], [FullName], [IsLead], [Password]) VALUES (N'aeafed18-54d7-4ab0-9626-23f57b0df96a', N'lcluc', N'Lê Bất Lực', 0, N'123456')
INSERT [dbo].[User] ([UserID], [UserName], [FullName], [IsLead], [Password]) VALUES (N'2b20daef-bc04-49e6-888f-485fc256538d', N'nvcuong1', N'Nguyễn Việt Cường', 0, N'123456')
INSERT [dbo].[User] ([UserID], [UserName], [FullName], [IsLead], [Password]) VALUES (N'882db6bd-07d0-4538-93c2-4e645eff9f9d', N'dtthao', N'Dương Trung Thảo', 1, N'dtthao')
INSERT [dbo].[User] ([UserID], [UserName], [FullName], [IsLead], [Password]) VALUES (N'cf577878-5b80-41c4-9901-b71b8b53c649', N'ndnghia1', N'Nguyễn Đình Nghĩa', 1, N'ndnghia1')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'882db6bd-07d0-4538-93c2-4e645eff9f9d', N'882db6bd-07d0-4538-93c2-4e645eff9f9d')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'939e205f-df2b-4ff1-a64a-2126fe900a3f', N'939e205f-df2b-4ff1-a64a-2126fe900a3f')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'cf577878-5b80-41c4-9901-b71b8b53c649', N'cf577878-5b80-41c4-9901-b71b8b53c649')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'2b20daef-bc04-49e6-888f-485fc256538d', N'882db6bd-07d0-4538-93c2-4e645eff9f9d')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'aeafed18-54d7-4ab0-9626-23f57b0df96a', N'939e205f-df2b-4ff1-a64a-2126fe900a3f')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'2b20daef-bc04-49e6-888f-485fc256538d', N'cf577878-5b80-41c4-9901-b71b8b53c649')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'882db6bd-07d0-4538-93c2-4e645eff9f9d', N'cf577878-5b80-41c4-9901-b71b8b53c649')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'aeafed18-54d7-4ab0-9626-23f57b0df96a', N'cf577878-5b80-41c4-9901-b71b8b53c649')
INSERT [dbo].[UserLead] ([UserID], [LeadID]) VALUES (N'939e205f-df2b-4ff1-a64a-2126fe900a3f', N'cf577878-5b80-41c4-9901-b71b8b53c649')
ALTER TABLE [dbo].[JobBooking] ADD  CONSTRAINT [DF_JobBooking_JobBookingID]  DEFAULT (newid()) FOR [JobBookingID]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Working_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Working_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
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
/****** Object:  StoredProcedure [dbo].[Proc_DeleteTask]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_DeleteUser]    Script Date: 3/31/2019 10:33:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_DeleteUser]
	@UserID UNIQUEIDENTIFIER
AS

BEGIN
		  DELETE FROM dbo.UserLead WHERE UserID = @UserID
		  DELETE FROM dbo.[User] WHERE UserID = @UserID
    
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetDateWorkingMonth]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_GetJobBookingMonth]    Script Date: 3/31/2019 10:33:42 PM ******/
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
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetListEmployeeManagement]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_GetListLead]    Script Date: 3/31/2019 10:33:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetListLead]
AS

BEGIN
	 SELECT UserID, FullName FROM dbo.[User] WHERE IsLead =1
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_GetTask_Day]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_GetUser_ByID]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_InsertJobBooking]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_InsertTask]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_InsertUser]    Script Date: 3/31/2019 10:33:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_InsertUser]
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
GO
/****** Object:  StoredProcedure [dbo].[Proc_Login]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_SummaryTask_Month]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_SummaryTask_Week]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_UpdateTask]    Script Date: 3/31/2019 10:33:42 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_UpdateUser]    Script Date: 3/31/2019 10:33:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_UpdateUser]
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
	
GO
/****** Object:  StoredProcedure [dbo].[Proc_ValidateToken]    Script Date: 3/31/2019 10:33:42 PM ******/
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
USE [master]
GO
ALTER DATABASE [CRMManager2] SET  READ_WRITE 
GO
