SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_ADD_RECOMMEND_TAG]
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
select 'IMAGEID or TAG CANNOT BE BLANK' msg
RETURN
END


IF @p_TAG is null or @p_TAG = ''
BEGIN
SELECT 'TAG CANNOT BE BLANK' 
RETURN
END

select @tag_count = count(1) 
from  image_tag 
where tag_desc = @p_TAG 
and imageid = @imageid;

select @rcount = count(1)
from Recommend_Tag
where tag_desc = @p_TAG 
and imageid = @imageid;

IF  @tag_count > 0 or @rcount >0
BEGIN
SELECT 'TAG Already Present' msg
RETURN;
END

IF  @tag_count =0
BEGIN
INSERT into REcommend_TAG
 values(@imageid, upper(@p_TAG),'N',getdate(),@userid )

 select 'TAG Recommended Successfully' msg
 RETURN; 
END

END;

-- exec P_RECOMMEND_TAG 1, 'HOUSE', 1
GO