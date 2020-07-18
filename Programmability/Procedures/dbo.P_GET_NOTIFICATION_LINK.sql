SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_NOTIFICATION_LINK]

as 
BEGIN

declare @v_tagid numeric;

/*
select TOP 3 a.imageid, b.user_name as username, c.IMAGE_NAME, tag_desc
from Recommend_Tag a, USER_ROLE_MSTR b, IMAGE_TBL c
where a.created_by = b.userid
and a.imageid = c.imageid
order by a.created_dt desc;
*/



SELECT 'There is a new Tag recommendation from '+b.user_name +
' for the '+ c.IMAGE_NAME +' Picture to add ' + '"' + tag_desc +'"' +' as a tag.' as OUTPUT, a.imageid as imageid
from Recommend_Tag a, USER_ROLE_MSTR b, IMAGE_TBL c
where a.created_by = b.userid
and a.imageid = c.imageid
order by a.imageid;


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

-- exec P_GET_NOTIFICATION_LINK
GO