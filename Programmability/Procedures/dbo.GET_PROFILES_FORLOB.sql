SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_PROFILES_FORLOB]( @bucketid numeric)

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

	 SELECT  PROFILEID,[PROFILE_NAME],[OCCUPATION],
           [AGE],bucketid,PROFILE_IMAGE --,a.Created_By as username
     FROM [PROFILE_MSTR]
     where bucketid = @bucketid
     order by profileid;

	 select 'success' as msg	

	END TRY  	

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec [GET_PROFILES_FORLOB] 2
GO