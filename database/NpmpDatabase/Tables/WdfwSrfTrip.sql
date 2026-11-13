CREATE TABLE [dbo].[WdfwSrfTrip]
(
    [WdfwSrfTripId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_WdfwSrfTrip_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_WdfwSrfTrip_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [WdfwSrfDailyRegistrationId] INT NOT NULL,
    [FishedLocationId] INT NULL,
    CONSTRAINT [PK_WdfwSrfTrip] PRIMARY KEY CLUSTERED ([WdfwSrfTripId]),
    CONSTRAINT [FK_WdfwSrfTrip_WdfwSrfDailyRegistration] FOREIGN KEY ([WdfwSrfDailyRegistrationId]) REFERENCES [dbo].[WdfwSrfDailyRegistration] ([WdfwSrfDailyRegistrationId]),
    CONSTRAINT [FK_WdfwSrfTrip_FishedLocation] FOREIGN KEY ([FishedLocationId]) REFERENCES [dbo].[FishedLocation] ([FishedLocationId])
);
GO
CREATE INDEX [IX_WdfwSrfTrip_WdfwSrfDailyRegistrationId] ON [dbo].[WdfwSrfTrip] ([WdfwSrfDailyRegistrationId]);
GO
CREATE INDEX [IX_WdfwSrfTrip_FishedLocationId] ON [dbo].[WdfwSrfTrip] ([FishedLocationId]);
GO
CREATE TRIGGER [dbo].[TR_WdfwSrfTrip_SetUpdatedAt]
ON [dbo].[WdfwSrfTrip]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[WdfwSrfTrip]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[WdfwSrfTrip] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[WdfwSrfTripId] = [Target].[WdfwSrfTripId];
END;
