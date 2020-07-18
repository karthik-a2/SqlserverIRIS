SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_IMAGES_FORPROFILE]( @profileid numeric)

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

	SELECT [IMAGEID],[USERID],[BUCKETID],[PROFILEID]
      ,[IMAGE_NAME],[IMAGEH],[IMAGEM]
      ,[IMAGEL],[IMAGE_THUMB]
     FROM IMAGE_TBL b
	 where profileid = @profileid
	 and hide_flg = 'N'
	 order by profileid;
	 select 'success' as msg	

	END TRY  	

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec [GET_IMAGES_FORPROFILE] 1
GO