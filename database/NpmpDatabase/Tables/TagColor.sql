CREATE TABLE [dbo].[TagColor]
(
    [TagColorId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_TagColor_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_TagColor_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [TagColorCode] NVARCHAR(50) NOT NULL,
    [TagColorName] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_TagColor] PRIMARY KEY CLUSTERED ([TagColorId]),
    CONSTRAINT [UQ_TagColor_TagColorCode] UNIQUE ([TagColorCode]),
    CONSTRAINT [UQ_TagColor_TagColorName] UNIQUE ([TagColorName])
);
GO
CREATE TRIGGER [dbo].[TR_TagColor_SetUpdatedAt]
ON [dbo].[TagColor]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[TagColor]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[TagColor] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[TagColorId] = [Target].[TagColorId];
END;
