CREATE TABLE [dbo].[OdfwMonitoringTargetCatch]
(
    [OdfwMonitoringTargetCatchId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_OdfwMonitoringTargetCatch_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_OdfwMonitoringTargetCatch_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [OdfwMonitoringSurveyId] INT NOT NULL,
    [SpeciesId] INT NOT NULL,
    [ForkLengthMillimeters] INT NULL,
    [WeightGrams] DECIMAL(10,2) NULL,
    [ExternalTagCode] NVARCHAR(255) NULL,
    [PitTagCode] NVARCHAR(255) NULL,
    [ExternalTagTypeId] INT NULL,
    [TagColorId] INT NULL,
    CONSTRAINT [PK_OdfwMonitoringTargetCatch] PRIMARY KEY CLUSTERED ([OdfwMonitoringTargetCatchId]),
    CONSTRAINT [FK_OdfwMonitoringTargetCatch_OdfwMonitoringSurvey] FOREIGN KEY ([OdfwMonitoringSurveyId]) REFERENCES [dbo].[OdfwMonitoringSurvey] ([OdfwMonitoringSurveyId]),
    CONSTRAINT [FK_OdfwMonitoringTargetCatch_Species] FOREIGN KEY ([SpeciesId]) REFERENCES [dbo].[Species] ([SpeciesId]),
    CONSTRAINT [FK_OdfwMonitoringTargetCatch_TagType] FOREIGN KEY ([ExternalTagTypeId]) REFERENCES [dbo].[TagType] ([TagTypeId]),
    CONSTRAINT [FK_OdfwMonitoringTargetCatch_TagColor] FOREIGN KEY ([TagColorId]) REFERENCES [dbo].[TagColor] ([TagColorId]),
    CONSTRAINT [CK_OdfwMonitoringTargetCatch_ForkLength_Positive] CHECK ([ForkLengthMillimeters] IS NULL OR [ForkLengthMillimeters] > 0),
    CONSTRAINT [CK_OdfwMonitoringTargetCatch_Weight_Positive] CHECK ([WeightGrams] IS NULL OR [WeightGrams] > 0)
);
GO
CREATE INDEX [IX_OdfwMonitoringTargetCatch_SurveyId] ON [dbo].[OdfwMonitoringTargetCatch] ([OdfwMonitoringSurveyId]);
GO
CREATE INDEX [IX_OdfwMonitoringTargetCatch_SpeciesId] ON [dbo].[OdfwMonitoringTargetCatch] ([SpeciesId]);
GO
CREATE INDEX [IX_OdfwMonitoringTargetCatch_ExternalTagTypeId] ON [dbo].[OdfwMonitoringTargetCatch] ([ExternalTagTypeId]);
GO
CREATE INDEX [IX_OdfwMonitoringTargetCatch_TagColorId] ON [dbo].[OdfwMonitoringTargetCatch] ([TagColorId]);
GO
CREATE TRIGGER [dbo].[TR_OdfwMonitoringTargetCatch_SetUpdatedAt]
ON [dbo].[OdfwMonitoringTargetCatch]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[OdfwMonitoringTargetCatch]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[OdfwMonitoringTargetCatch] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[OdfwMonitoringTargetCatchId] = [Target].[OdfwMonitoringTargetCatchId];
END;
