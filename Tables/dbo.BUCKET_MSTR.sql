CREATE TABLE [dbo].[BUCKET_MSTR] (
  [BUCKETID] [numeric] NOT NULL,
  [Bucket_Name] [varchar](50) NULL,
  [Bucket_Image] [varchar](max) NULL,
  [created_dt] [datetime2] NULL,
  [created_by] [varchar](50) NULL,
  CONSTRAINT [PK_BUCKET_MSTR] PRIMARY KEY CLUSTERED ([BUCKETID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO