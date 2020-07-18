CREATE TABLE [dbo].[webpages_Roles] (
  [RoleId] [int] IDENTITY,
  [RoleName] [nvarchar](256) NOT NULL,
  PRIMARY KEY CLUSTERED ([RoleId]),
  UNIQUE ([RoleName])
)
ON [PRIMARY]
GO