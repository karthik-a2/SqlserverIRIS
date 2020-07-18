SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[P_UPDT_ROLE]
  ( @P_ROLEID               numeric,
    @P_AddBrandAsset		char(1),
	@P_EditBrandAsset		char(1),
	@P_DeleteBrandAsset		char(1),
	@P_CreateFolder		    char(1),
	@P_EditFolder			char(1),
	@P_DeleteFolder			char(1),
	@P_AddUser				char(1),
	@P_EditUser				char(1),
	@P_DeleteUser			char(1),
	@P_AddRole              char(1),
	@P_EditRole             char(1),
	@P_DeleteRole           char(1),
	@P_RecommendTags        char(1),
	@P_ApproveTags          char(1),
	@P_AddTags              char(1),
	@P_Download_Low_Resol_Image    char(1),
	@P_Download_Med_Resol_Image    char(1),
	@P_Download_Hi_Resol_Image     char(1),
	@P_Download_Med_Resol_Image_with_Perm    char(1),
	@P_Download_Hi_Resol_Image_with_Perm    char(1),
	@P_Updated_by           numeric 
 )
as 
BEGIN

declare @v_count numeric;
declare @v_roleid numeric;
   BEGIN TRY

	IF @P_ROLEID is null 
	BEGIN
	select 'Role cannot be Blank' msg
	RETURN
	END	

	IF @P_AddBrandAsset is null or  @P_EditBrandAsset is null or  	@P_DeleteBrandAsset is null or  
	@P_CreateFolder is null or  	@P_EditFolder is null or  @P_DeleteFolder is null or  	
	@P_AddUser is null or  	@P_EditUser is null or  @P_DeleteUser is null or  
	@P_AddRole is null or  	@P_EditRole is null or  @P_DeleteRole is null or  
	@P_RecommendTags is null or  @P_ApproveTags is null or @P_AddTags is null or 
	@P_Updated_by is null or @P_Download_Low_Resol_Image    is null or 
	@P_Download_Med_Resol_Image   is null or @P_Download_Hi_Resol_Image    is null or 
	@P_Download_Med_Resol_Image_with_Perm   is null or @P_Download_Hi_Resol_Image_with_Perm is null

	BEGIN
	SELECT 'Permission cannot be blank' msg
	RETURN
	END 

UPDATE [dbo].[Role_Master]
   SET [AddBrandAsset] = @P_AddBrandAsset
      ,[EditBrandAsset] = @P_EditBrandAsset
      ,[DeleteBrandAsset] = @P_DeleteBrandAsset
      ,[CreateFolder] = @P_CreateFolder
      ,[EditFolder] = @P_EditFolder
      ,[DeleteFolder] = @P_DeleteFolder
      ,[AddUser] = @P_AddUser
      ,[EditUser] = @P_EditUser
      ,[DeleteUser] = @P_DeleteUser
      ,[AddRole] = @P_AddRole
      ,[EditRole] = @P_EditRole
      ,[DeleteRole] = @P_DeleteRole
      ,[RecommendTags] = @P_RecommendTags
      ,[ApproveTags] = @P_ApproveTags
      ,[AddTags] = @P_AddTags
	  ,Download_Low_Resol_Image = @P_Download_Low_Resol_Image
	  ,Download_Med_Resol_Image = @P_Download_Med_Resol_Image
	  ,Download_Hi_Resol_Image = @P_Download_Hi_Resol_Image
	  ,Download_Med_Resol_Image_with_Perm = @P_Download_Med_Resol_Image_with_Perm
	  ,Download_Hi_Resol_Image_with_Perm = @P_Download_Hi_Resol_Image_with_Perm
      ,[updated_dt] = getdate()
      ,[updated_by] = @P_Updated_by
   WHERE roleid = @P_ROLEID;	

	select 'Role Updated Successfully' msg
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END

-- exec [P_UPDT_ROLE] 4,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','N','N','Y','Y','Y','Y','Y',1
   
--select * from Role_Master;
GO