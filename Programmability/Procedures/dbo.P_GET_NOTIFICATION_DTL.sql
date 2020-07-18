SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_NOTIFICATION_DTL]
(@imageid numeric
)
as 
BEGIN

declare @v_tagid numeric;

IF @imageid is null
BEGIN
select 'Imageid cannot be null' msg
END


select a.imageid, b.user_name as username, c.IMAGE_NAME, tag_desc, c.IMAGE_THUMB
from Recommend_Tag a, USER_ROLE_MSTR b, IMAGE_TBL c
where a.created_by = b.userid
and a.imageid = c.imageid
and a.imageid = @imageid
order by a.imageid;


 IF @@ROWCOUNT = 0 
 BEGIN
 select 'No Results Found' msg
 return
 END
 ELSE
 BEGIN
  select 'Success' msg
  return
 END

END

-- exec P_GET_NOTIFICATION_DTL 1
GO