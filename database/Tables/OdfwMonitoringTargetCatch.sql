CREATE TABLE [dbo].[OdfwMonitoringTargetCatch]
(
    [OdfwMonitoringTargetCatchId] INT IDENTITY(1,1) NOT NULL,
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
CREATE INDEX [IX_OdfwMonitoringTargetCatch_SpeciesId] ON [dbo].[OdfwMonitoringTargetCatch] ([SpeciesId]);
CREATE INDEX [IX_OdfwMonitoringTargetCatch_ExternalTagTypeId] ON [dbo].[OdfwMonitoringTargetCatch] ([ExternalTagTypeId]);
CREATE INDEX [IX_OdfwMonitoringTargetCatch_TagColorId] ON [dbo].[OdfwMonitoringTargetCatch] ([TagColorId]);
