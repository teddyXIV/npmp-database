CREATE TABLE [dbo].[Reach]
(
    [ReachId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Reach_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Reach_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [ReachCode] NVARCHAR(50) NOT NULL,
    [CommonName] NVARCHAR(255) NULL,
    CONSTRAINT [PK_Reach] PRIMARY KEY CLUSTERED ([ReachId]),
    CONSTRAINT [UQ_Reach_ReachCode] UNIQUE ([ReachCode])
);
GO
CREATE TRIGGER [dbo].[TR_Reach_SetUpdatedAt]
ON [dbo].[Reach]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[Reach]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[Reach] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[ReachId] = [Target].[ReachId];
END;
