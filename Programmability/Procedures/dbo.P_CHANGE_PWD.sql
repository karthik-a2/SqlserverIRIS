SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:           <Author,,Name>
-- Create date: <Create Date,,>
-- Description:      <Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_CHANGE_PWD]
(@P_USER_EMAILID VARCHAR(100),
 @NEW_PWD varchar(100),
 @CONF_PWD VARCHAR(100)
 )

 AS
BEGIN
BEGIN TRY

DECLARE @SUC VARCHAR(50);
declare @v_count numeric;

 SET NOCOUNT ON;


IF @P_USER_EMAILID is null or @NEW_PWD is null
BEGIN
select 'userid/password cannot be blank' as msg
RETURN
END
-- Checking newpassword and confirm password whether they are equal or not
IF @NEW_PWD <> @CONF_PWD
BEGIN
SELECT 'NEW PASSWORD AND CONFIRM PASSWORD FIELDS DO NOT MATCH'
RETURN
END

IF (@P_USER_EMAILID = @NEW_PWD OR @P_USER_EMAILID = @CONF_PWD)
BEGIN
	select  'User ID and the Password cannot be the same' msg
	return
END

ELSE IF (charindex('PASSWORD',upper(@NEW_PWD)) > 0 OR CHARINDEX('PASSWORD',upper(@CONF_PWD)) > 0)
BEGIN
		select 'Password cannot contain the word password' msg
		return
END

ELSE IF (@NEW_PWD = @P_USER_EMAILID OR @CONF_PWD = @P_USER_EMAILID)
BEGIN
		select 'Password cannot contain the username as password' msg
		return
END

SELECT @v_count = count(1) from IRIS_LOGIN
where EMAIL_ID = @P_USER_EMAILID;

	IF @v_count > 0 
	BEGIN

	--   IF dbo.F_IRIS_PASSWORD_PROFILE(@NEW_PWD) = 1
	  --  BEGIN

		update IRIS_LOGIN
		set password = @NEW_PWD,
		    updated_dt = getdate(),
			updated_by = 'admin'
		where EMAIL_ID = @P_USER_EMAILID
		
		select  'Successfully Changed Password' as msg;
		return;
	/*	END
		ELSE
		BEGIN
		select 'Password does not meet password policy' as msg;
		RETURN
		END */
	END
	ELSE
		BEGIN
		select  'INVALID USERID' as msg;
		END;
		RETURN;

END TRY

BEGIN CATCH

   SELECT ERROR_NUMBER() as ErrorNumber,
         Error_Message() as ErrorMessage  
	 
   select 'Oops!!!!! Something went wrong!!!!! Contact System DBA' as MSG

END CATCH;

END;

--select * from IRIS_LOGIN;
--exec P_CHANGE_PWD 'otheruser@gmail.com', 'pass#123', 'pass#123';
--select  dbo.F_IRIS_PASSWORD_PROFILE('ABCc@2020')
GO