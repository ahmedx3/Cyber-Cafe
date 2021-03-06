USE [Cyber_Cafe]
GO
/****** Object:  StoredProcedure [dbo].[AvailableConsoles]    Script Date: 21/12/2019 04:44:39 ص ******/
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
/****** Object:  StoredProcedure [dbo].[BuySupplies]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuySupplies]
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@type varchar(20),
	@price int = -1,
	@Stock int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM FoodNDrinks WHERE name = @name AND [type] = @type)
	BEGIN
		IF @price = -1
		BEGIN
			UPDATE FoodNDrinks SET Stock = (SELECT stock WHERE name = @name AND [type] = @type) + @Stock WHERE name = @name AND [type] = @type
		END
		ELSE
		BEGIN
			UPDATE FoodNDrinks SET Stock = (SELECT stock WHERE name = @name AND [type] = @type) + @Stock, price = @price WHERE name = @name AND [type] = @type
		END
	END
	ELSE
	BEGIN
		INSERT INTO FoodNDrinks VALUES(@name, @type, @price, @Stock)
	END
END



GO
/****** Object:  StoredProcedure [dbo].[ChangePassword]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChangePassword]
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
/****** Object:  StoredProcedure [dbo].[EditConsoles]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditConsoles]
	-- Add the parameters for the stored procedure here
	@room_no int,
	@name varchar(20),
	@condition varchar(20) = okay
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM Console WHERE room_no = @room_no)
	BEGIN
		UPDATE Console SET condition = @condition, name = @name WHERE room_no = @room_no
	END
	ELSE
	BEGIN
		INSERT INTO Console VALUES(@room_no, @name, @condition)
	END
END



GO
/****** Object:  StoredProcedure [dbo].[EditGames]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditGames]
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@total_number int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM Game WHERE name = @name)
	BEGIN
		UPDATE Game SET total_number = (SELECT total_number FROM Game WHERE name = @name) + @total_number WHERE name = @name
	END
	ELSE
	BEGIN
		INSERT INTO Game VALUES(@name, @total_number)
	END
END



GO
/****** Object:  StoredProcedure [dbo].[EditPrice]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditPrice]
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@type varchar(20),
	@price int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE FoodNDrinks SET price = @price WHERE name = @name AND [type] = @type
END



GO
/****** Object:  StoredProcedure [dbo].[EditRooms]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditRooms]
	-- Add the parameters for the stored procedure here
	@number int,
	@type varchar(10),
	@available bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM Room WHERE number = @number)
	BEGIN
		UPDATE Room SET [type] = @type, available = @available WHERE number = @number
	END
	ELSE
	BEGIN
		INSERT INTO Room VALUES(@number, @type, @available)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[EditSalary]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditSalary]
	-- Add the parameters for the stored procedure here
	@ID int,
	@salary int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Employee SET salary = @salary WHERE ID = @ID
END



GO
/****** Object:  StoredProcedure [dbo].[EditTourn]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditTourn]
	-- Add the parameters for the stored procedure here
	@name varchar(50),
	@date date,
	@status varchar(20),
	@comp_no int,
	@game_name varchar(20),
	@room_no int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM Tournament WHERE name = @name)
	BEGIN
		Set @date = (Select Tournament.date from Tournament where Tournament.name = @name)
		UPDATE Tournament SET [status] = @status, comp_no = @comp_no WHERE name = @name AND [Date] = @date
	END
	ELSE
	BEGIN
		INSERT INTO Tournament VALUES(@name, @date, @status, @comp_no)
		Insert into held values (@name,@date,@game_name,@room_no)
	END
END




GO
/****** Object:  StoredProcedure [dbo].[FireEmp]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FireEmp]
	-- Add the parameters for the stored procedure here
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Employee WHERE ID = @ID
END



GO
/****** Object:  StoredProcedure [dbo].[HireEmp]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[HireEmp]
	-- Add the parameters for the stored procedure here
	@ID int,
	@name varchar(20),
	@salary int,
	@start_time time,
	@end_time time
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Employee VALUES(@ID, @name, @salary, @start_time, @end_time, 0)
END



GO
/****** Object:  StoredProcedure [dbo].[Insert_Offer_Customer]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Offer_Customer]
	-- Add the parameters for the stored procedure here
	@cid int,
	@name varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	-- Get tounamnet start date
	Insert into Customer_Offer
	values (@cid, @name)
END


GO
/****** Object:  StoredProcedure [dbo].[Insert_Tournament_participant]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Tournament_participant] 
	-- Add the parameters for the stored procedure here
	@name varchar (50),
	@cid int,
	@reg_date date

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	-- Get tounamnet start date
	Declare @date date 

	set @date = (Select [date] from Tournament where Tournament.[name] = @name)

	--insertion
	insert into Cust_Tourn
	values
	(@name,@date,@cid,@reg_date)
	
END


GO
/****** Object:  StoredProcedure [dbo].[InsertIntoCustomer]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertIntoCustomer]
@ID INT,
@name varchar(20),
@email varchar(50),
@phone_no varchar(13)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Customer
	VALUES(@ID,@name,@email,@phone_no)
END


GO
/****** Object:  StoredProcedure [dbo].[InsertintoFeedback]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertintoFeedback]
	-- Add the parameters for the stored procedure here
@date date ,
@cid int,
@description varchar(500),
@type varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO Feedback 
	Values (@date , @cid , @description, @type)
END


GO
/****** Object:  StoredProcedure [dbo].[InsertNewUser]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewUser] 
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
/****** Object:  StoredProcedure [dbo].[MaintainConsoles]    Script Date: 21/12/2019 04:44:39 ص ******/
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
/****** Object:  StoredProcedure [dbo].[MakeOffer]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MakeOffer]
	-- Add the parameters for the stored procedure here
	@name varchar(20),
	@type varchar(50),
	@discount int,
	@start_date date,
	@end_date date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	If Exists (Select * from Offer where @name = offer.name)
	Begin
	Update Offer Set [type] = @type , discount = @discount , offer.start_date =@start_date, offer.end_date = @end_date where offer.name = @name;
	end
	else
	INSERT INTO Offer VALUES(@name, @type, @discount, @start_date, @end_date)
END



GO
/****** Object:  StoredProcedure [dbo].[MakeReservation]    Script Date: 21/12/2019 04:44:39 ص ******/
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
/****** Object:  StoredProcedure [dbo].[MakeReservationEmployee]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[MakeReservationEmployee]
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

GO
/****** Object:  StoredProcedure [dbo].[ModifyFoodStock]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ModifyFoodStock]
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
/****** Object:  StoredProcedure [dbo].[ModifyGameStock]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ModifyGameStock]
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
/****** Object:  StoredProcedure [dbo].[SellOrder]    Script Date: 21/12/2019 04:44:39 ص ******/
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
/****** Object:  StoredProcedure [dbo].[UserLogin]    Script Date: 21/12/2019 04:44:39 ص ******/
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
/****** Object:  StoredProcedure [dbo].[View_All_Offers]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[View_All_Offers]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Offer
END


GO
/****** Object:  StoredProcedure [dbo].[View_All_Tournaments]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[View_All_Tournaments]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Tournament.name,Tournament.date,Tournament.comp_no,Tournament.status,Held.g_name,Held.room_no
	FROM Tournament join Held on Tournament.date = Held.t_date and Tournament.name = Held.t_name
END


GO
/****** Object:  StoredProcedure [dbo].[View_Available_offers]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[View_Available_offers]
	-- Add the parameters for the stored procedure here
	@reg_date date

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	-- Get tounamnet start date
	SELECT [NAME] FROM Offer WHERE @reg_date >= [start_date] AND @reg_date <= [end_date]
END


GO
/****** Object:  StoredProcedure [dbo].[View_Available_Tournaments]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[View_Available_Tournaments] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Tournament.[name] from Tournament where status = 'ongoing';
END


GO
/****** Object:  StoredProcedure [dbo].[ViewAccounts]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewAccounts] 
	-- Add the parameters for the stored procedure here
	@type int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @type = 3
	BEGIN
		SELECT * FROM Customer
	END
	ELSE IF @type = 2
	BEGIN
		SELECT * FROM Employee
	END
	ELSE
	BEGIN
		SELECT ID FROM [User] WHERE Usertype = 1
	END
END


GO
/****** Object:  StoredProcedure [dbo].[ViewAllFeedback]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ViewAllFeedback]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from Feedback;
END

GO
/****** Object:  StoredProcedure [dbo].[ViewConsoles]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewConsoles] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	SELECT * FROM Console
END

GO
/****** Object:  StoredProcedure [dbo].[ViewCustomerID]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[ViewCustomerID]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;


    -- Insert statements for procedure here
	select distinct ID from Customer
End

GO
/****** Object:  StoredProcedure [dbo].[ViewFoodAndDrinks]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[ViewFoodAndDrinks]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM FoodNDrinks
END

GO
/****** Object:  StoredProcedure [dbo].[ViewGameDetails]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[ViewGameDetails]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Game
END

GO
/****** Object:  StoredProcedure [dbo].[ViewGames]    Script Date: 21/12/2019 04:44:39 ص ******/
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
	SELECT * FROM Game
