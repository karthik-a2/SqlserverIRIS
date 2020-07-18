CREATE TABLE [dbo].[IMG_SEARCH] (
  [imageid] [numeric] NULL,
  [imagename] [varchar](50) NULL,
  [imagetag] [varchar](max) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO