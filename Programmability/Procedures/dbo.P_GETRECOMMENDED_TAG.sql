SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GETRECOMMENDED_TAG]
( @imageid numeric
  )
as 
BEGIN

declare @v_tagid numeric;

IF @imageid is null 
BEGIN
select 'IMAGEID CANNOT BE BLANK' msg
RETURN
END

select imageid, tag_desc, b.user_name as username
from Recommend_Tag a, USER_ROLE_MSTR b
where a.created_by = b.userid
and imageid = @imageid
and Tag_ADDED_FLG = 'N';

 IF @@ROWCOUNT = 0 
 BEGIN
 select 'No Results Found' msg
 return
 END
 ELSE
 BEGIN
  select 'Success' msg
 END

END;

-- exec P_GETRECOMMENDED_TAG 1
GO