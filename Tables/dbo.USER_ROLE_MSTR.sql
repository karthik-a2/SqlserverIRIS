CREATE TABLE [dbo].[USER_ROLE_MSTR] (
  [USERID] [numeric] NOT NULL,
  [ROLEID] [numeric] NULL,
  [USER_NAME] [varchar](50) NULL,
  [EMAIL_ID] [varchar](100) NULL,
  [created_dt] [datetime2] NULL,
  [created_by] [varchar](50) NULL,
  CONSTRAINT [PK_USER_ROLE] PRIMARY KEY CLUSTERED ([USERID])
)
ON [PRIMARY]
GO