SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[ADD_PROFILE]
( @p_profilename varchar(50),
  @p_occupation varchar(50),
  @p_age varchar(50),
  @p_bucketid numeric,
  @p_userid numeric,
  @p_profile_image image
 )
as 
BEGIN
declare @v_count1 numeric;
declare @v_count numeric;
declare @v_profileid numeric;
   BEGIN TRY

	IF @p_profilename is null 
	BEGIN
	select 'Profile cannot be Blank' msg
	RETURN
	END

	
	
	select @v_count = count(1) from PROFILE_MSTR
	where profile_Name = @p_profilename;

	IF @v_count >0 
	BEGIN
	select 'Profile Name already Present' msg
	return;
	END
	ELSE
	BEGIN
	select @v_profileid = isnull(max(profileid),0)+1 from PROFILE_MSTR;

	insert into PROFILE_MSTR
	values( @v_profileid,@p_bucketid, @p_profilename, @p_occupation, @p_age,
	        @p_profile_image, getdate(), @p_userid,null, null);
	select @v_profileid profileid, 'Profile Added Successfully' msg
	END
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec add_profile 'profile1', 'occupation4', '28 & 32',1, 1,null

--select * from PROFILE_MSTR;
GO