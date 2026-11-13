CREATE TABLE [dbo].[OdfwMonitoringIncidentalCatch]
(
    [OdfwMonitoringIncidentalCatchId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_OdfwMonitoringIncidentalCatch_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_OdfwMonitoringIncidentalCatch_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [OdfwMonitoringSurveyId] INT NOT NULL,
    [SpeciesId] INT NOT NULL,
    [CatchCount] INT NOT NULL,
    CONSTRAINT [PK_OdfwMonitoringIncidentalCatch] PRIMARY KEY CLUSTERED ([OdfwMonitoringIncidentalCatchId]),
    CONSTRAINT [FK_OdfwMonitoringIncidentalCatch_OdfwMonitoringSurvey] FOREIGN KEY ([OdfwMonitoringSurveyId]) REFERENCES [dbo].[OdfwMonitoringSurvey] ([OdfwMonitoringSurveyId]),
    CONSTRAINT [FK_OdfwMonitoringIncidentalCatch_Species] FOREIGN KEY ([SpeciesId]) REFERENCES [dbo].[Species] ([SpeciesId]),
    CONSTRAINT [UQ_OdfwMonitoringIncidentalCatch_Survey_Species] UNIQUE ([OdfwMonitoringSurveyId], [SpeciesId]),
    CONSTRAINT [CK_OdfwMonitoringIncidentalCatch_CatchCount_Nonnegative] CHECK ([CatchCount] >= 0)
);
GO
CREATE INDEX [IX_OdfwMonitoringIncidentalCatch_SpeciesId] ON [dbo].[OdfwMonitoringIncidentalCatch] ([SpeciesId]);
GO
CREATE TRIGGER [dbo].[TR_OdfwMonitoringIncidentalCatch_SetUpdatedAt]
ON [dbo].[OdfwMonitoringIncidentalCatch]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[OdfwMonitoringIncidentalCatch]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[OdfwMonitoringIncidentalCatch] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[OdfwMonitoringIncidentalCatchId] = [Target].[OdfwMonitoringIncidentalCatchId];
END;
