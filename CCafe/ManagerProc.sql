USE [Cyber_Cafe]
GO
/****** Object:  StoredProcedure [dbo].[BuySupplies]    Script Date: 09/12/2019 06:23:14 م ******/
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
	@price int = 1, -- no need for price in case of updating existing supply
	@Stock int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM FoodNDrinks WHERE name = @name AND [type] = @type)
	BEGIN
		UPDATE FoodNDrinks SET Stock = (SELECT stock WHERE name = @name AND [type] = @type) + @Stock WHERE name = @name AND [type] = @type
	END
	ELSE
	BEGIN
		INSERT INTO FoodNDrinks VALUES(@name, @type, @price, @Stock)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[EditConsoles]    Script Date: 09/12/2019 06:23:14 م ******/
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
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM Console WHERE room_no = @room_no AND name = @name)
	BEGIN
		UPDATE Console SET condition = @condition WHERE room_no = @room_no AND name = @name
	END
	ELSE
	BEGIN
		INSERT INTO Console VALUES(@room_no, @name, @condition)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[EditGames]    Script Date: 09/12/2019 06:23:14 م ******/
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
	SET NOCOUNT ON;

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
/****** Object:  StoredProcedure [dbo].[EditPrice]    Script Date: 09/12/2019 06:23:14 م ******/
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
/****** Object:  StoredProcedure [dbo].[EditSalary]    Script Date: 09/12/2019 06:23:14 م ******/
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
/****** Object:  StoredProcedure [dbo].[EditTourn]    Script Date: 09/12/2019 06:23:14 م ******/
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
	@comp_no int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM Torunament WHERE name = @name AND [Date] = @date)
	BEGIN
		UPDATE Torunament SET [status] = @status, comp_no = @comp_no WHERE name = @name AND [Date] = @date
	END
	ELSE
	BEGIN
		INSERT INTO Torunament VALUES(@name, @date, @status, @comp_no)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[FireEmp]    Script Date: 09/12/2019 06:23:14 م ******/
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
/****** Object:  StoredProcedure [dbo].[HireEmp]    Script Date: 09/12/2019 06:23:14 م ******/
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
	@end_time time,
	@complaint_no int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Employee VALUES(@ID, @name, @salary, @start_time, @end_time, @complaint_no)
END

GO
/****** Object:  StoredProcedure [dbo].[MakeOffer]    Script Date: 09/12/2019 06:23:14 م ******/
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
	INSERT INTO Offer VALUES(@name, @type, @discount, @start_date, @end_date)
END

GO
