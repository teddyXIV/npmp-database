CREATE TABLE [dbo].[WdfwDaCatch]
(
    [WdfwDaCatchId] INT IDENTITY(1,1) NOT NULL,
    [WdfwDaReportId] INT NOT NULL,
    [SpeciesId] INT NOT NULL,
    [CatchCount] INT NOT NULL,
    CONSTRAINT [PK_WdfwDaCatch] PRIMARY KEY CLUSTERED ([WdfwDaCatchId]),
    CONSTRAINT [FK_WdfwDaCatch_WdfwDaReport] FOREIGN KEY ([WdfwDaReportId]) REFERENCES [dbo].[WdfwDaReport] ([WdfwDaReportId]),
    CONSTRAINT [FK_WdfwDaCatch_Species] FOREIGN KEY ([SpeciesId]) REFERENCES [dbo].[Species] ([SpeciesId]),
    CONSTRAINT [UQ_WdfwDaCatch_Report_Species] UNIQUE ([WdfwDaReportId], [SpeciesId]),
    CONSTRAINT [CK_WdfwDaCatch_CatchCount_Nonnegative] CHECK ([CatchCount] >= 0)
);
GO
CREATE INDEX [IX_WdfwDaCatch_SpeciesId] ON [dbo].[WdfwDaCatch] ([SpeciesId]);
