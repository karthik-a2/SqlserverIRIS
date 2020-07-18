SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_TAG]
( @imageid numeric
 )
as 
BEGIN

declare @v_count numeric;
   BEGIN TRY

	IF @imageid is null 
	BEGIN
	select 'IMAGEID Invalid' msg
	RETURN
	END

	select TAG_DESC from IMAGE_TAG
	where IMAGEID = @imageid	
  
    IF @@ROWCOUNT = 0
	BEGIN
	Select 'NO TAGS Present' msg
	END
	ELSE
	BEGIN
	Select 'success' msg
	END  
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec get_tag 1
GO