SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE  [dbo].[P_LOGIN]
(@P_USERID VARCHAR(100), 
 @P_PWD varchar(100)
 )


 AS
BEGIN
BEGIN TRY

DECLARE @SUC VARCHAR(50);
declare @v_count numeric;

 SET NOCOUNT ON;


IF @P_USERID is null or @P_PWD is null
BEGIN
select 'userid/password cannot be blank' as msg
RETURN;
END

SELECT @v_count = count(1) from IRIS_LOGIN
where email_id = @P_USERID and password = @P_PWD;

IF @v_count = 1 
BEGIN
select  'Success' as msg;
RETURN;
END
ELSE
BEGIN
select  'INVALID USERID OR PASSWORD' as msg;
RETURN;
END;

END TRY


BEGIN CATCH

   SELECT ERROR_NUMBER() as ErrorNumber,
         Error_Message() as ErrorMessage  
	 
   select 'Oops!!!!! Something went wrong!!!!! Contact System DBA' as MSG

END CATCH;

END;

--select * from IRIS_LOGIN;
--exec P_LOGIN 'admin@gmail.com', '1c7662bfda30b5b9d3872d3d057924c61221922a';

--select getdate()-5
GO