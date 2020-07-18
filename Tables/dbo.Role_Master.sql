﻿CREATE TABLE [dbo].[Role_Master] (
  [RoleID] [numeric] NULL,
  [RoleName] [varchar](50) NULL,
  [AddBrandAsset] [char](1) NULL,
  [EditBrandAsset] [char](1) NULL,
  [DeleteBrandAsset] [char](1) NULL,
  [CreateFolder] [char](1) NULL,
  [EditFolder] [char](1) NULL,
  [DeleteFolder] [char](1) NULL,
  [AddUser] [char](1) NULL,
  [EditUser] [char](1) NULL,
  [DeleteUser] [char](1) NULL,
  [AddRole] [char](1) NULL,
  [EditRole] [char](1) NULL,
  [DeleteRole] [char](1) NULL,
  [RecommendTags] [char](1) NULL,
  [ApproveTags] [char](1) NULL,
  [AddTags] [char](1) NULL,
  [Download_Low_Resol_Image] [char](1) NULL,
  [Download_Med_Resol_Image] [char](1) NULL,
  [Download_Hi_Resol_Image] [char](1) NULL,
  [Download_Med_Resol_Image_with_Perm] [char](1) NULL,
  [Download_Hi_Resol_Image_with_Perm] [char](1) NULL,
  [created_dt] [datetime2] NULL,
  [created_by] [varchar](50) NULL,
  [updated_dt] [datetime2] NULL,
  [updated_by] [varchar](50) NULL
)
ON [PRIMARY]
GO