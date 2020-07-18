SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_ADD_Bucket]
( @p_bucketname varchar(50),
  @p_bucketimage varchar(max),
  @p_userid numeric
 )
as 
BEGIN

declare @v_count numeric;
declare @v_bucketid numeric;

   BEGIN TRY

	IF @p_bucketname is null or @p_bucketimage is null or @p_userid is null
	BEGIN
	select 'BucketName or Image cannot be Blank' msg
	RETURN
	END

	
	select @v_count = count(1) from BUCKET_MSTR
	where bucket_name = @p_bucketname;

	
	IF @v_count >0 
	BEGIN
	select 'Name Already Present' msg
	return;
	END
	
	IF @v_count =0
	BEGIN
	select @v_bucketid = isnull(max(bucketid),0)+1 from BUCKET_MSTR;

	insert into BUCKET_MSTR
	values( @v_bucketid, upper(@p_bucketname), @p_bucketimage, getdate(),@p_userid );
	select @v_bucketid Bucketid, 'Bucket Added Successfully' msg
	RETURN
	END
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END


-- 
--exec P_ADD_Bucket 'NewBucket4', 'c:\bucket.jpg', 1


--select * from bucket_mstr;
GO