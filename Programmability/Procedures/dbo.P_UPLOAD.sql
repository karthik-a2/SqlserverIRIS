SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:           <Author,,Name>
-- Create date: <Create Date,,>
-- Description:      <Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_UPLOAD]
(@P_USERID    numeric, 
 @P_BUCKETID  numeric,
 @P_PROFILEID numeric,
 @IMAGE_NAME  varchar(100), 
 @IMAGEH      varchar(max),
 @IMAGEM      varchar(max),
 @IMAGEL      varchar(max), 
 @IMAGE_THUMB image,
 @p_tag dbo.tagarray READONLY
 )

 AS
BEGIN
BEGIN TRY

DECLARE @SUC VARCHAR(50);
declare @v_count numeric;
declare @V_IMAGEID numeric;
declare @v_tagid numeric;

 SET NOCOUNT ON;


IF @P_USERID is null or @P_PROFILEID is null
BEGIN
select 'userid/profileid cannot be blank' as msg
RETURN;
END


IF @IMAGEL is null or @IMAGEH is null or @IMAGEL is null
BEGIN
SELECT 'IMAGE NOT SELECTED' as MSG
RETURN
END;


SELECT @v_count = count(1) from USER_ROLE_MSTR
where userid = @P_USERID;

IF @v_count = 0
BEGIN
select 'INVALID USERID' as msg
RETURN
END

select @V_IMAGEID = isnull(max(imageid),0)+1 from image_tbl;


-- Insert INTO IMAGE TABLE
INSERT INTO IMAGE_TBL 
values(@V_IMAGEID, @P_USERID,@P_BUCKETID, @P_PROFILEID, @IMAGE_NAME,
@IMAGEH, @IMAGEM, @IMAGEL,@IMAGE_THUMB, 'N',getdate(), 'ADMIN')
 
-- Insert into TAG Table

EXEC  [dbo].[ADD_TAG]  @V_IMAGEID, @P_USERID, @p_tag


SELECT 'Uploaded Successfully' as msg2

END TRY


BEGIN CATCH

   SELECT ERROR_NUMBER() as ErrorNumber,
         Error_Message() as ErrorMessage  
	 
   select 'Oops!!!!! Something went wrong!!!!! Contact System DBA' as MSG

END CATCH;

/*
CREATE TYPE dbo.tagarray -- tagarray
AS TABLE
(
  tag varchar(50)
);
@p_tag dbo.tagarray READONLY,
select tag FROM @p_tag; 
*/

END;


/*

BEGIN
declare @p_tag dbo.tagarray 
insert @p_tag(tag) values('SKY'),('SUN'),('RAIN') 
--EXEC  [dbo].[ADD_TAG]  1,  @p_tag
exec [dbo].[P_UPLOAD] 1,1, 1,'NATURE','C:\img.jpg','C:\img.jpg','C:\img.jpg',null,@p_tag
--delete from IMAGE_TAG where created_dt = '2020-06-16'
--select * from IMAGE_TAG where created_dt = '2020-06-16'
--select * from image_tbl;

--delete from image_tbl where imageid = 3;
END

 */
GO