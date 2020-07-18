SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[UPDT_PROFILE]
( @p_profileid numeric,
  @p_profilename varchar(50),
  @p_occupation varchar(50),
  @p_age varchar(50),
  @p_userid numeric,
  @p_profileImage varchar(500)
 )
as 
BEGIN

declare @v_count numeric;
declare @v_profileid numeric;
   BEGIN TRY

	IF @p_profileid is null or @p_profilename is null or @p_occupation is null or @p_age is null 
	BEGIN
	select 'Mandatory fields cannot be Blank' msg
	RETURN
	END
	
	update PROFILE_MSTR
	set PROFILE_NAME = @p_profilename,
	    OCCUPATION = @p_occupation,
		age = @p_age,
		PROFILE_IMAGE = @p_profileImage,
		updated_dt = getdate(),
		updated_by = @p_userid
     where profileid = @p_profileid
	
	select 'Profile Updated Successfully' msg
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec UPDT_PROFILE 7,'profile4', 'occupation4', '29 & 33'

--select * from PROFILE_MSTR;
GO