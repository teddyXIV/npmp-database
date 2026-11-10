CREATE TABLE [dbo].[WdfwSrfCatch]
(
    [WdfwSrfCatchId] INT IDENTITY(1,1) NOT NULL,
    [SpeciesId] INT NOT NULL,
    [CaughtCount] INT NOT NULL,
    [ReleasedCount] INT NOT NULL,
    [SrfQualifyingCount] INT NULL,
    [WdfwSrfTripId] INT NOT NULL,
    CONSTRAINT [PK_WdfwSrfCatch] PRIMARY KEY CLUSTERED ([WdfwSrfCatchId]),
    CONSTRAINT [FK_WdfwSrfCatch_Species] FOREIGN KEY ([SpeciesId]) REFERENCES [dbo].[Species] ([SpeciesId]),
    CONSTRAINT [FK_WdfwSrfCatch_WdfwSrfTrip] FOREIGN KEY ([WdfwSrfTripId]) REFERENCES [dbo].[WdfwSrfTrip] ([WdfwSrfTripId]),
    CONSTRAINT [UQ_WdfwSrfCatch_Trip_Species] UNIQUE ([WdfwSrfTripId], [SpeciesId]),
    CONSTRAINT [CK_WdfwSrfCatch_CaughtCount_Nonnegative] CHECK ([CaughtCount] >= 0),
    CONSTRAINT [CK_WdfwSrfCatch_ReleasedCount_Nonnegative] CHECK ([ReleasedCount] >= 0),
    CONSTRAINT [CK_WdfwSrfCatch_ReleasedCount_NotGreaterThanCaughtCount] CHECK ([ReleasedCount] <= [CaughtCount]),
    CONSTRAINT [CK_WdfwSrfCatch_SrfQualifyingCount_Valid] CHECK ([SrfQualifyingCount] IS NULL OR ([SrfQualifyingCount] >= 0 AND [SrfQualifyingCount] <= [CaughtCount]))
);
GO
CREATE INDEX [IX_WdfwSrfCatch_SpeciesId] ON [dbo].[WdfwSrfCatch] ([SpeciesId]);
