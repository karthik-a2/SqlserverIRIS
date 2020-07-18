SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_GET_ROLES]
as
BEGIN

BEGIN TRY

select roleid, rolename,[AddBrandAsset],[EditBrandAsset],[DeleteBrandAsset],[CreateFolder]
      ,[EditFolder],[DeleteFolder],[AddUser],[EditUser],[DeleteUser],[AddRole],[EditRole]
      ,[DeleteRole],[RecommendTags],[ApproveTags],[AddTags],[Download_Low_Resol_Image]
      ,[Download_Med_Resol_Image]
      ,[Download_Hi_Resol_Image]
      ,[Download_Med_Resol_Image_with_Perm]
      ,[Download_Hi_Resol_Image_with_Perm]
	  from role_master;

/*
select roleid, rolename,[AddBrandAsset],[EditBrandAsset],[DeleteBrandAsset],[CreateFolder]
      ,[EditFolder],[DeleteFolder],[AddUser],[EditUser],[DeleteUser],[AddRole],[EditRole]
      ,[DeleteRole],[RecommendTags],[ApproveTags],[AddTags] 
	  from ( select *
from role_master
pivot
( max(created_by)
for created_by in ( created)
) as tab 
) d
order by roleid;

*/

select 'Success' as msg

END TRY

BEGIN CATCH
 SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
END CATCH
END

--exec P_GET_ROLES
GO