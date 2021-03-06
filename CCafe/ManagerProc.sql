USE [Cyber_Cafe]
GO
/****** Object:  StoredProcedure [dbo].[AvailableConsoles]    Script Date: 17/12/2019 08:36:52 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AvailableConsoles]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.room_no, C.name, R.[type] AS Room_Type FROM (Console C JOIN ROOM R ON room_no = number)  WHERE available = 1 AND condition = 'okay'
END

GO
/****** Object:  StoredProcedure [dbo].[MaintainConsoles]    Script Date: 17/12/2019 08:36:52 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MaintainConsoles]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Console
END

GO
/****** Object:  StoredProcedure [dbo].[MakeReservation]    Script Date: 17/12/2019 08:36:52 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MakeReservation]
	-- Add the parameters for the stored procedure here
	@EID int,
	@Date date,
	@room_no int,
	@game_name varchar(20),
	@CID int,
	@start_time time,
	@end_time time
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	IF NOT EXISTS(SELECT * FROM Reserve WHERE [Date] = @DATE AND room_no = @room_no AND (@start_time >= start_time AND @start_time < end_time))
	BEGIN
		INSERT INTO Reserve VALUES(@EID, @Date, @room_no, @game_name, @CID, @start_time, @end_time)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SellOrder]    Script Date: 17/12/2019 08:36:52 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SellOrder]
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@type varchar(20),
	@EID varchar(20),
	@quantity int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Order_Shift VALUES(@name, @type, @EID, GETDATE(), @quantity)
END

GO
/****** Object:  StoredProcedure [dbo].[UserLogin]    Script Date: 17/12/2019 08:36:52 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UserLogin]
	-- Add the parameters for the stored procedure here
	@ID int,
	@password varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	SELECT * FROM [User] WHERE @ID = ID AND [password] = HASHBYTES('SHA2_512', @Password+'P@ssw0rd')
END

GO
/****** Object:  StoredProcedure [dbo].[ViewGames]    Script Date: 17/12/2019 08:36:52 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewGames]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT name FROM Game
END

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE View_All_Tournaments
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Tournament
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE View_All_Offers
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Offer
END
GO

CREATE PROCEDURE ViewAllFeedback
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from Feedback;
END
GO

CREATE PROCEDURE ChangePassword
@ID int,
@type int,
@password varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update [User] Set [User].[password] = HASHBYTES('SHA2_512', @password+'P@ssw0rd')  where @ID = id;
END
GO