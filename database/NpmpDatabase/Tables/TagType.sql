CREATE TABLE [dbo].[TagType]
(
    [TagTypeId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_TagType_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_TagType_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [TagTypeCode] NVARCHAR(50) NOT NULL,
    [TagTypeName] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_TagType] PRIMARY KEY CLUSTERED ([TagTypeId]),
    CONSTRAINT [UQ_TagType_TagTypeCode] UNIQUE ([TagTypeCode]),
    CONSTRAINT [UQ_TagType_TagTypeName] UNIQUE ([TagTypeName])
);
GO
CREATE TRIGGER [dbo].[TR_TagType_SetUpdatedAt]
ON [dbo].[TagType]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[TagType]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[TagType] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[TagTypeId] = [Target].[TagTypeId];
END;
