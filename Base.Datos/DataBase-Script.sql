USE [sportsplay]
GO
/****** Object:  Table [dbo].[reservation]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reservation](
	[id_reservation] [int] IDENTITY(1,1) NOT NULL,
	[id_pitch] [int] NOT NULL,
	[id_place] [int] NOT NULL,
	[id_users] [int] NULL,
	[id_users_offline] [int] NULL,
	[id_scheduler] [int] NOT NULL,
	[hour] [time](7) NOT NULL,
	[date] [datetime] NOT NULL,
	[status] [int] NOT NULL,
	[date_insert] [datetime] NOT NULL,
	[id_users_type] [int] NULL,
	[value] [decimal](18, 0) NULL,
	[description] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[reservation_report]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[reservation_report] as

select [id_place], [year],[month],[status], count(1) as cantidad, sum([value]) ingresos
from 
(SELECT id_place,year([date]) [year], month([date]) [month],[status], [value] 
FROM [dbo].[reservation]
where 
 id_reservation in (select id_reservation
                       from (select id_scheduler, [date],[hour],id_users_offline, max(id_reservation) id_reservation
                             from [dbo].[reservation]
                             group by id_scheduler, [date],[hour],id_users_offline) as reservationsAux)) as auxt
group by [id_place],[year], [month], [status]
--order by [id_place],[year],[month], [status] asc
GO
/****** Object:  Table [dbo].[cities]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cities](
	[id_city] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[id_country] [int] NOT NULL,
 CONSTRAINT [PK_cities] PRIMARY KEY CLUSTERED 
(
	[id_city] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[countries]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[countries](
	[id_country] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_countries] PRIMARY KEY CLUSTERED 
(
	[id_country] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[id_customer] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](50) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[id_place] [int] NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[id_customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[days]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[days](
	[id_day] [int] IDENTITY(1,1) NOT NULL,
	[number] [int] NOT NULL,
	[name] [nchar](30) NOT NULL,
 CONSTRAINT [PK_days] PRIMARY KEY CLUSTERED 
(
	[id_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[holidays]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[holidays](
	[id_holiday] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
 CONSTRAINT [PK_holidays] PRIMARY KEY CLUSTERED 
(
	[id_holiday] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[multi_pitch]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[multi_pitch](
	[id_multi_pitch] [int] IDENTITY(1,1) NOT NULL,
	[id_pitch_multiple] [int] NULL,
	[id_pitch_single] [int] NULL,
	[id_place] [int] NULL,
	[description] [nvarchar](50) NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_multi_pitch] PRIMARY KEY CLUSTERED 
(
	[id_multi_pitch] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[opening]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[opening](
	[id_opening] [int] IDENTITY(1,1) NOT NULL,
	[id_day] [int] NOT NULL,
	[hour_start] [time](7) NOT NULL,
	[hour_end] [time](7) NOT NULL,
	[id_place] [int] NOT NULL,
 CONSTRAINT [PK_opening] PRIMARY KEY CLUSTERED 
(
	[id_opening] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pitch]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pitch](
	[id_pitch] [int] IDENTITY(1,1) NOT NULL,
	[id_place] [int] NULL,
	[description] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[id_pitch_type] [int] NULL,
	[id_sport_type] [int] NULL,
 CONSTRAINT [PK_pitch] PRIMARY KEY CLUSTERED 
(
	[id_pitch] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pitch_type]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pitch_type](
	[id_pitch_type] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_pitch_type] PRIMARY KEY CLUSTERED 
(
	[id_pitch_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[place]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[place](
	[id_place] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[address] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[latitude] [varchar](20) NULL,
	[longitude] [varchar](20) NULL,
	[max_days_reservation] [int] NULL,
	[autoconfirm] [bit] NULL,
	[format_hour] [nchar](2) NULL,
	[max_time_cancelation] [int] NULL,
	[end_date_test] [datetime] NULL,
	[profile_img] [varchar](50) NULL,
	[id_city] [int] NULL,
 CONSTRAINT [PK_place] PRIMARY KEY CLUSTERED 
(
	[id_place] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reservation_multipitch]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reservation_multipitch](
	[id_reservation_multipitch] [int] IDENTITY(1,1) NOT NULL,
	[id_pitch_multiple] [int] NULL,
	[id_pitch_single] [int] NULL,
	[id_place] [int] NULL,
	[id_reservation] [int] NULL,
	[hour] [time](7) NULL,
	[date] [datetime] NULL,
	[status] [int] NULL,
	[type_pitch_insert] [varchar](1) NULL,
 CONSTRAINT [PK_reservation_multipitch] PRIMARY KEY CLUSTERED 
(
	[id_reservation_multipitch] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[scheduler]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[scheduler](
	[id_schedule] [int] IDENTITY(1,1) NOT NULL,
	[hour] [time](7) NOT NULL,
	[value] [decimal](18, 0) NOT NULL,
	[id_day] [int] NOT NULL,
	[id_pitch] [int] NOT NULL,
	[id_pitch_type] [int] NOT NULL,
	[date_insert] [datetime] NOT NULL,
 CONSTRAINT [PK_scheduler] PRIMARY KEY CLUSTERED 
(
	[id_schedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sports_type]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sports_type](
	[id_sport_type] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [varchar](350) NULL,
 CONSTRAINT [PK_sports_type] PRIMARY KEY CLUSTERED 
(
	[id_sport_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status_type]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status_type](
	[id_status] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
 CONSTRAINT [PK_status_type] PRIMARY KEY CLUSTERED 
(
	[id_status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id_users] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[id_usersocialred] [varchar](50) NULL,
	[id_users_type] [int] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id_users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users_offline]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_offline](
	[id_users_offline] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](100) NOT NULL,
	[phone] [nchar](50) NOT NULL,
	[email] [nchar](50) NULL,
	[id_place] [int] NOT NULL,
 CONSTRAINT [PK_users_offline] PRIMARY KEY CLUSTERED 
(
	[id_users_offline] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users_type]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_type](
	[id_users_type] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](50) NULL,
 CONSTRAINT [PK_users_type] PRIMARY KEY CLUSTERED 
(
	[id_users_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cities] ON 
GO
INSERT [dbo].[cities] ([id_city], [name], [id_country]) VALUES (1, N'Cali', 1)
GO
SET IDENTITY_INSERT [dbo].[cities] OFF
GO
SET IDENTITY_INSERT [dbo].[countries] ON 
GO
INSERT [dbo].[countries] ([id_country], [name]) VALUES (1, N'Colombia')
GO
SET IDENTITY_INSERT [dbo].[countries] OFF
GO
SET IDENTITY_INSERT [dbo].[customer] ON 
GO
INSERT [dbo].[customer] ([id_customer], [full_name], [phone], [email], [password], [id_place]) VALUES (9, N'Admin Contoso', N'6666666', N'admin@contoso.com', N'E5C2C9138C6A69C8CEF29D6BB265D667A7DDE818', 3)
GO
SET IDENTITY_INSERT [dbo].[customer] OFF
GO
SET IDENTITY_INSERT [dbo].[days] ON 
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (1, 1, N'Lunes                         ')
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (2, 2, N'Martes                        ')
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (3, 3, N'Miercoles                     ')
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (4, 4, N'Jueves                        ')
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (5, 5, N'Viernes                       ')
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (6, 6, N'Sabado                        ')
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (7, 7, N'Domingo                       ')
GO
INSERT [dbo].[days] ([id_day], [number], [name]) VALUES (8, 8, N'Festivo                       ')
GO
SET IDENTITY_INSERT [dbo].[days] OFF
GO
SET IDENTITY_INSERT [dbo].[multi_pitch] ON 
GO
INSERT [dbo].[multi_pitch] ([id_multi_pitch], [id_pitch_multiple], [id_pitch_single], [id_place], [description], [status]) VALUES (10, 22, 19, 3, N'', 1)
GO
INSERT [dbo].[multi_pitch] ([id_multi_pitch], [id_pitch_multiple], [id_pitch_single], [id_place], [description], [status]) VALUES (11, 22, 20, 3, N'', 1)
GO
SET IDENTITY_INSERT [dbo].[multi_pitch] OFF
GO
SET IDENTITY_INSERT [dbo].[opening] ON 
GO
INSERT [dbo].[opening] ([id_opening], [id_day], [hour_start], [hour_end], [id_place]) VALUES (15, 1, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), 3)
GO
INSERT [dbo].[opening] ([id_opening], [id_day], [hour_start], [hour_end], [id_place]) VALUES (16, 2, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), 3)
GO
INSERT [dbo].[opening] ([id_opening], [id_day], [hour_start], [hour_end], [id_place]) VALUES (17, 3, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), 3)
GO
INSERT [dbo].[opening] ([id_opening], [id_day], [hour_start], [hour_end], [id_place]) VALUES (18, 4, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), 3)
GO
INSERT [dbo].[opening] ([id_opening], [id_day], [hour_start], [hour_end], [id_place]) VALUES (19, 5, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), 3)
GO
INSERT [dbo].[opening] ([id_opening], [id_day], [hour_start], [hour_end], [id_place]) VALUES (20, 6, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), 3)
GO
INSERT [dbo].[opening] ([id_opening], [id_day], [hour_start], [hour_end], [id_place]) VALUES (21, 7, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), 3)
GO
SET IDENTITY_INSERT [dbo].[opening] OFF
GO
SET IDENTITY_INSERT [dbo].[pitch] ON 
GO
INSERT [dbo].[pitch] ([id_pitch], [id_place], [description], [status], [id_pitch_type], [id_sport_type]) VALUES (19, 3, N'Cancha 1', 1, 1, NULL)
GO
INSERT [dbo].[pitch] ([id_pitch], [id_place], [description], [status], [id_pitch_type], [id_sport_type]) VALUES (20, 3, N'Cancha 2', 1, 1, NULL)
GO
INSERT [dbo].[pitch] ([id_pitch], [id_place], [description], [status], [id_pitch_type], [id_sport_type]) VALUES (21, 3, N'Cancha 3', 1, 1, NULL)
GO
INSERT [dbo].[pitch] ([id_pitch], [id_place], [description], [status], [id_pitch_type], [id_sport_type]) VALUES (22, 3, N'Cancha 4 Multiple', 1, 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[pitch] OFF
GO
SET IDENTITY_INSERT [dbo].[pitch_type] ON 
GO
INSERT [dbo].[pitch_type] ([id_pitch_type], [name]) VALUES (1, N'Normal')
GO
INSERT [dbo].[pitch_type] ([id_pitch_type], [name]) VALUES (2, N'Multiple')
GO
SET IDENTITY_INSERT [dbo].[pitch_type] OFF
GO
SET IDENTITY_INSERT [dbo].[place] ON 
GO
INSERT [dbo].[place] ([id_place], [name], [phone], [description], [address], [status], [latitude], [longitude], [max_days_reservation], [autoconfirm], [format_hour], [max_time_cancelation], [end_date_test], [profile_img], [id_city]) VALUES (3, N'Contoso Place', N'5555555', N'Drogueria Comfandi;Peluqueria;Gimnasio;Heladeria;Escuela de fútbol;Torneos;Tienda', N'Avenida Suite 73 # 53A-3956, Buenos Aires', 1, N'52.3582747', N'4.7675138', 365, 0, N'00', 360, CAST(N'2031-12-31T23:59:59.000' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[place] OFF
GO
SET IDENTITY_INSERT [dbo].[scheduler] ON 
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1940, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1941, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1942, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1943, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1944, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1945, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1946, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1947, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1948, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1949, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1950, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1951, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1952, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1953, CAST(N'06:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1954, CAST(N'06:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1955, CAST(N'06:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1956, CAST(N'06:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1957, CAST(N'06:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1958, CAST(N'06:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1959, CAST(N'06:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1960, CAST(N'06:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1961, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1962, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1963, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1964, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1965, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1966, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1967, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1968, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1969, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1970, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1971, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1972, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1973, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1974, CAST(N'07:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1975, CAST(N'07:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1976, CAST(N'07:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1977, CAST(N'07:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1978, CAST(N'07:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1979, CAST(N'07:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1980, CAST(N'07:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1981, CAST(N'07:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1982, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1983, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1984, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1985, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1986, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1987, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1988, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1989, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1990, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1991, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1992, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1993, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1994, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1995, CAST(N'08:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1996, CAST(N'08:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1997, CAST(N'08:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1998, CAST(N'08:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (1999, CAST(N'08:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2000, CAST(N'08:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2001, CAST(N'08:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2002, CAST(N'08:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2003, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2004, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2005, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2006, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2007, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2008, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2009, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2010, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2011, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2012, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2013, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2014, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2015, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2016, CAST(N'09:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2017, CAST(N'09:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2018, CAST(N'09:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2019, CAST(N'09:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2020, CAST(N'09:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2021, CAST(N'09:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2022, CAST(N'09:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2023, CAST(N'09:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2024, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2025, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2026, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2027, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2028, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2029, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2030, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2031, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2032, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2033, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2034, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2035, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2036, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2037, CAST(N'10:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2038, CAST(N'10:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2039, CAST(N'10:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2040, CAST(N'10:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2041, CAST(N'10:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2042, CAST(N'10:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2043, CAST(N'10:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2044, CAST(N'10:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2045, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2046, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2047, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2048, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2049, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2050, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2051, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2052, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2053, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2054, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2055, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2056, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2057, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2058, CAST(N'11:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2059, CAST(N'11:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2060, CAST(N'11:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2061, CAST(N'11:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2062, CAST(N'11:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2063, CAST(N'11:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2064, CAST(N'11:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2065, CAST(N'11:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2066, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2067, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2068, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2069, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2070, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2071, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2072, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2073, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2074, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2075, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2076, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2077, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2078, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2079, CAST(N'12:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2080, CAST(N'12:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2081, CAST(N'12:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2082, CAST(N'12:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2083, CAST(N'12:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2084, CAST(N'12:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2085, CAST(N'12:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2086, CAST(N'12:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2087, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2088, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2089, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2090, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2091, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2092, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2093, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2094, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2095, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2096, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2097, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2098, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2099, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2100, CAST(N'13:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2101, CAST(N'13:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2102, CAST(N'13:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2103, CAST(N'13:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2104, CAST(N'13:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2105, CAST(N'13:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2106, CAST(N'13:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2107, CAST(N'13:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2108, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2109, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2110, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2111, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2112, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2113, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2114, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2115, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2116, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2117, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2118, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2119, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2120, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2121, CAST(N'14:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2122, CAST(N'14:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2123, CAST(N'14:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2124, CAST(N'14:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2125, CAST(N'14:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2126, CAST(N'14:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2127, CAST(N'14:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2128, CAST(N'14:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2129, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2130, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2131, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2132, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2133, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2134, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2135, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2136, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2137, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2138, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2139, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2140, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2141, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2142, CAST(N'15:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2143, CAST(N'15:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2144, CAST(N'15:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2145, CAST(N'15:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2146, CAST(N'15:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2147, CAST(N'15:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2148, CAST(N'15:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2149, CAST(N'15:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2150, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2151, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2152, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2153, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2154, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2155, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2156, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2157, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2158, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2159, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2160, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2161, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2162, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2163, CAST(N'16:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2164, CAST(N'16:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2165, CAST(N'16:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2166, CAST(N'16:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2167, CAST(N'16:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2168, CAST(N'16:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2169, CAST(N'16:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2170, CAST(N'16:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2171, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2172, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2173, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2174, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2175, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2176, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2177, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2178, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2179, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2180, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2181, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2182, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2183, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2184, CAST(N'17:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2185, CAST(N'17:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2186, CAST(N'17:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2187, CAST(N'17:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2188, CAST(N'17:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2189, CAST(N'17:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2190, CAST(N'17:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2191, CAST(N'17:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2192, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2193, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2194, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2195, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2196, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2197, CAST(N'18:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2198, CAST(N'18:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2199, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2200, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2201, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2202, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2203, CAST(N'18:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2204, CAST(N'18:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2205, CAST(N'18:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2206, CAST(N'18:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2207, CAST(N'18:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2208, CAST(N'18:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2209, CAST(N'18:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2210, CAST(N'18:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2211, CAST(N'18:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2212, CAST(N'18:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2213, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2214, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2215, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2216, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2217, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2218, CAST(N'19:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2219, CAST(N'19:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2220, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2221, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2222, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2223, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2224, CAST(N'19:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2225, CAST(N'19:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2226, CAST(N'19:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2227, CAST(N'19:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2228, CAST(N'19:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2229, CAST(N'19:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2230, CAST(N'19:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2231, CAST(N'19:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2232, CAST(N'19:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2233, CAST(N'19:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2234, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2235, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2236, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2237, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2238, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2239, CAST(N'20:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2240, CAST(N'20:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2241, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2242, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2243, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2244, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2245, CAST(N'20:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2246, CAST(N'20:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2247, CAST(N'20:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2248, CAST(N'20:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2249, CAST(N'20:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2250, CAST(N'20:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2251, CAST(N'20:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2252, CAST(N'20:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2253, CAST(N'20:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2254, CAST(N'20:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2255, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2256, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2257, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2258, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2259, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2260, CAST(N'21:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2261, CAST(N'21:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2262, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2263, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2264, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2265, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2266, CAST(N'21:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2267, CAST(N'21:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2268, CAST(N'21:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2269, CAST(N'21:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2270, CAST(N'21:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2271, CAST(N'21:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2272, CAST(N'21:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2273, CAST(N'21:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2274, CAST(N'21:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2275, CAST(N'21:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2276, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2277, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2278, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2279, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2280, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2281, CAST(N'22:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2282, CAST(N'22:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 19, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2283, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 1, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2284, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 2, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2285, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 3, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2286, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 4, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2287, CAST(N'22:00:00' AS Time), CAST(80000 AS Decimal(18, 0)), 5, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2288, CAST(N'22:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 6, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2289, CAST(N'22:00:00' AS Time), CAST(60000 AS Decimal(18, 0)), 7, 20, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2290, CAST(N'22:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 1, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2291, CAST(N'22:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 2, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2292, CAST(N'22:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 3, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2293, CAST(N'22:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 4, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2294, CAST(N'22:00:00' AS Time), CAST(90000 AS Decimal(18, 0)), 5, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2295, CAST(N'22:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 6, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (2296, CAST(N'22:00:00' AS Time), CAST(70000 AS Decimal(18, 0)), 7, 21, 1, CAST(N'2016-08-05T12:30:00.000' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3445, CAST(N'18:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 1, 22, 2, CAST(N'2016-08-10T03:56:52.420' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3446, CAST(N'18:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 2, 22, 2, CAST(N'2016-08-10T03:56:54.690' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3447, CAST(N'18:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 3, 22, 2, CAST(N'2016-08-10T03:56:56.827' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3448, CAST(N'18:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 4, 22, 2, CAST(N'2016-08-10T03:56:59.673' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3449, CAST(N'18:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 5, 22, 2, CAST(N'2016-08-10T03:57:02.017' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3450, CAST(N'18:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 6, 22, 2, CAST(N'2016-08-10T03:57:03.880' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3451, CAST(N'18:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 7, 22, 2, CAST(N'2016-08-10T03:57:06.147' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3452, CAST(N'19:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 1, 22, 2, CAST(N'2016-08-10T03:57:08.380' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3453, CAST(N'19:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 2, 22, 2, CAST(N'2016-08-10T03:57:10.433' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3454, CAST(N'19:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 3, 22, 2, CAST(N'2016-08-10T03:57:12.783' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3455, CAST(N'19:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 4, 22, 2, CAST(N'2016-08-10T03:57:14.927' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3456, CAST(N'19:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 5, 22, 2, CAST(N'2016-08-10T03:57:17.083' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3457, CAST(N'19:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 6, 22, 2, CAST(N'2016-08-10T03:57:19.333' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3458, CAST(N'19:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 7, 22, 2, CAST(N'2016-08-10T03:57:21.380' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3459, CAST(N'20:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 1, 22, 2, CAST(N'2016-08-10T03:57:23.650' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3460, CAST(N'20:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 2, 22, 2, CAST(N'2016-08-10T03:57:25.690' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3461, CAST(N'20:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 3, 22, 2, CAST(N'2016-08-10T03:57:27.630' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3462, CAST(N'20:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 4, 22, 2, CAST(N'2016-08-10T03:57:29.833' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3463, CAST(N'20:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 5, 22, 2, CAST(N'2016-08-10T03:57:32.233' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3464, CAST(N'20:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 6, 22, 2, CAST(N'2016-08-10T03:57:34.180' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3465, CAST(N'20:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 7, 22, 2, CAST(N'2016-08-10T03:57:36.043' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3466, CAST(N'21:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 1, 22, 2, CAST(N'2016-08-10T03:57:37.980' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3467, CAST(N'21:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 2, 22, 2, CAST(N'2016-08-10T03:57:40.233' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3468, CAST(N'21:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 3, 22, 2, CAST(N'2016-08-10T03:57:42.410' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3469, CAST(N'21:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 4, 22, 2, CAST(N'2016-08-10T03:57:44.630' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3470, CAST(N'21:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 5, 22, 2, CAST(N'2016-08-10T03:57:46.910' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3471, CAST(N'21:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 6, 22, 2, CAST(N'2016-08-10T03:57:48.930' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3472, CAST(N'21:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 7, 22, 2, CAST(N'2016-08-10T03:57:50.887' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3473, CAST(N'22:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 1, 22, 2, CAST(N'2016-08-10T03:57:52.937' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3474, CAST(N'22:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 2, 22, 2, CAST(N'2016-08-10T03:57:55.180' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3475, CAST(N'22:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 3, 22, 2, CAST(N'2016-08-10T03:57:57.560' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3476, CAST(N'22:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 4, 22, 2, CAST(N'2016-08-10T03:57:59.787' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3477, CAST(N'22:00:00' AS Time), CAST(150000 AS Decimal(18, 0)), 5, 22, 2, CAST(N'2016-08-10T03:58:01.753' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3478, CAST(N'22:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 6, 22, 2, CAST(N'2016-08-10T03:58:04.190' AS DateTime))
GO
INSERT [dbo].[scheduler] ([id_schedule], [hour], [value], [id_day], [id_pitch], [id_pitch_type], [date_insert]) VALUES (3479, CAST(N'22:00:00' AS Time), CAST(110000 AS Decimal(18, 0)), 7, 22, 2, CAST(N'2016-08-10T03:58:06.217' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[scheduler] OFF
GO
SET IDENTITY_INSERT [dbo].[status_type] ON 
GO
INSERT [dbo].[status_type] ([id_status], [name]) VALUES (1, N'Pendiente por confirmar       ')
GO
INSERT [dbo].[status_type] ([id_status], [name]) VALUES (2, N'Confirmada                    ')
GO
INSERT [dbo].[status_type] ([id_status], [name]) VALUES (3, N'Cancelado por el usuario      ')
GO
INSERT [dbo].[status_type] ([id_status], [name]) VALUES (4, N'Cancelado por la cancha       ')
GO
INSERT [dbo].[status_type] ([id_status], [name]) VALUES (5, N'Entregada                     ')
GO
INSERT [dbo].[status_type] ([id_status], [name]) VALUES (6, N'Finalizada                    ')
GO
SET IDENTITY_INSERT [dbo].[status_type] OFF
GO
SET IDENTITY_INSERT [dbo].[users_type] ON 
GO
INSERT [dbo].[users_type] ([id_users_type], [name]) VALUES (1, N'Admin                                             ')
GO
INSERT [dbo].[users_type] ([id_users_type], [name]) VALUES (2, N'App                                               ')
GO
INSERT [dbo].[users_type] ([id_users_type], [name]) VALUES (3, N'User                                              ')
GO
SET IDENTITY_INSERT [dbo].[users_type] OFF
GO
ALTER TABLE [dbo].[cities]  WITH CHECK ADD  CONSTRAINT [FK_cities_countries] FOREIGN KEY([id_country])
REFERENCES [dbo].[countries] ([id_country])
GO
ALTER TABLE [dbo].[cities] CHECK CONSTRAINT [FK_cities_countries]
GO
ALTER TABLE [dbo].[multi_pitch]  WITH CHECK ADD  CONSTRAINT [FK_multi_pitch_place] FOREIGN KEY([id_place])
REFERENCES [dbo].[place] ([id_place])
GO
ALTER TABLE [dbo].[multi_pitch] CHECK CONSTRAINT [FK_multi_pitch_place]
GO
ALTER TABLE [dbo].[opening]  WITH CHECK ADD  CONSTRAINT [FK_opening_place] FOREIGN KEY([id_place])
REFERENCES [dbo].[place] ([id_place])
GO
ALTER TABLE [dbo].[opening] CHECK CONSTRAINT [FK_opening_place]
GO
ALTER TABLE [dbo].[pitch]  WITH CHECK ADD  CONSTRAINT [FK_pitch_pitch_type] FOREIGN KEY([id_pitch_type])
REFERENCES [dbo].[pitch_type] ([id_pitch_type])
GO
ALTER TABLE [dbo].[pitch] CHECK CONSTRAINT [FK_pitch_pitch_type]
GO
ALTER TABLE [dbo].[pitch]  WITH CHECK ADD  CONSTRAINT [FK_pitch_place] FOREIGN KEY([id_place])
REFERENCES [dbo].[place] ([id_place])
GO
ALTER TABLE [dbo].[pitch] CHECK CONSTRAINT [FK_pitch_place]
GO
ALTER TABLE [dbo].[pitch]  WITH CHECK ADD  CONSTRAINT [FK_pitch_sports_type] FOREIGN KEY([id_sport_type])
REFERENCES [dbo].[sports_type] ([id_sport_type])
GO
ALTER TABLE [dbo].[pitch] CHECK CONSTRAINT [FK_pitch_sports_type]
GO
ALTER TABLE [dbo].[place]  WITH CHECK ADD  CONSTRAINT [FK_place_cities] FOREIGN KEY([id_city])
REFERENCES [dbo].[cities] ([id_city])
GO
ALTER TABLE [dbo].[place] CHECK CONSTRAINT [FK_place_cities]
GO
ALTER TABLE [dbo].[reservation_multipitch]  WITH CHECK ADD  CONSTRAINT [FK_reservation_multipitch_place] FOREIGN KEY([id_place])
REFERENCES [dbo].[place] ([id_place])
GO
ALTER TABLE [dbo].[reservation_multipitch] CHECK CONSTRAINT [FK_reservation_multipitch_place]
GO
ALTER TABLE [dbo].[scheduler]  WITH CHECK ADD  CONSTRAINT [FK_scheduler_days] FOREIGN KEY([id_day])
REFERENCES [dbo].[days] ([id_day])
GO
ALTER TABLE [dbo].[scheduler] CHECK CONSTRAINT [FK_scheduler_days]
GO
ALTER TABLE [dbo].[scheduler]  WITH CHECK ADD  CONSTRAINT [FK_scheduler_pitch_type] FOREIGN KEY([id_pitch_type])
REFERENCES [dbo].[pitch_type] ([id_pitch_type])
GO
ALTER TABLE [dbo].[scheduler] CHECK CONSTRAINT [FK_scheduler_pitch_type]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_users_type] FOREIGN KEY([id_users_type])
REFERENCES [dbo].[users_type] ([id_users_type])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_users_type]
GO
ALTER TABLE [dbo].[users_offline]  WITH CHECK ADD  CONSTRAINT [FK_users_offline_place] FOREIGN KEY([id_place])
REFERENCES [dbo].[place] ([id_place])
GO
ALTER TABLE [dbo].[users_offline] CHECK CONSTRAINT [FK_users_offline_place]
GO
/****** Object:  StoredProcedure [dbo].[EvoSP_PagedItem]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* **  (c) 2012 Olivier Giulieri - www.evolutility.org   ** */
/*    SQL script for generic paging with Evolutility     */ 
/*
	This file is part of Evolutility CRUD Framework.
	Source link <http://www.evolutility.org/download/download.aspx>

	Evolutility is open source software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	Evolutility is distributed WITHOUT ANY WARRANTY; 
	without even the implied warranty of	MERCHANTABILITY 
	or FITNESS FOR A PARTICULAR PURPOSE.  
	See the GNU General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with Evolutility. If not, see <http://www.fsf.org/licensing/licenses/agpl-3.0.html>.
	
	Commercial license may be purchased at www.evolutility.org <http://www.evolutility.org/product/Purchase.aspx>.
*/

