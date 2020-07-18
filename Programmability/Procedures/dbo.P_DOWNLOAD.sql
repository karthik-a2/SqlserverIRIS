SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_DOWNLOAD] ( @IMAGEID numeric, @userid numeric)
as 
BEGIN

declare @v_roleid numeric;
declare @v_count numeric;

IF @IMAGEID IS NULL 
BEGIN
select 'INVALID IMAGE'
RETURN
END

IF @userid IS NULL 
BEGIN
select 'INVALID Userid'
RETURN
END

 --select @v_roleid = ROLEID 
 --from USER_ROLE_MSTR
 --where userid = @userid 

 --select @v_count =  count(1) 
 --from Role_Master
 --where roleid = @v_roleid
 --and [Download_Low_Resol_Image] = 'Y'
 --and [Download_Med_Resol_Image]= 'Y'
 --and [Download_Hi_Resol_Image]= 'Y' 
 
 --IF @v_count = 0 
 --BEGIN
 --select 'Access Denied to Download' msg
 --RETURN
 --END;


 select IMAGEID, BUCKETID, PROFILEID, USERID, IMAGE_NAME,
		IMAGEH, IMAGEM, IMAGEL, IMAGE_THUMB
		from IMAGE_TBL 
		where imageid = @IMAGEID;

    insert into RECENT_DOWNLOAD
	select distinct a.imageid, a.userid, user_name, rolename, getdate()
	from image_tbl a, USER_ROLE_MSTR b, role_master c
	where a.USERID= b.USERID
	and b.ROLEID = c.ROLEID
	and a.imageid = @IMAGEID;


IF @@ROWCOUNT = 0 
BEGIN
select 'No Results Found' as msg
RETURN
END

select 'Success! You image has been downloaded successfully' as msg
return

END

--exec [P_DOWNLOAD] 3,4

--select * from USER_ROLE_MSTR;
--select * from role_master;
GO