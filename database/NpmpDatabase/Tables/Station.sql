CREATE TABLE [dbo].[Station]
(
    [StationId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Station_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Station_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [StationName] NVARCHAR(255) NOT NULL,
    [ReservoirId] INT NOT NULL,
    [City] NVARCHAR(255) NULL,
    [StateId] INT NOT NULL,
    [Latitude] DECIMAL(9, 6) NOT NULL,
    [Longitude] DECIMAL(9, 6) NOT NULL,
    CONSTRAINT [PK_Station] PRIMARY KEY CLUSTERED ([StationId]),
    CONSTRAINT [UQ_Station_ReservoirId_StationName] UNIQUE ([ReservoirId], [StationName]),
    CONSTRAINT [CK_Station_Latitude] CHECK ([Latitude] >= -90 AND [Latitude] <= 90),
    CONSTRAINT [CK_Station_Longitude] CHECK ([Longitude] >= -180 AND [Longitude] <= 180),
    CONSTRAINT [FK_Station_Reservoir] FOREIGN KEY ([ReservoirId]) REFERENCES [dbo].[Reservoir] ([ReservoirId]),
    CONSTRAINT [FK_Station_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[State] ([StateId])
);
GO
CREATE INDEX [IX_Station_StateId] ON [dbo].[Station] ([StateId]);
GO
CREATE TRIGGER [dbo].[TR_Station_SetUpdatedAt]
ON [dbo].[Station]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[Station]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[Station] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[StationId] = [Target].[StationId];
END;
