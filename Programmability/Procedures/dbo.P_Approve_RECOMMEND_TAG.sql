SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_Approve_RECOMMEND_TAG]
( @imageid numeric, 
  @p_TAG varchar(100),
  @userid varchar(50))
as 
BEGIN

declare @v_tagid numeric;
declare @v_count numeric;
declare @rcount numeric;
DECLARE @cnt INT = 0;
declare @tag_count numeric;

IF @imageid is null 
BEGIN
select 'IMAGEID Cannot BE BLANK' msg
RETURN
END


IF @p_TAG is null or @p_TAG = ''
BEGIN
SELECT 'TAG CANNOT BE BLANK' 
RETURN
END

select @tag_count = count(1) from  image_tag where tag_desc = @p_TAG
and imageid = @imageid
IF  @tag_count > 0
BEGIN
SELECT 'TAG Already Present' msg
RETURN;
END

BEGIN
update REcommend_TAG
set Tag_ADDED_FLG = 'Y'
where imageid = @imageid
and TAG_DESC = @p_TAG

 select @v_tagid = isnull(max(tagid),0)+1  from image_tag; 

 insert into IMAGE_TAG values ( @v_tagid, @imageid, @p_TAG, getdate(), @userid)

 

 select 'TAG Approved Successfully' msg
 RETURN; 
END

END;

-- exec [P_Approve_RECOMMEND_TAG]  1, 'GREEN', 1
GO