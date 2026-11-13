CREATE TABLE [dbo].[FishedLocation]
(
    [FishedLocationId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_FishedLocation_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_FishedLocation_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [Code] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_FishedLocation] PRIMARY KEY CLUSTERED ([FishedLocationId]),
    CONSTRAINT [UQ_FishedLocation_Code] UNIQUE ([Code])
);
GO
CREATE TRIGGER [dbo].[TR_FishedLocation_SetUpdatedAt]
ON [dbo].[FishedLocation]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[FishedLocation]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[FishedLocation] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[FishedLocationId] = [Target].[FishedLocationId];
END;
