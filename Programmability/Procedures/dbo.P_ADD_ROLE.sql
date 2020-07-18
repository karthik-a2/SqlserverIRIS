SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_ADD_ROLE]
  ( @P_ROLENAME				varchar(50),
    @P_AddBrandAsset		varchar(50),
	@P_EditBrandAsset		char(1),
	@P_DeleteBrandAsset		char(1),
	@P_CreateFolder			 char(1),
	@P_EditFolder			 char(1),
	@P_DeleteFolder			 char(1),
	@P_AddUser				 char(1),
	@P_EditUser				 char(1),
	@P_DeleteUser			 char(1),
	@P_AddRole               char(1),
	@P_EditRole              char(1),
	@P_DeleteRole            char(1),
	@P_RecommendTags         char(1),
	@P_ApproveTags           char(1),
	@P_AddTags               char(1),
	@P_Download_Low_Resol_Image    char(1),
	@P_Download_Med_Resol_Image    char(1),
	@P_Download_Hi_Resol_Image     char(1),
	@P_Download_Med_Resol_Image_with_Perm    char(1),
	@P_Download_Hi_Resol_Image_with_Perm    char(1),
	@P_created_by            numeric 
 )
as 
BEGIN

declare @v_count numeric;
declare @v_roleid numeric;
   BEGIN TRY

	IF @P_ROLENAME is null 
	BEGIN
	select 'Role cannot be Blank' msg
	RETURN
	END	
	
	select @v_roleid =  isnull(max(roleid),0)+1 from Role_Master;

	insert into Role_Master
	values( @v_roleid, @P_ROLENAME,@P_AddBrandAsset, @P_EditBrandAsset,
	@P_DeleteBrandAsset,@P_CreateFolder,@P_EditFolder,
	@P_DeleteFolder,@P_AddUser,	@P_EditUser, @P_DeleteUser, @P_AddRole,
	@P_EditRole, @P_DeleteRole, @P_RecommendTags, @P_ApproveTags, @P_AddTags,
	@P_Download_Low_Resol_Image, 
	@P_Download_Med_Resol_Image,
	@P_Download_Hi_Resol_Image,
	@P_Download_Med_Resol_Image_with_Perm,
	@P_Download_Hi_Resol_Image_with_Perm,
	getdate(), @P_created_by,null, null);
	select 'Role Added Successfully' msg
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END

-- exec [P_ADD_ROLE] 'ABPartner3','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y',1
   
--select * from Role_Master;
GO