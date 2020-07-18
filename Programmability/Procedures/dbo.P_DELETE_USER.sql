SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_DELETE_USER]
( @p_userid numeric
 )
as 
BEGIN

   BEGIN TRY

	IF @p_userid is null 
	BEGIN
	select 'Userid cannot be Blank' msg
	RETURN
	END	

	delete from IRIS_OTP_HIS
	where userid = @p_userid

	delete from IRIS_LOGIN
	where userid = @p_userid;

	delete from USER_ROLE_MSTR
	where userid = @p_userid
	select 'Deleted Successfully' msg
	RETURN;
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END


-- exec P_DELETE_USER 5

--select * from user_role_mstr;
-- select * from iris_otp_his;
-- select * from IRIS_LOGIN ;
GO