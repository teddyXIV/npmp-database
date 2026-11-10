CREATE TABLE [dbo].[Reservoir]
(
    [ReservoirId] INT IDENTITY(1,1) NOT NULL,
    [ReservoirCode] NVARCHAR(50) NOT NULL,
    [ReservoirName] NVARCHAR(255) NOT NULL,
    [ReachId] INT NOT NULL,
    CONSTRAINT [PK_Reservoir] PRIMARY KEY CLUSTERED ([ReservoirId]),
    CONSTRAINT [UQ_Reservoir_ReservoirCode] UNIQUE ([ReservoirCode]),
    CONSTRAINT [FK_Reservoir_Reach] FOREIGN KEY ([ReachId]) REFERENCES [dbo].[Reach] ([ReachId])
);
GO
CREATE INDEX [IX_Reservoir_ReachId] ON [dbo].[Reservoir] ([ReachId]);