CREATE PROCEDURE [dbo].[EvoSP_PagedItem]
	(
	@Select  varchar(1000),
	@Table varchar(200),
	@TableS varchar(800),
	@WhereClause  varchar(2000),
	@OrderBy  varchar(200),
	@pk varchar(50), 
	@Page int,
	@RecsPerPage int	
	)
AS

SET NOCOUNT ON
DECLARE @FirstRec int, @LastRec int

SELECT @FirstRec = (@Page - 1) * @RecsPerPage + 1

SELECT @LastRec = (@Page * @RecsPerPage)

IF(@RecsPerPage > 0)
BEGIN
	IF (@WhereClause='')
	BEGIN	
		EXEC('WITH Entries AS
		(SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ' ) AS ROW, ' + @Select 
			+ ' FROM ' + @TableS  + ') '
		+ 'SELECT *, MoreRecords = (SELECT COUNT(*) FROM Entries WHERE ROW > ' + @LastRec + ') FROM Entries T WHERE ROW BETWEEN ' + @FirstRec 
			+ ' AND ' + @LastRec) 
	END
	ELSE
	BEGIN
		EXEC('WITH Entries AS
		(SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ' ) AS ROW, ' + @Select 
			+ ' FROM ' + @TableS  + ' WHERE ' + @WhereClause + ')'
		+ 'SELECT *, MoreRecords = (SELECT COUNT(*) FROM Entries WHERE ROW > ' + @LastRec + ') FROM Entries T WHERE ROW BETWEEN ' + @FirstRec 
			+ ' AND ' + @LastRec) 
	END
END
ELSE
BEGIN
	IF (@WhereClause='')
		EXEC('SELECT ' + @Select + ' FROM ' + @TableS  + ' ORDER BY ' +  @OrderBy) 
	ELSE
		EXEC('SELECT ' + @Select + ' FROM ' + @TableS  + ' WHERE ' + @WhereClause + ' ORDER BY ' +  @OrderBy) 
END
SET NOCOUNT OFF


GO
/****** Object:  StoredProcedure [dbo].[getStatistics]    Script Date: 15/06/2020 1:05:05 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alejandra Morales Bolaños
-- Create date: 2017-06-29
-- Description:	Obtiene las estadisticas por cancha, año, mes, cantidad, ingresos y usuarios.
-- =============================================
CREATE PROCEDURE [dbo].[getStatistics]
	-- Add the parameters for the stored procedure here
	@fecha datetime, 
	@option bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @option =0    
	  BEGIN 
				select [id_place], [year],[month],[status], count(1) as cantidad, sum([value]) ingresos  --,id_users_offline
				from 
				(SELECT id_place,year([date]) [year], month([date]) [month],[status], [value] --,r.id_users_offline
				FROM [dbo].[reservation]  r
				where 
				 id_reservation in (select id_reservation
									   from (select id_scheduler, [date],[hour],id_users_offline, max(id_reservation) id_reservation
											 from [dbo].[reservation]
											 where [date] >= @fecha
											 group by id_scheduler, [date],[hour], id_users_offline) as reservationsAux)) as auxt
				group by [id_place],[year], [month], [status] --,id_users_offline
	  END 
	  ELSE 
	    BEGIN 
				select [id_place], [year],[month],[status], count(1) as cantidad, sum([value]) ingresos  ,id_users_offline
				from 
				(SELECT id_place,year([date]) [year], month([date]) [month],[status], [value],r.id_users_offline
				FROM [dbo].[reservation]  r
				where 
				 id_reservation in (select id_reservation
									   from (select id_scheduler, [date],[hour], id_users_offline, max(id_reservation) id_reservation
											 from [dbo].[reservation]
											 where [date] >= @fecha
											 group by id_scheduler, [date],[hour], id_users_offline) as reservationsAux)) as auxt
				group by [id_place],[year], [month], [status] ,id_users_offline
	  END 
	
END

GO
