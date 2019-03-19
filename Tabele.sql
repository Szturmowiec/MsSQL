USE [pcwiklic_a]
GO

IF OBJECT_ID('Dzien_konferencji', 'U') is not null 
DROP TABLE Dzien_konferencji;
IF OBJECT_ID('Firma', 'U') is not null  
DROP TABLE Firma;
IF OBJECT_ID('Klient', 'U') is not null  
DROP TABLE Klient;
IF OBJECT_ID('Konferencje', 'U') is not null  
DROP TABLE Konferencje;
IF OBJECT_ID('Osoba_fizyczna', 'U') is not null  
DROP TABLE Osoba_fizyczna;
IF OBJECT_ID('Progi_cenowe', 'U') is not null  
DROP TABLE Progi_cenowe;
IF OBJECT_ID('Szczegoly_rezerwacji_konferencji', 'U') is not null  
DROP TABLE Szczegoly_rezerwacji_konferencji;
IF OBJECT_ID('Szczegoly_rezerwacji_warsztatu', 'U') is not null  
DROP TABLE Szczegoly_rezerwacji_warsztatu;
IF OBJECT_ID('Uczestnik', 'U') is not null  
DROP TABLE Uczestnik;
IF OBJECT_ID('Warsztaty', 'U') is not null  
DROP TABLE Warsztaty;
IF OBJECT_ID('Wczesna_rezerwacja_konferencji', 'U') is not null  
DROP TABLE Wczesna_rezerwacja_konferencji;
IF OBJECT_ID('Wczesna_rezerwacja_warsztatu', 'U') is not null  
DROP TABLE Wczesna_rezerwacja_warsztatu;
IF OBJECT_ID('Zaplata', 'U') is not null  
DROP TABLE Zaplata;

