CREATE TABLE [dbo].[Species]
(
    [SpeciesId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Species_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Species_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [CommonName] NVARCHAR(255) NOT NULL,
    [ScientificName] NVARCHAR(255) NULL,
    CONSTRAINT [PK_Species] PRIMARY KEY CLUSTERED ([SpeciesId]),
    CONSTRAINT [UQ_Species_CommonName] UNIQUE ([CommonName])
);
GO
CREATE UNIQUE INDEX [UQ_Species_ScientificName]
    ON [dbo].[Species] ([ScientificName])
    WHERE [ScientificName] IS NOT NULL;
GO
CREATE TRIGGER [dbo].[TR_Species_SetUpdatedAt]
ON [dbo].[Species]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[Species]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[Species] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[SpeciesId] = [Target].[SpeciesId];
END;
