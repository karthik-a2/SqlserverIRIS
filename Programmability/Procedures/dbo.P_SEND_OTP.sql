SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE  [dbo].[P_SEND_OTP]
(@P_USERID numeric,
 @p_imageid numeric,
 @P_REQUESTER_ID numeric,
 @p_resolution varchar(100)
 )

 AS
BEGIN
BEGIN TRY
DECLARE @RES VARCHAR(50);
DECLARE @UID VARCHAR(50) = 1;
DECLARE @SUC VARCHAR(50);



   --EXEC  [dbo].[P_DMS_VERIFY_USER] @P_USER,@USER_MODE,@RES OUTPUT, @UID OUTPUT,@SUC OUTPUT

  -- IF @RES= 'USER VERIFIED'

     SET NOCOUNT ON;
       DECLARE @CNT INT;
       DECLARE @Random INT;
       DECLARE @Upper INT;
       DECLARE @Lower INT
       DECLARE @seq int
       DECLARE @otpcnt int
       DECLARE @reccnt int
       DECLARE @pcnt int
	   DECLARE @p1cnt int
	   DECLARE @VEMAIL varchar(100);
       
       set @CNT = 0;  
	   if (@P_USERID = 0)
	     Set @P_USERID =(select top 1 userid from IRIS_OTP_HIS where Requester_Id=@P_REQUESTER_ID and Resolution = @p_resolution  and VERIFIED_FLG ='N' order by 1 desc )

  select @CNT = count(1), @VEMAIL = EMAIL_ID from USER_ROLE_MSTR
  where userid = @P_USERID
  group by EMAIL_ID;

  IF @P_USERID is null or @CNT = 0
  BEGIN
  select 'Invalid userid' as msg
  RETURN
  END


	---- This will create a random number between 1 and 999
	SET @Lower = 111111 ---- The lowest random number
	SET @Upper = 999999 ---- The highest random number
	otplabel:
	SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)


select @otpcnt = count(1) from IRIS_OTP_HIS where uid = @P_USERID and @Random in
(select otp from 
(select otp, row_number() over (order by create_time desc) as rownum from IRIS_OTP_HIS where uid = @P_USERID) a 
where rownum < 4)


if @otpcnt > 0
Begin  
       goto otplabel 
End

select @seq = isnull(max(max_seq_num),0) + 1 from IRIS_OTP_HIS where uid = @P_USERID

select @CNT = isnull(max(uid),0)+1 from IRIS_OTP_HIS;


INSERT INTO IRIS_OTP_HIS values (@CNT, @Random, @P_USERID, @p_imageid,getdate(), dateadd(hour,24,getdate()), getdate(),@seq,'N',@P_REQUESTER_ID,@p_resolution )

select  'true' success,CONVERT(VARCHAR,@Random)  otp ,'OTP Generated Successfully' msg,@VEMAIL EMAIL

END TRY


BEGIN CATCH

   SELECT ERROR_NUMBER() as ErrorNumber,
         Error_Message() as ErrorMessage
  
   select 'Oops!!!!! Something went wrong!!!!! Contact System DBA' msg;

END CATCH;

END;

--exec P_SEND_OTP 3, 1, 3, 'IMAGEH';
-- select * from iris_otp_his;
GO