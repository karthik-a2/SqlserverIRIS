CREATE TABLE [dbo].[IRIS_OTP_HIS] (
  [UID] [varchar](50) NULL,
  [OTP] [int] NULL,
  [USERID] [numeric] NULL,
  [IMAGEID] [numeric] NULL,
  [CREATE_TIME] [datetime] NULL,
  [EXPIRY_TIME] [datetime] NULL,
  [Created_DATE] [date] NULL,
  [MAX_SEQ_NUM] [int] NULL,
  [VERIFIED_FLG] [char](1) NULL,
  [REQUESTER_ID] [numeric] NULL,
  [RESOLUTION] [varchar](100) NULL
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[IRIS_OTP_HIS]
  ADD CONSTRAINT [FK_USERID_OTP_HIS] FOREIGN KEY ([USERID]) REFERENCES [dbo].[USER_ROLE_MSTR] ([USERID])
GO