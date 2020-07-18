CREATE TABLE [dbo].[PROFILE_MSTR] (
  [PROFILEID] [numeric] NOT NULL,
  [BUCKETID] [numeric] NULL,
  [PROFILE_NAME] [varchar](50) NULL,
  [OCCUPATION] [varchar](50) NULL,
  [AGE] [varchar](50) NULL,
  [PROFILE_IMAGE] [image] NULL,
  [Created_dt] [datetime2] NULL,
  [Created_By] [varchar](50) NULL,
  [Updated_dt] [datetime2] NULL,
  [Updated_By] [varchar](50) NULL,
  CONSTRAINT [PK_PROFILE_MSTR] PRIMARY KEY CLUSTERED ([PROFILEID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO