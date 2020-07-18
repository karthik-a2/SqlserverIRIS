SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- =============================================
-- Author:           <Author,,Name>
-- Create date: <Create Date,,>
-- Description:      <Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_GET_EMAILIDS]


 AS
BEGIN
BEGIN TRY


  select userid,EMAIL_ID from USER_ROLE_MSTR
  order by EMAIL_ID; 
  select 'Success' as msg


END TRY


BEGIN CATCH

   SELECT ERROR_NUMBER() as ErrorNumber,
         Error_Message() as ErrorMessage
  
   select 'Oops!!!!! Something went wrong!!!!! Contact System DBA' msg;

END CATCH;

END;

--exec [P_GET_EMAILIDS] ;
GO