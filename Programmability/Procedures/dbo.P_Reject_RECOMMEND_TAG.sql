SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_Reject_RECOMMEND_TAG]
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
SELECT 'TAG CANNOT BE BLANK'  msg
RETURN
END

IF @userid is null
BEGIN
SELECT 'Userid CANNOT BE BLANK' msg
RETURN
END


BEGIN
delete from REcommend_TAG
where imageid = @imageid
and TAG_DESC = @p_TAG
and created_by = @userid

 

 select 'TAG Rejected Successfully' msg
 RETURN; 
END

END;

-- exec [P_Reject_RECOMMEND_TAG]  1, 'RED', 4
GO