CREATE TABLE [dbo].[OdfwMonitoringSurvey]
(
    [OdfwMonitoringSurveyId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_OdfwMonitoringSurvey_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_OdfwMonitoringSurvey_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
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
GO
CREATE INDEX [IX_OdfwMonitoringSurvey_SurveyDate] ON [dbo].[OdfwMonitoringSurvey] ([SurveyDate]);
GO
CREATE TRIGGER [dbo].[TR_OdfwMonitoringSurvey_SetUpdatedAt]
ON [dbo].[OdfwMonitoringSurvey]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[OdfwMonitoringSurvey]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[OdfwMonitoringSurvey] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[OdfwMonitoringSurveyId] = [Target].[OdfwMonitoringSurveyId];
END;
