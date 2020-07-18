SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_USERS_ROLES]( @emailid varchar(50))

as 
BEGIN

declare @v_count numeric;

   BEGIN TRY
   IF @emailid is null
   BEGIN
   select 'Userid Cannot be blank' msg;
   RETURN;
   END

   select * from USER_ROLE_MSTR um 
   inner join Role_Master rm 
   on rm.RoleID = um.ROLEID 
   where EMAIL_ID =@emailid
	Select 'success' msg;
	RETURN   
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec [P_GET_USERS_ROLES] 'admin@gmail.com'
GO