SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_ROLE_LIST]

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY
    select roleid, ROLENAME from role_master;
	Select 'success' msg;
	RETURN   
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec P_GET_ROLE_LIST
GO