CREATE TABLE [dbo].[IRIS_LOGIN] (
  [UID] [numeric] NOT NULL,
  [userid] [numeric] NULL,
  [EMAIL_ID] [varchar](100) NULL,
  [password] [varchar](100) NULL,
  [CREATED_DT] [datetime] NULL,
  [CREATED_BY] [varchar](50) NULL,
  [UPDATED_DT] [datetime] NULL,
  [UPDATED_BY] [varchar](50) NULL,
  CONSTRAINT [PK_IRIS_LOGIN] PRIMARY KEY CLUSTERED ([UID])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[IRIS_LOGIN]
  ADD CONSTRAINT [FK_IRIS_LOGIN_USERID] FOREIGN KEY ([userid]) REFERENCES [dbo].[USER_ROLE_MSTR] ([USERID])
GO