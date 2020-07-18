SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_LOB]

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

	SELECT [BUCKETID]
      ,[Bucket_Name]
      ,[Bucket_Image]
     FROM [BUCKET_MSTR]
	 select 'success' as msg
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec get_tag 1
GO