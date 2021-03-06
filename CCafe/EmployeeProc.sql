USE [Cyber_Cafe]
GO
/****** Object:  StoredProcedure [dbo].[AvailableConsoles]    Script Date: 14/12/2019 02:30:05 م ******/
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
/****** Object:  StoredProcedure [dbo].[MaintainConsoles]    Script Date: 14/12/2019 02:30:05 م ******/
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
	@room_no int,
	@condition varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM Console WHERE room_no = @room_no)
	BEGIN
		UPDATE Console SET condition = @condition WHERE room_no = @room_no
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SellOrder]    Script Date: 14/12/2019 02:30:05 م ******/
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
	--@type varchar(20),
	--@Time Time,
	@quantity int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @type varchar(20)
	set @type = (select type from FoodNDrinks where FoodNDrinks.name = @name)

	declare @EID int
	set @EID = ( SELECT E.ID from Employee E where E.start_time <= convert(varchar(10), GETDATE(), 108) and E.end_time >= convert(varchar(10), GETDATE(), 108) )

	INSERT INTO Order_Shift VALUES(@name, @type , @EID, (SELECT CONVERT(varchar, getdate(), 23)) , @quantity)
END

GO
/****** Object:  StoredProcedure [dbo].[UserLogin]    Script Date: 14/12/2019 02:30:05 م ******/
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
	IF EXISTS
	( SELECT * FROM [User] WHERE @ID = ID AND [password] = HASHBYTES('SHA2_512', @Password+'P@ssw0rd') )
	RETURN (SELECT [USER].Usertype FROM [User] WHERE ID = @ID)
	ELSE 
	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[ViewGames]    Script Date: 14/12/2019 02:30:05 م ******/
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

CREATE PROCEDURE InsertNewUser 
	-- Add the parameters for the stored procedure here
@Usertype int = 3, --default is customer
@ID int,
@Password varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM [USER] WHERE ID = @ID)
	RETURN 0
	ELSE
	BEGIN
	INSERT INTO [USER] 
	VALUES (@ID , @Usertype ,HASHBYTES('SHA2_512', @Password+'P@ssw0rd') )
	RETURN 1
	END
END
GO

CREATE PROCEDURE ModifyFoodStock
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@stock int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE FoodNDrinks set stock = @stock where name = @name
END
GO

CREATE PROCEDURE ModifyGameStock
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@total_number int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Game set total_number = @total_number where name = @name
END
GO

create PROCEDURE ViewGameDetails
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Game
END

Create PROCEDURE ViewFoodAndDrinks
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM FoodNDrinks
END

Create PROCEDURE ViewRoomNumber
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT number from Room
END

Create PROCEDURE MakeReservationEmployee
	-- Add the parameters for the stored procedure here
	--@EID int,
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

	declare @EID int
	set @EID = ( SELECT E.ID from Employee E where E.start_time <= convert(varchar(10), GETDATE(), 108) and E.end_time >= convert(varchar(10), GETDATE(), 108) )

    -- Insert statements for procedure here
	IF NOT EXISTS(SELECT * FROM Reserve WHERE [Date] = @DATE AND room_no = @room_no AND (@start_time >= start_time AND @start_time < end_time))
	BEGIN
		INSERT INTO Reserve VALUES(@EID, @Date, @room_no, @game_name, @CID, @start_time, @end_time)
	END
End
Go

Create PROCEDURE ViewCustomerID
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;


    -- Insert statements for procedure here
	select distinct ID from Customer
End
Go