SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[P_UPDT_USER_ROLE]

( @p_userid numeric,
  @p_roleid numeric
 )
as 
BEGIN


   BEGIN TRY

	IF @p_userid is null or @p_roleid is null 
	BEGIN
	select 'Userid or role cannot be Blank' msg
	RETURN
	END	

	Update USER_ROLE_MSTR
	set roleid = @p_roleid
	where userid = @p_userid
	select 'Updated Successfully' msg
	RETURN;
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END


-- exec P_UPDT_USER_ROLE 1, 2

--select * from user_role_mstr;
GO