END



GO
/****** Object:  StoredProcedure [dbo].[ViewRoomNumber]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ViewRoomNumber]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Room
END

GO
/****** Object:  StoredProcedure [dbo].[ViewSupply]    Script Date: 21/12/2019 04:44:39 ص ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewSupply]
	-- Add the parameters for the stored procedure here
	@type varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @type IN ('Food', 'Drink')
	BEGIN
		SELECT * FROM FoodNDrinks WHERE [type] = @type
	END
	ELSE
	BEGIN
		SELECT * FROM FoodNDrinks
	END
END

GO

CREATE PROCEDURE Insert_Shift_Log
@ID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF Exists(SELECT * FROM Shift_Logs WHERE id =@ID and Shift_Logs.Date = (SELECT CONVERT(varchar, getdate(), 23)) )
	return 0
	else 
	Begin
	INSERT INTO Shift_Logs
	VALUES (@ID,(SELECT CONVERT(varchar, getdate(), 23)))
	return 1
	end
END
GO

CREATE PROCEDURE ViewReservation
@date date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Reserve WHERE Reserve.Date = @date
END
GO

Create PROCEDURE GetDiscount
@ID int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF EXISTS (SELECT * from Customer_Offer where @ID = Customer_Offer.CID )
	begin
	(Select Sum(discount) as s,CID from Customer_Offer join Offer on Offer.name = Customer_Offer.offer_name where CID =@ID group by CID )
	end
END
GO

USE [Cyber_Cafe]
GO
/****** Object:  StoredProcedure [dbo].[MakeReservation]    Script Date: 12/21/2019 1:22:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[MakeReservation]
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
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF	EXISTS (SELECT * FROM Shift_Logs where Shift_Logs.ID = @EID and Shift_Logs.Date = @Date)
	BEGIN
		IF NOT EXISTS(SELECT * FROM Reserve WHERE [Date] = @DATE AND room_no = @room_no AND (@start_time >= start_time AND @start_time < end_time))
		BEGIN
			INSERT INTO Reserve VALUES(@EID, @Date, @room_no, @game_name, @CID, @start_time, @end_time)
			RETURN 1
		END
		ELSE RETURN -1
	END
	ELSE RETURN 0
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
CREATE PROCEDURE GetShift
@stime time 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	RETURN (SELECT Employee.ID from Employee where Employee.start_time <= @stime and Employee.end_time >= @stime)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
