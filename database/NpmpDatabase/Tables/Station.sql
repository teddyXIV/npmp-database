CREATE TABLE [dbo].[Station]
(
    [StationId] INT IDENTITY(1,1) NOT NULL,
    [StationName] NVARCHAR(255) NOT NULL,
    [ReservoirId] INT NOT NULL,
    [City] NVARCHAR(255) NULL,
    [StateId] INT NOT NULL,
    CONSTRAINT [PK_Station] PRIMARY KEY CLUSTERED ([StationId]),
    CONSTRAINT [UQ_Station_ReservoirId_StationName] UNIQUE ([ReservoirId], [StationName]),
    CONSTRAINT [FK_Station_Reservoir] FOREIGN KEY ([ReservoirId]) REFERENCES [dbo].[Reservoir] ([ReservoirId]),
    CONSTRAINT [FK_Station_State] FOREIGN KEY ([StateId]) REFERENCES [dbo].[State] ([StateId])
);
GO
CREATE INDEX [IX_Station_StateId] ON [dbo].[Station] ([StateId]);
