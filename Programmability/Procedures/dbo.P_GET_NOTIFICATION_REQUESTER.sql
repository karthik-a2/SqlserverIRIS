SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_NOTIFICATION_REQUESTER]
(@userid numeric)

as 
BEGIN

declare @v_tagid numeric;

IF @userid is null
BEGIN
select 'Userid cannot be blank' msg
RETURN
END


select 'Your request to download High Resolution picture of '+ '"'+c.IMAGE_NAME + '"'
+ ' is yet to be approved.' as OUTPUT, a.imageid as imageid
from IRIS_OTP_HIS a, IMAGE_TBL c
where a.imageid = c.imageid
and a.requester_id = @userid
and a.VERIFIED_FLG = 'N'
and c.HIDE_FLG = 'N'
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

-- exec [P_GET_NOTIFICATION_REQUESTER] 3
--select * from IRIS_OTP_HIS;
--select * from IMAGE_TBL;
GO