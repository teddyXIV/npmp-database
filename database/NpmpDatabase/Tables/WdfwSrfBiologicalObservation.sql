CREATE TABLE [dbo].[WdfwSrfBiologicalObservation]
(
    [WdfwSrfBiologicalObservationId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_WdfwSrfBiologicalObservation_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_WdfwSrfBiologicalObservation_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [SpeciesId] INT NOT NULL,
    [ForkLengthMillimeters] INT NULL,
    [PitTagCode] NVARCHAR(255) NULL,
    [ExternalTagTypeId] INT NULL,
    [TagColorId] INT NULL,
    [SexId] INT NULL,
    [WdfwSrfTripId] INT NOT NULL,
    CONSTRAINT [PK_WdfwSrfBiologicalObservation] PRIMARY KEY CLUSTERED ([WdfwSrfBiologicalObservationId]),
    CONSTRAINT [FK_WdfwSrfBiologicalObservation_Species] FOREIGN KEY ([SpeciesId]) REFERENCES [dbo].[Species] ([SpeciesId]),
    CONSTRAINT [FK_WdfwSrfBiologicalObservation_TagType] FOREIGN KEY ([ExternalTagTypeId]) REFERENCES [dbo].[TagType] ([TagTypeId]),
    CONSTRAINT [FK_WdfwSrfBiologicalObservation_TagColor] FOREIGN KEY ([TagColorId]) REFERENCES [dbo].[TagColor] ([TagColorId]),
    CONSTRAINT [FK_WdfwSrfBiologicalObservation_Sex] FOREIGN KEY ([SexId]) REFERENCES [dbo].[Sex] ([SexId]),
    CONSTRAINT [FK_WdfwSrfBiologicalObservation_WdfwSrfTrip] FOREIGN KEY ([WdfwSrfTripId]) REFERENCES [dbo].[WdfwSrfTrip] ([WdfwSrfTripId]),
    CONSTRAINT [CK_WdfwSrfBiologicalObservation_ForkLength_Positive] CHECK ([ForkLengthMillimeters] IS NULL OR [ForkLengthMillimeters] > 0)
);
GO
CREATE INDEX [IX_WdfwSrfBiologicalObservation_SpeciesId] ON [dbo].[WdfwSrfBiologicalObservation] ([SpeciesId]);
GO
CREATE INDEX [IX_WdfwSrfBiologicalObservation_ExternalTagTypeId] ON [dbo].[WdfwSrfBiologicalObservation] ([ExternalTagTypeId]);
GO
CREATE INDEX [IX_WdfwSrfBiologicalObservation_TagColorId] ON [dbo].[WdfwSrfBiologicalObservation] ([TagColorId]);
GO
CREATE INDEX [IX_WdfwSrfBiologicalObservation_SexId] ON [dbo].[WdfwSrfBiologicalObservation] ([SexId]);
GO
CREATE INDEX [IX_WdfwSrfBiologicalObservation_WdfwSrfTripId] ON [dbo].[WdfwSrfBiologicalObservation] ([WdfwSrfTripId]);
GO
CREATE TRIGGER [dbo].[TR_WdfwSrfBiologicalObservation_SetUpdatedAt]
ON [dbo].[WdfwSrfBiologicalObservation]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[WdfwSrfBiologicalObservation]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[WdfwSrfBiologicalObservation] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[WdfwSrfBiologicalObservationId] = [Target].[WdfwSrfBiologicalObservationId];
END;
