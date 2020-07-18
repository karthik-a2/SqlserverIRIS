SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE  [dbo].[P_VERIFY_OTP]
(@P_USER numeric,
@OTP int,
@IMAGEID numeric,
@OUTMSG VARCHAR(50) OUT,
@SUCCESS  VARCHAR (50) OUT
)

 AS
BEGIN
DECLARE @RES VARCHAR(50);
DECLARE @UID VARCHAR(50);
DECLARE @SUC VARCHAR(50);
DECLARE @EXPCNT INT;
DECLARE @VCNT INT;
declare @exptime datetime;

IF(@OTP ='')
BEGIN 
SET @OUTMSG= 'OTP CANNOT BE BLANK'
SET @SUCCESS='0';
RETURN
END

IF  (TRY_CAST (@OTP AS int) IS NULL)
BEGIN 
SET @OUTMSG= 'INVALID OTP '
SET @SUCCESS='0';
RETURN
END



      SELECT @EXPCNT = count(1) FROM IRIS_OTP_HIS 
		WHERE requester_id = @P_USER AND OTP = @OTP and imageid =@IMAGEID
		AND cast(EXPIRY_TIME as datetime) > cast(GETDATE() as datetime)


	    IF @EXPCNT > 0
        BEGIN
		
		update IRIS_OTP_HIS set VERIFIED_FLG ='Y'
		WHERE requester_id = @P_USER AND OTP = @OTP and imageid =@IMAGEID
		AND cast(EXPIRY_TIME as datetime) > cast(GETDATE() as datetime)
		SET @OUTMSG =  'OTP VERIFIED' 
		SET @SUCCESS= '1';
		END

			             
       SELECT @EXPCNT=COUNT(1) FROM IRIS_OTP_HIS 
		WHERE requester_id = @P_USER AND OTP = @OTP and imageid =@IMAGEID AND EXPIRY_TIME < GETDATE();

        IF @EXPCNT = 1
        BEGIN
                SET @OUTMSG = 'OTP EXPIRED' 
				SET @SUCCESS='0';
        END 

		IF @OUTMSG is null and @SUCCESS is null
		BEGIN 
		SET @OUTMSG = 'OTP INVALID' 
				SET @SUCCESS='0';
		END 

		
END

/*
declare @OUTMSG varchar(50) 
DECLARE @SUCCESS VARCHAR(50)
EXEC [P_VERIFY_OTP]  3, 346265,1, @OUTMSG output,@SUCCESS output
select @outmsg MSG,@success status

-- select * from iris_otp_his;

SELECT COUNT(1) FROM IRIS_OTP_HIS 
		WHERE UID = 1 AND OTP = 443162 AND EXPIRY_TIME > GETDATE();

		*/
GO