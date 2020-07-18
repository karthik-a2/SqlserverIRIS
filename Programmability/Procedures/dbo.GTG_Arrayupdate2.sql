SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GTG_Arrayupdate2] 
@p_seqid dbo.seqid_arr2 READONLY,
@status nvarchar
      
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
 
   /*   update ekyc_details2
      set status = @status
      where seq_id in ( select seqid FROM @p_seqid ); */

	  insert into insert_array 
	  select seqid FROM @p_seqid;

	  -- same for delete
	  -- delete from insert_array where namearray in (select seqid from @p_seqid)
 
 
 
/*
 
drop type dbo.seqid_arr
CREATE TYPE dbo.seqid_arr2 -- you can be more speciifc here
AS TABLE
(
  seqid varchar(30)
);

create table insert_array
(
namearray varchar(30)
)


-- Execute array proc
BEGIN
DECLARE @p_seqid dbo.seqid_arr2
 
insert @p_seqid(seqid) values('GTG'),('SAMUEL')
 
EXEC  [dbo].[GTG_Arrayupdate2]     @p_seqid, 'NULL'
--select * from insert_array

END

 
*/

 
  
END
GO