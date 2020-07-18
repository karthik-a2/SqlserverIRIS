SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_PROFILES]( @profileid numeric)

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

   IF @profileid is null 
   BEGIN
   Select 'Profileid cannot be blank' msg
   RETURN
   END

	SELECT b.bucketid,[Bucket_Name],
	       PROFILEID, [PROFILE_NAME],OCCUPATION,
	       [AGE], PROFILE_IMAGE
     FROM [PROFILE_MSTR] a, BUCKET_MSTR b
	 where a.BUCKETID = b.BUCKETID
	 and PROFILEID = @profileid
	 order by profileid;

	 set @v_count =@@rowcount;

	 IF  @v_count = 0 
	 BEGIN
	 select 'No results Found'
	 RETURN
	 END
	 ELSE
	 BEGIN	 
	 select 'success' as msg	
	 RETURN
	 END
	END TRY  	

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec [P_GET_PROFILES] 1
GO