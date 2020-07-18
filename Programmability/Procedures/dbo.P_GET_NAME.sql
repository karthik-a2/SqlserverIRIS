SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_NAME]
( @id numeric,
  @Mstr_name varchar(50)
 )
as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

	IF @Mstr_name is null 
	BEGIN
	select 'Invalid Details' msg
	RETURN
	END

	IF @Mstr_name = 'PROFILE'
	BEGIN
	Select profile_name as Name from PROFILE_MSTR
	where profileid = @id;
	RETURN
	select 'GetProfile Name Success' msg
	END

	IF @Mstr_name = 'BUCKET'
	BEGIN
	Select Bucket_Name as Name from BUCKET_MSTR
	where bucketid = @id;
	RETURN
	select 'GetBucket Name Success' msg
	END

	IF @Mstr_name = 'IMAGE'
	BEGIN
	Select image_Name as Name from IMAGE_TBL
	where imageid = @id;
	RETURN
	select 'GetImage Name Success' msg
	END

	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec [P_GET_NAME] 2, 'IMAGE'
GO