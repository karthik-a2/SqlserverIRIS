SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_IMAGES_FORIMGID]( @imageid numeric)

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

   IF @imageid is null 
   BEGIN
   select 'Imageid cannot be blank'
   RETURN
   END

	SELECT [IMAGEID],[USERID],[BUCKETID],[PROFILEID]
      ,[IMAGE_NAME],[IMAGEH],[IMAGEM]
      ,[IMAGEL],[IMAGE_THUMB]
     FROM IMAGE_TBL b
	 where imageid = @imageid
	 and hide_flg = 'N'
	 order by imageid;
	 

	 SELECT @v_count = @@ROWCOUNT

	 IF @v_count = 0 
	 BEGIN
	 select 'No results found' msg
	 RETURN
	 END
	 ELSE
	 BEGIN
	 select 'success' as msg	
	 END


	END TRY  	

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec GET_IMAGES_FORIMGID 244
GO