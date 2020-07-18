SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GTG_ADD_TAG]
( @imageid numeric, 
  @p_tag dbo.tagarray READONLY )
as 
BEGIN

declare @v_tagid numeric;
declare @v_count numeric;
DECLARE @cnt INT = 0;
declare @tag_count numeric;

IF @imageid is null 
BEGIN
select 'IMAGEID or TAG CANNOT BE BLANK' msg
RETURN
END

select @v_count = count(1) from @p_tag;

IF @v_count = 0 
BEGIN
SELECT 'TAG CANNOT BE BLANK' 
RETURN
END
/*

*/

WHILE @cnt <= @v_count
BEGIN

select @tag_count = count(1) from  image_tag where tag_desc in ( select tag from @p_tag )
IF  @tag_count > 0
BEGIN
SELECT 'TAG Already Present' msg
BREAK
END

INSERT into IMAGE_TAG
 select NEXT VALUE FOR img_seq, @imageid, tag,getdate(), 'ADMIN' from @p_tag;
 set @cnt = @cnt +1
 select 'TAG Added Successfully' msg
 RETURN;
 
END
  

END

/*

create sequence img_seq
start with 10
increment by 1;
*/
/*
BEGIN
declare @p_tag dbo.tagarray 
insert @p_tag(tag) values('GD'),('GD2') 
EXEC  [dbo].[GTG_ADD_TAG]  1,  @p_tag
--delete from IMAGE_TAG where created_dt = '2020-06-17'
--select * from IMAGE_TAG where created_dt = '2020-06-17'
END

-- create array obj
CREATE TYPE dbo.tagarray -- tagarray
AS TABLE
(
  tag varchar(50)
);
@p_tag dbo.tagarray READONLY,
select tag FROM @p_tag; 
*/
GO