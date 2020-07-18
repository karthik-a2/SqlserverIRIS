SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[GET_OTP_NOTIF]

as 
BEGIN

declare @v_count numeric;
   BEGIN TRY	

	select a.USERID, a.IMAGEID, IMAGE_NAME, IMAGE_THUMB, requester_id
	from IRIS_OTP_HIS a, IMAGE_TBL b
	where a.imageid = b.imageid
	and  verified_flg = 'N'
	order by a.IMAGEID
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END
-- exec [GET_OTP_NOTIF]
GO