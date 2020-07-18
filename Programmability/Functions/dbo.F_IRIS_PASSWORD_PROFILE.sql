SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[F_IRIS_PASSWORD_PROFILE]
 (@PWD VARCHAR(50)) 
 RETURNS CHAR
BEGIN
DECLARE @MATCH CHAR(1)

	SELECT @MATCH = CASE WHEN 
        @PWD COLLATE Latin1_General_BIN LIKE '%[a-z]%' AND
        @PWD COLLATE Latin1_General_BIN LIKE '%[A-Z]%' AND
        @PWD LIKE '%[0-9]%' AND
        @PWD LIKE '%[~!@#$%^&]%' AND
        LEN(@PWD) >= 8 AND
		@PWD NOT LIKE '% %'
    THEN 1 ELSE 0 END 

 	RETURN @MATCH
END

--SELECT F_IRIS_PASSWORD_PROFILE('Abc@1234')
GO