SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_TAGS_AUTOCOMPLETE]( @bucketid numeric, @TAG varchar(50))

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

   IF @bucketid <> 0 
	BEGIN
	select  distinct  TAG_DESC
	from IMAGE_TBL a, IMAGE_TAG b
	where a.imageid = b.imageid
	and a.BUCKETID =@bucketid
	and b.TAG_DESC like '%'+@TAG +'%' 
	or a.IMAGE_NAME like '%'+@TAG +'%' 
	RETURN
	END
	ELSE  -- For All Bucket Including
	BEGIN
	select distinct TAG_DESC
	from IMAGE_TBL a, IMAGE_TAG b
	where a.imageid = b.imageid
	and b.TAG_DESC like '%'+@TAG +'%' 
	or a.IMAGE_NAME like '%'+@TAG +'%' 
	RETURN
	END

	IF @@ROWCOUNT = 0 
	BEGIN
	select 'No Results Found' as msg
	RETURN
	END

	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
GO