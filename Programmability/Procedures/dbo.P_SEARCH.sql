SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_SEARCH] ( @bucketid numeric, @TAG varchar(50))
as 
BEGIN

BEGIN TRY

IF @TAG IS NULL or @TAG = ''
BEGIN
select 'INVALID SEARCH'
RETURN
END

IF @bucketid <> 0 
BEGIN
select  distinct a.IMAGEID, IMAGE_NAME,IMAGEH, IMAGEM, IMAGEL, TAG_DESC
,cast(IMAGE_THUMB as varbinary(max)) as IMAGE_THUMB
from IMAGE_TBL a, IMAGE_TAG b
where a.imageid = b.imageid
and a.BUCKETID =@bucketid
and b.TAG_DESC like '%'+@TAG +'%' 
or a.IMAGE_NAME like '%'+@TAG +'%' 
RETURN
END
ELSE  -- For All Bucket Including
BEGIN
select distinct a.IMAGEID, IMAGE_NAME,IMAGEH, IMAGEM, IMAGEL, TAG_DESC
,cast(IMAGE_THUMB as varbinary(max)) IMAGE_THUMB
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


/*
--Adding tag to imageid

select * from img_search where imagetag like '%jasm%'

select * from img_search where imagetag like '%'+@TAG +'' 
-- Add tag proc
update img_search
set imagetag = imagetag + ' ' + 'SUNFLOWER' 
where imageid = @imageid -- imageid input parameter
*/
END

--exec P_SEARCH 0,'hou'
GO