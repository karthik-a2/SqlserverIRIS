SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_IMAGES_FORBUCKETID]( @bucketid numeric)

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

   IF @bucketid is null 
   BEGIN
   select 'Bucketid cannot be blank'
   RETURN
   END


   SELECT [IMAGEID],[USERID],img.[BUCKETID],img.[PROFILEID]
      ,[IMAGE_NAME],[IMAGEH],[IMAGEM]
      ,[IMAGEL],[IMAGE_THUMB],PROFILE_NAME,OCCUPATION,AGE
     FROM IMAGE_TBL img
     inner join PROFILE_MSTR pro on img.PROFILEID = pro.PROFILEID
     where img.BUCKETID = @bucketid
     and hide_flg = 'N'
     order by img.PROFILEID;

	/*SELECT [IMAGEID],[USERID],[BUCKETID],[PROFILEID]
      ,[IMAGE_NAME],[IMAGEH],[IMAGEM]
      ,[IMAGEL],[IMAGE_THUMB]
     FROM IMAGE_TBL 
	 where BUCKETID = @bucketid
	 and hide_flg = 'N'
	 order by PROFILEID;
	 */
	 

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
-- exec [GET_IMAGES_FORBUCKETID] 1

--select * from IMAGE_TBL;
GO