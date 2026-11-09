CREATE TABLE [dbo].[WdfwDaReport]
(
    [WdfwDaReportId] INT IDENTITY(1,1) NOT NULL,
    [WeekEndingDate] DATE NOT NULL,
    [WdfwDaLocationId] INT NOT NULL,
    [EffortHours] INT NULL,
    CONSTRAINT [PK_WdfwDaReport] PRIMARY KEY CLUSTERED ([WdfwDaReportId]),
    CONSTRAINT [FK_WdfwDaReport_WdfwDaLocation] FOREIGN KEY ([WdfwDaLocationId]) REFERENCES [dbo].[WdfwDaLocation] ([WdfwDaLocationId]),
    CONSTRAINT [CK_WdfwDaReport_EffortHours_Nonnegative] CHECK ([EffortHours] IS NULL OR [EffortHours] >= 0)
);
GO
CREATE INDEX [IX_WdfwDaReport_WdfwDaLocationId] ON [dbo].[WdfwDaReport] ([WdfwDaLocationId]);
GO
CREATE UNIQUE INDEX [UQ_WdfwDaReport_Location_WeekEndingDate] ON [dbo].[WdfwDaReport] ([WdfwDaLocationId], [WeekEndingDate]);
GO