SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_USERS]

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY
    select userid, USER_NAME, EMAIL_id, ROLENAME ,a.ROLEID
	from USER_ROLE_MSTR a, ROLE_MASTER b
	where a.ROLEID = b.RoleID 
	order by 1;
	Select 'success' msg;
	RETURN   
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec P_GET_USERS
GO