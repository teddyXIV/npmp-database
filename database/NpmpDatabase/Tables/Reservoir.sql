CREATE TABLE [dbo].[Reservoir]
(
    [ReservoirId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Reservoir_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Reservoir_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [ReservoirCode] NVARCHAR(50) NOT NULL,
    [ReservoirName] NVARCHAR(255) NOT NULL,
    [ReachId] INT NOT NULL,
    CONSTRAINT [PK_Reservoir] PRIMARY KEY CLUSTERED ([ReservoirId]),
    CONSTRAINT [UQ_Reservoir_ReservoirCode] UNIQUE ([ReservoirCode]),
    CONSTRAINT [FK_Reservoir_Reach] FOREIGN KEY ([ReachId]) REFERENCES [dbo].[Reach] ([ReachId])
);
GO
CREATE INDEX [IX_Reservoir_ReachId] ON [dbo].[Reservoir] ([ReachId]);
GO
CREATE TRIGGER [dbo].[TR_Reservoir_SetUpdatedAt]
ON [dbo].[Reservoir]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[Reservoir]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[Reservoir] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[ReservoirId] = [Target].[ReservoirId];
END;
