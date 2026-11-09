CREATE TABLE [dbo].[OdfwMonitoringSurvey]
(
    [OdfwMonitoringSurveyId] INT IDENTITY(1,1) NOT NULL,
    [ReservoirId] INT NOT NULL,
    [SurveyDate] DATE NOT NULL,
    [SurveyStartTime] TIME(0) NULL,
    [SurveyEndTime] TIME(0) NULL,
    [SurveyEffort] INT NULL,
    CONSTRAINT [PK_OdfwMonitoringSurvey] PRIMARY KEY CLUSTERED ([OdfwMonitoringSurveyId]),
    CONSTRAINT [FK_OdfwMonitoringSurvey_Reservoir] FOREIGN KEY ([ReservoirId]) REFERENCES [dbo].[Reservoir] ([ReservoirId]),
    CONSTRAINT [CK_OdfwMonitoringSurvey_Effort_Nonnegative] CHECK ([SurveyEffort] IS NULL OR [SurveyEffort] >= 0),
    CONSTRAINT [CK_OdfwMonitoringSurvey_TimeRange] CHECK ([SurveyStartTime] IS NULL OR [SurveyEndTime] IS NULL OR [SurveyEndTime] > [SurveyStartTime])
);
GO
CREATE INDEX [IX_OdfwMonitoringSurvey_ReservoirId] ON [dbo].[OdfwMonitoringSurvey] ([ReservoirId]);
CREATE INDEX [IX_OdfwMonitoringSurvey_SurveyDate] ON [dbo].[OdfwMonitoringSurvey] ([SurveyDate]);
