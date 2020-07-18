SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_RECENT_DOWNLOAD] ( @IMAGEID numeric)
as 
BEGIN

IF @IMAGEID IS NULL 
BEGIN
select 'INVALID IMAGE'
RETURN
END

 select distinct IMAGEID, userid, username, role_desc, created_dt
		from recent_download 
		where imageid = @IMAGEID
		order by created_dt desc;


IF @@ROWCOUNT = 0 
BEGIN
select 'No Results Found' as msg
RETURN
END

select 'Success' as msg
return

END

--exec P_GET_RECENT_DOWNLOAD 3
GO