USE [Cyber_Cafe]
GO
/****** Object:  StoredProcedure [dbo].[Insert_Offer_Customer]    Script Date: 12/14/2019 2:46:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Insert_Tournament_participant]    Script Date: 12/14/2019 2:46:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[InsertintoFeedback]    Script Date: 12/14/2019 2:46:44 PM ******/
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
	Values (@date , @cid , @description,@type)
END
GO
/****** Object:  StoredProcedure [dbo].[View_Available_offers]    Script Date: 12/14/2019 2:46:44 PM ******/
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
	SELECT * FROM Offer WHERE @reg_date >= [start_date] AND @reg_date <= [end_date]
END
GO
/****** Object:  StoredProcedure [dbo].[View_Available_Tournaments]    Script Date: 12/14/2019 2:46:44 PM ******/
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
	SELECT * from Tournament where status = 'ongoing';
END
GO
