CREATE TABLE [dbo].[TagColor]
(
    [TagColorId] INT IDENTITY(1,1) NOT NULL,
    [TagColorCode] NVARCHAR(50) NOT NULL,
    [TagColorName] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_TagColor] PRIMARY KEY CLUSTERED ([TagColorId]),
    CONSTRAINT [UQ_TagColor_TagColorCode] UNIQUE ([TagColorCode]),
    CONSTRAINT [UQ_TagColor_TagColorName] UNIQUE ([TagColorName])
);
