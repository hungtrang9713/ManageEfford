INSERT INTO dbo.[User]
(
    UserID,
    UserName,
    FullName,
    IsLead,
    Password
)
VALUES
(   NEWID(), -- UserID - uniqueidentifier
    N'dtthao',  -- UserName - nvarchar(50)
    N'Dương Trung Thảo',  -- FullName - nvarchar(100)
    1, -- IsLead - bit
    N'dtthao'   -- Password - nvarchar(50)
),
(	NEWID(),
	N'nvcuong1',
	N'Nguyễn Việt Cường',
	0,
	'nvcuong1'
),
(	NEWID(),
	N'nqmanh',
	N'Ngô Quang Mạnh',
	0,
	'nvcuong1'
),
(   NEWID(), -- UserID - uniqueidentifier
    N'ndnghia1',  -- UserName - nvarchar(50)
    N'Nguyễn Đình Nghĩa',  -- FullName - nvarchar(100)
    1, -- IsLead - bit
    N'ndnghia1'   -- Password - nvarchar(50)
),
(   NEWID(), -- UserID - uniqueidentifier
    N'ptdat',  -- UserName - nvarchar(50)
    N'Phạm Tiến Thành Đạt',  -- FullName - nvarchar(100)
    1, -- IsLead - bit
    N'ptdat'   -- Password - nvarchar(50)
),
(   NEWID(), -- UserID - uniqueidentifier
    N'lcluc',  -- UserName - nvarchar(50)
    N'Lê Chí Lức',  -- FullName - nvarchar(100)
    0, -- IsLead - bit
    N'lcluc'   -- Password - nvarchar(50)
)


GO


INSERT INTO dbo.UserLead
(
    UserID,
    LeadID
)
VALUES
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'dtthao'), 
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'dtthao')  
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ptdat'), 
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ptdat')  
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ndnghia1'), 
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ndnghia1')  
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'nvcuong1'), 
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'dtthao')  
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'nqmanh'),
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'dtthao') 
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'lcluc'), 
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ptdat') 
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'nvcuong1'),
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ndnghia1') 
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'nqmanh'), 
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ndnghia1')  
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'dtthao'), 
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ndnghia1')  
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'lcluc'),
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ndnghia1') 
),
(
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ptdat'),
    (SELECT UserID FROM dbo.[User] WHERE UserName = 'ndnghia1')  
);