/****** Object:  Table [dbo].[Dzien_konferencji]    Script Date: 02.01.2018 11:28:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dzien_konferencji](
	[IDDniaKonferencji] [int] IDENTITY (1,1) NOT NULL,
	[IDKonferencji] [int] NOT NULL,
	[Data] [date] NOT NULL,
	[Ilosc_miejsc] [int] NOT NULL,
 CONSTRAINT [PK_Dzien_konferencji] PRIMARY KEY CLUSTERED 
(
	[IDDniaKonferencji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Dzien_konferencji]  WITH CHECK ADD  CONSTRAINT [FK_Dzien_konferencji_Konferencje] FOREIGN KEY([IDKonferencji])
REFERENCES [dbo].[Konferencje] ([IDKonferencji])
GO

ALTER TABLE [dbo].[Dzien_konferencji] CHECK CONSTRAINT [FK_Dzien_konferencji_Konferencje]
GO


USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Firma]    Script Date: 02.01.2018 11:28:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Firma](
	[IDKlienta] [int] IDENTITY (1,1) NOT NULL,
	[Nazwa] [varchar](40) NOT NULL,
 CONSTRAINT [PK_Firma] PRIMARY KEY CLUSTERED 
(
	[IDKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Firma]  WITH CHECK ADD  CONSTRAINT [FK_Firma_Klient] FOREIGN KEY([IDKlienta])
REFERENCES [dbo].[Klient] ([IDKlienta])
GO

ALTER TABLE [dbo].[Firma] CHECK CONSTRAINT [FK_Firma_Klient]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Klient]    Script Date: 02.01.2018 11:29:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Klient](
	[IDKlienta] [int] IDENTITY (1,1) NOT NULL,
	[Miasto] [varchar](20) NOT NULL,
	[Ulica] [varchar](20) NOT NULL,
	[Kod_pocztowy] [varchar](6) NOT NULL,
	[Kraj] [varchar](30) NOT NULL,
	[Email] [varchar](30) NULL,
	[Telefon] [varchar](15) NULL,
	[Login] [varchar](10) NOT NULL,
	[Haslo] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Klient] PRIMARY KEY CLUSTERED 
(
	[IDKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Konferencje]    Script Date: 02.01.2018 11:29:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Konferencje](
	[IDKonferencji] [int] IDENTITY (1,1) NOT NULL,
	[Nazwa] [varchar](30) NOT NULL,
	[Data_rozpoczecia] [date] NOT NULL,
	[Data_zakonczenia] [date] NOT NULL,
 CONSTRAINT [PK_Konferencje] PRIMARY KEY CLUSTERED 
(
	[IDKonferencji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Osoba_fizyczna]    Script Date: 02.01.2018 11:29:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Osoba_fizyczna](
	[IDKlienta] [int] IDENTITY (1,1) NOT NULL,
	[Imie] [varchar](20) NOT NULL,
	[Nazwisko] [varchar](30) NOT NULL,
	[PESEL] [int] NOT NULL,
 CONSTRAINT [PK_Osoba_fizyczna] PRIMARY KEY CLUSTERED 
(
	[IDKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Osoba_fizyczna]  WITH CHECK ADD  CONSTRAINT [FK_Osoba_fizyczna_Klient] FOREIGN KEY([IDKlienta])
REFERENCES [dbo].[Klient] ([IDKlienta])
GO

ALTER TABLE [dbo].[Osoba_fizyczna] CHECK CONSTRAINT [FK_Osoba_fizyczna_Klient]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Progi_cenowe]    Script Date: 02.01.2018 11:29:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Progi_cenowe](
	[IDKonferencji] [int] IDENTITY (1,1) NOT NULL,
	[Cena] [money] NOT NULL,
	[Termin_zaplaty] [date] NOT NULL,
 CONSTRAINT [PK_Progi_cenowe] PRIMARY KEY CLUSTERED 
(
	[IDKonferencji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Progi_cenowe]  WITH CHECK ADD  CONSTRAINT [FK_Progi_cenowe_Konferencje] FOREIGN KEY([IDKonferencji])
REFERENCES [dbo].[Konferencje] ([IDKonferencji])
GO

ALTER TABLE [dbo].[Progi_cenowe] CHECK CONSTRAINT [FK_Progi_cenowe_Konferencje]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Szczegoly_rezerwacji_konferencji]    Script Date: 02.01.2018 11:30:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Szczegoly_rezerwacji_konferencji](
	[IDRezerwacjiKonferencji] [int] IDENTITY (1,1) NOT NULL,
	[IDWczesnejRezerwacjiKonferencji] [int] NOT NULL,
	[IDDniaKonferencji] [int] NOT NULL,
	[Data_rezerwacji] [date] NOT NULL,
	[IDUczestnika] [int] NOT NULL,
 CONSTRAINT [PK_Szczegoly_rezerwacji_konferencji] PRIMARY KEY CLUSTERED 
(
	[IDRezerwacjiKonferencji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_konferencji]  WITH CHECK ADD  CONSTRAINT [FK_Szczegoly_rezerwacji_konferencji_Dzien_konferencji] FOREIGN KEY([IDDniaKonferencji])
REFERENCES [dbo].[Dzien_konferencji] ([IDDniaKonferencji])
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_konferencji] CHECK CONSTRAINT [FK_Szczegoly_rezerwacji_konferencji_Dzien_konferencji]
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_konferencji]  WITH CHECK ADD  CONSTRAINT [FK_Szczegoly_rezerwacji_konferencji_Uczestnik] FOREIGN KEY([IDUczestnika])
REFERENCES [dbo].[Uczestnik] ([IDUczestnika])
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_konferencji] CHECK CONSTRAINT [FK_Szczegoly_rezerwacji_konferencji_Uczestnik]
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_konferencji]  WITH CHECK ADD  CONSTRAINT [FK_Szczegoly_rezerwacji_konferencji_Wczesna_rezerwacja_konferencji] FOREIGN KEY([IDWczesnejRezerwacjiKonferencji])
REFERENCES [dbo].[Wczesna_rezerwacja_konferencji] ([IDWczesnejRezerwacjiKonferencji])
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_konferencji] CHECK CONSTRAINT [FK_Szczegoly_rezerwacji_konferencji_Wczesna_rezerwacja_konferencji]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Szczegoly_rezerwacji_warsztatu]    Script Date: 02.01.2018 11:30:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Szczegoly_rezerwacji_warsztatu](
	[IDRezerwacjiWarsztatu] [int] IDENTITY (1,1) NOT NULL,
	[IDRezerwacjiKonferencji] [int] NOT NULL,
	[IDWczesnejRezerwacjiWarsztatu] [int] NOT NULL,
	[IDWarsztatu] [int] NOT NULL,
	[Data_rezerwacji] [date] NOT NULL,
	[IDUczestnika] [int] NOT NULL,
 CONSTRAINT [PK_Szczegoly_rezerwacji_warsztatu] PRIMARY KEY CLUSTERED 
(
	[IDRezerwacjiWarsztatu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_warsztatu]  WITH CHECK ADD  CONSTRAINT [FK_Szczegoly_rezerwacji_warsztatu_Szczegoly_rezerwacji_konferencji1] FOREIGN KEY([IDRezerwacjiKonferencji])
REFERENCES [dbo].[Szczegoly_rezerwacji_konferencji] ([IDRezerwacjiKonferencji])
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_warsztatu] CHECK CONSTRAINT [FK_Szczegoly_rezerwacji_warsztatu_Szczegoly_rezerwacji_konferencji1]
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_warsztatu]  WITH CHECK ADD  CONSTRAINT [FK_Szczegoly_rezerwacji_warsztatu_Warsztaty] FOREIGN KEY([IDWarsztatu])
REFERENCES [dbo].[Warsztaty] ([IDWarsztatu])
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_warsztatu] CHECK CONSTRAINT [FK_Szczegoly_rezerwacji_warsztatu_Warsztaty]
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_warsztatu]  WITH CHECK ADD  CONSTRAINT [FK_Szczegoly_rezerwacji_warsztatu_Wczesna_rezerwacja_warsztatu] FOREIGN KEY([IDWczesnejRezerwacjiWarsztatu])
REFERENCES [dbo].[Wczesna_rezerwacja_warsztatu] ([IDWczesnejRezerwacjiWarsztatu])
GO

ALTER TABLE [dbo].[Szczegoly_rezerwacji_warsztatu] CHECK CONSTRAINT [FK_Szczegoly_rezerwacji_warsztatu_Wczesna_rezerwacja_warsztatu]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Uczestnik]    Script Date: 02.01.2018 11:30:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Uczestnik](
	[IDUczestnika] [int] IDENTITY (1,1) NOT NULL,
	[Imie] [varchar](20) NOT NULL,
	[Nazwisko] [varchar](30) NOT NULL,
	[Miasto] [varchar](20) NOT NULL,
	[Ulica] [varchar](20) NOT NULL,
	[Kod_pocztowy] [varchar](10) NOT NULL,
	[Kraj] [varchar](30) NOT NULL,
	[Email] [varchar](30) NULL,
	[Telefon] [varchar](15) NULL,
	[Znizka] [decimal](3, 2) NOT NULL,
	[Nr_legitymacji] [int] NULL,
	[Login] [varchar](10) NOT NULL,
	[Haslo] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Uczestnik] PRIMARY KEY CLUSTERED 
(
	[IDUczestnika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Warsztaty]    Script Date: 02.01.2018 11:30:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Warsztaty](
	[IDWarsztatu] [int] IDENTITY (1,1) NOT NULL,
	[IDDniaKonferencji] [int] NOT NULL,
	[Nazwa] [varchar](20) NOT NULL,
	[Cena] [money] NOT NULL,
	[Data] [date] NOT NULL,
	[Ilosc_miejsc] [int] NOT NULL,
 CONSTRAINT [PK_Warsztaty] PRIMARY KEY CLUSTERED 
(
	[IDWarsztatu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Warsztaty]  WITH CHECK ADD  CONSTRAINT [FK_Warsztaty_Dzien_konferencji] FOREIGN KEY([IDDniaKonferencji])
REFERENCES [dbo].[Dzien_konferencji] ([IDDniaKonferencji])
GO

ALTER TABLE [dbo].[Warsztaty] CHECK CONSTRAINT [FK_Warsztaty_Dzien_konferencji]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Wczesna_rezerwacja_konferencji]    Script Date: 02.01.2018 11:30:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Wczesna_rezerwacja_konferencji](
	[IDWczesnejRezerwacjiKonferencji] [int] IDENTITY (1,1) NOT NULL,
	[IDDniaKonferencji] [int] NULL,
	[Ilosc_miejsc] [int] NULL,
	[Data_rezerwacji] [date] NULL,
	[IDKlienta] [int] NULL,
 CONSTRAINT [PK_Wczesna_rezerwacja_konferencji] PRIMARY KEY CLUSTERED 
(
	[IDWczesnejRezerwacjiKonferencji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_konferencji]  WITH CHECK ADD  CONSTRAINT [FK_Wczesna_rezerwacja_konferencji_Dzien_konferencji] FOREIGN KEY([IDDniaKonferencji])
REFERENCES [dbo].[Dzien_konferencji] ([IDDniaKonferencji])
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_konferencji] CHECK CONSTRAINT [FK_Wczesna_rezerwacja_konferencji_Dzien_konferencji]
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_konferencji]  WITH CHECK ADD  CONSTRAINT [FK_Wczesna_rezerwacja_konferencji_Klient] FOREIGN KEY([IDKlienta])
REFERENCES [dbo].[Klient] ([IDKlienta])
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_konferencji] CHECK CONSTRAINT [FK_Wczesna_rezerwacja_konferencji_Klient]
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_konferencji]  WITH CHECK ADD  CONSTRAINT [FK_Wczesna_rezerwacja_konferencji_Zaplata] FOREIGN KEY([IDKlienta])
REFERENCES [dbo].[Zaplata] ([IDKlienta])
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_konferencji] CHECK CONSTRAINT [FK_Wczesna_rezerwacja_konferencji_Zaplata]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Wczesna_rezerwacja_warsztatu]    Script Date: 02.01.2018 11:31:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Wczesna_rezerwacja_warsztatu](
	[IDWczesnejRezerwacjiWarsztatu] [int] IDENTITY (1,1) NOT NULL,
	[IDWczesnejRezerwacjiKonferencji] [int] NOT NULL,
	[IDWarsztatu] [int] NOT NULL,
	[IDKlienta] [int] NOT NULL,
	[Ilosc_miejsc] [int] NOT NULL,
	[Data_rezerwacji] [date] NOT NULL,
 CONSTRAINT [PK_Wczesna_rezerwacja_warsztatu] PRIMARY KEY CLUSTERED 
(
	[IDWczesnejRezerwacjiWarsztatu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_warsztatu]  WITH CHECK ADD  CONSTRAINT [FK_Wczesna_rezerwacja_warsztatu_Warsztaty] FOREIGN KEY([IDWarsztatu])
REFERENCES [dbo].[Warsztaty] ([IDWarsztatu])
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_warsztatu] CHECK CONSTRAINT [FK_Wczesna_rezerwacja_warsztatu_Warsztaty]
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_warsztatu]  WITH CHECK ADD  CONSTRAINT [FK_Wczesna_rezerwacja_warsztatu_Wczesna_rezerwacja_konferencji] FOREIGN KEY([IDWczesnejRezerwacjiKonferencji])
REFERENCES [dbo].[Wczesna_rezerwacja_konferencji] ([IDWczesnejRezerwacjiKonferencji])
GO

ALTER TABLE [dbo].[Wczesna_rezerwacja_warsztatu] CHECK CONSTRAINT [FK_Wczesna_rezerwacja_warsztatu_Wczesna_rezerwacja_konferencji]
GO

USE [pcwiklic_a]
GO

/****** Object:  Table [dbo].[Zaplata]    Script Date: 02.01.2018 11:31:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Zaplata](
	[IDKlienta] [int] IDENTITY (1,1) NOT NULL,
	[Data_zaplaty] [date] NOT NULL,
 CONSTRAINT [PK_Zaplata] PRIMARY KEY CLUSTERED 
(
	[IDKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

