CREATE TABLE [dbo].[TagType]
(
    [TagTypeId] INT IDENTITY(1,1) NOT NULL,
    [TagTypeCode] NVARCHAR(50) NOT NULL,
    [TagTypeName] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_TagType] PRIMARY KEY CLUSTERED ([TagTypeId]),
    CONSTRAINT [UQ_TagType_TagTypeCode] UNIQUE ([TagTypeCode]),
    CONSTRAINT [UQ_TagType_TagTypeName] UNIQUE ([TagTypeName])
);
