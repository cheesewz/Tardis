CREATE TABLE [dbo].[Event_Calendars] (
	[CalendarID_R] [char] (35) NOT NULL ,
	[CalendarName_X] [varchar] (100) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Events_EventTypes] (
	[EventTypeID_R] [int] NOT NULL ,
	[EventTypeName_C] [varchar] (50) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Events_Events] (
	[EventID_R] [char] (35) NOT NULL ,
	[Weekend_C] [bit] NOT NULL ,
	[EventTypeID_R] [int] NOT NULL ,
	[Event_D] [datetime] NOT NULL ,
	[Event_T] [datetime] NOT NULL ,
	[End_D] [datetime] NOT NULL ,
	[End_T] [datetime] NOT NULL ,
	[Add_D] [datetime] NOT NULL ,
	[CalendarID_R] [char] (35) NOT NULL ,
	[AuthorID_R] [char] (7) NOT NULL ,
	[Title_X] [varchar] (100) NOT NULL ,
	[Location_X] [varchar] (100) NOT NULL ,
	[Contact_N] [varchar] (100) NOT NULL ,
	[ContactEmail_X] [varchar] (100) NOT NULL ,
	[ContactPhone_R] [varchar] (24) NULL ,
	[InfoURL_X] [varchar] (255) NULL ,
	[Synopsis_X] [varchar] (2000) NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Event_Calendars] WITH NOCHECK ADD 
	CONSTRAINT [PK_Event_Calendars] PRIMARY KEY  CLUSTERED 
	(
		[CalendarID_R]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Events_EventTypes] WITH NOCHECK ADD 
	CONSTRAINT [PK_Events_EventTypes] PRIMARY KEY  CLUSTERED 
	(
		[EventTypeID_R]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Events_Events] WITH NOCHECK ADD 
	CONSTRAINT [PK_Events_Events] PRIMARY KEY  CLUSTERED 
	(
		[EventID_R]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Events_Events] ADD 
	CONSTRAINT [DF_Events_Events_Weekend_C_1] DEFAULT (0) FOR [Weekend_C],
	CONSTRAINT [DF_Events_Events_Add_D] DEFAULT (getdate()) FOR [Add_D]
GO

ALTER TABLE [dbo].[Events_Events] ADD 
	CONSTRAINT [FK_Events_Events_Event_Calendars] FOREIGN KEY 
	(
		[CalendarID_R]
	) REFERENCES [dbo].[Event_Calendars] (
		[CalendarID_R]
	),
	CONSTRAINT [FK_Events_Events_Events_EventTypes] FOREIGN KEY 
	(
		[EventTypeID_R]
	) REFERENCES [dbo].[Events_EventTypes] (
		[EventTypeID_R]
	)
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE dbo.addevent 

@EventID_R char(35),
@Weekend_C bit,
@EventTypeID_R int,
@Event_D datetime,
@Event_T datetime,
@End_D datetime,
@End_T datetime,
@CalendarID_R char(35),
@AuthorID_R char(7),
@Title_X varchar (100),
@Location_X varchar(100),
@Contact_N varchar(100),
@ContactEmail_X varchar (100),
@ContactPhone_R varchar(24),
@InfoURL_X varchar(255),
@Synopsis_X varchar(2000)

AS

INSERT INTO Events_Events(	EventID_R,
				Weekend_C,
				EventTypeID_R,
				Event_D,
				Event_T,
				End_D,
				End_T ,
				CalendarID_R,
				AuthorID_R,
				Title_X,
				Location_X,
				Contact_N,
				ContactEmail_X,
				ContactPhone_R,
				InfoURL_X,
				Synopsis_X)

VALUES(	@EventID_R,
		@Weekend_C,
		@EventTypeID_R,
		@Event_D,
		@Event_T,
		@End_D,
		@End_T ,
		@CalendarID_R,
		@AuthorID_R,
		@Title_X,
		@Location_X,
		@Contact_N,
		@ContactEmail_X,
		@ContactPhone_R,
		@InfoURL_X, 
		@Synopsis_X 
	)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE dbo.deleteevent

@EventID_R char(35)

 AS

DELETE FROM Events_Events 
WHERE EventID_R = @EventID_R

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE dbo.updateevent 

@EventID_R char(35),
@Weekend_C bit,
@EventTypeID_R int,
@Event_D datetime,
@Event_T datetime,
@End_D datetime,
@End_T datetime,
@CalendarID_R char(35),
@AuthorID_R char(7),
@Title_X varchar (100),
@Location_X varchar(100),
@Contact_N varchar(100),
@ContactEmail_X varchar (100),
@ContactPhone_R varchar(24),
@InfoURL_X varchar(255),
@Synopsis_X varchar(2000)

AS

UPDATE 	Events_Events
SET		EventID_R = @EventID_R,
		Weekend_C = @Weekend_C,
		EventTypeID_R = @EventTypeID_R,
		Event_D = @Event_D,
		Event_T = @Event_T,
		End_D = @End_D,
		End_T = @End_T,
		CalendarID_R = @CalendarID_R,
		AuthorID_R = @AuthorID_R,
		Title_X = @Title_X,
		Location_X = @Location_X,
		Contact_N = @Contact_N,
		ContactEmail_X = @ContactEmail_X,
		ContactPhone_R = @ContactPhone_R,
		InfoURL_X = @InfoURL_X,
		Synopsis_X = @Synopsis_X
WHERE 	EventID_R = @EventID_R

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

