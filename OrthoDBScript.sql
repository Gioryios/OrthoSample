USE [OrthoSample]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/28/2020 6:17:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[Address2] [nvarchar](100) NULL,
	[City] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Zip] [nchar](15) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Phone] [varchar](150) NOT NULL,
	[DateCreated] [date] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/28/2020 6:17:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderAmount] [money] NOT NULL,
	[Product] [nvarchar](150) NOT NULL,
	[ProductPrice] [money] NOT NULL,
	[OrderStatus] [nvarchar](50) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[DateCreated] [date] NOT NULL,
 CONSTRAINT [PK_Orders_1] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Address], [Address2], [City], [State], [Zip], [Country], [Email], [Phone], [DateCreated]) VALUES (1, N'George', N'Kaparis', N'12345 Mystreet', N'Suite 101', N'Chicago', N'IL', N'60067          ', N'USA', N'gakaparis@gmail.com', N'123-456-7891', CAST(N'2020-12-28' AS Date))
GO
INSERT [dbo].[Customers] ([CustomerID], [FirstName], [LastName], [Address], [Address2], [City], [State], [Zip], [Country], [Email], [Phone], [DateCreated]) VALUES (2, N'Ritesh', N'Lalwani', N'12345 New RD', NULL, N'Woodstock', N'IL', N'60098          ', N'USA', N'R.lalwani@ompimail.com', N'815-701-9556', CAST(N'2020-12-28' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderId], [CustomerId], [Quantity], [OrderAmount], [Product], [ProductPrice], [OrderStatus], [OrderDate], [DateCreated]) VALUES (1, 1, 3, 60.0000, N'Dietary Supplement 10oz ', 20.0000, N'Active', CAST(N'2020-12-28' AS Date), CAST(N'2020-12-28' AS Date))
GO
INSERT [dbo].[Orders] ([OrderId], [CustomerId], [Quantity], [OrderAmount], [Product], [ProductPrice], [OrderStatus], [OrderDate], [DateCreated]) VALUES (2, 1, 1, 20.0000, N'Dietary Supplement 10oz', 20.0000, N'Canceled', CAST(N'2020-12-28' AS Date), CAST(N'2020-12-28' AS Date))
GO
INSERT [dbo].[Orders] ([OrderId], [CustomerId], [Quantity], [OrderAmount], [Product], [ProductPrice], [OrderStatus], [OrderDate], [DateCreated]) VALUES (3, 2, 4, 80.0000, N'Dietary Supplement 10oz', 20.0000, N'Active', CAST(N'2020-12-25' AS Date), CAST(N'2020-12-28' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
