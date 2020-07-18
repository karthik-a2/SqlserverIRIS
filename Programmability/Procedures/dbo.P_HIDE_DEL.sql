SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_HIDE_DEL]
( @OPR_FLG char(1),                     -- 'H' for Hide   'D' for Delete operation
  @p_imageid dbo.imageidarray READONLY )
as 
BEGIN

declare @v_tagid numeric;
declare @v_count numeric;
DECLARE @cnt INT = 0;
declare @tag_count numeric;

	IF @OPR_FLG is null 
	BEGIN
	select 'Operation Cannot be blank ' msg
	RETURN
	END

	select @v_count = count(1) from @p_imageid;

	IF @v_count = 0 
	BEGIN
	SELECT 'Imageid Cannot be Blank' 
	RETURN
	END

	IF @OPR_FLG = 'H'
	BEGIN
	update IMAGE_TBL
	set HIDE_FLG = 'Y'
	where imageid in ( select imageid from @p_imageid);
	select 'Image Hide Success' msg
	RETURN;
	END

	IF @OPR_FLG = 'D'
	BEGIN
	delete from IMAGE_TAG
	where imageid in ( select imageid from @p_imageid);

	delete from IMAGE_TBL
	where imageid in ( select imageid from @p_imageid);
	select 'Image Delete Success' msg
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
declare @p_imageid dbo.imageidarray
insert @p_imageid(imageid) values(1),(2) 
EXEC  [dbo].[P_HIDE_DEL]  'H',  @p_imageid
--delete from IMAGE_TAG where created_dt = '2020-06-18'
--select * from IMAGE_TAG where created_dt = '2020-06-18'
END


-- create array obj
CREATE TYPE dbo.imageidarray -- imageidarray
AS TABLE
(
  imageid numeric
);
@p_tag dbo.tagarray READONLY,
select tag FROM @p_tag; 
*/
GO