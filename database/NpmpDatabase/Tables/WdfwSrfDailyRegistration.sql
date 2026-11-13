CREATE TABLE [dbo].[WdfwSrfDailyRegistration]
(
    [WdfwSrfDailyRegistrationId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_WdfwSrfDailyRegistration_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_WdfwSrfDailyRegistration_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [RegistrationDate] DATE NOT NULL,
    [StationId] INT NOT NULL,
    CONSTRAINT [PK_WdfwSrfDailyRegistration] PRIMARY KEY CLUSTERED ([WdfwSrfDailyRegistrationId]),
    CONSTRAINT [FK_WdfwSrfDailyRegistration_Station] FOREIGN KEY ([StationId]) REFERENCES [dbo].[Station] ([StationId])
);
GO
CREATE INDEX [IX_WdfwSrfDailyRegistration_StationId] ON [dbo].[WdfwSrfDailyRegistration] ([StationId]);
GO
CREATE INDEX [IX_WdfwSrfDailyRegistration_RegistrationDate] ON [dbo].[WdfwSrfDailyRegistration] ([RegistrationDate]);
GO
CREATE TRIGGER [dbo].[TR_WdfwSrfDailyRegistration_SetUpdatedAt]
ON [dbo].[WdfwSrfDailyRegistration]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[WdfwSrfDailyRegistration]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[WdfwSrfDailyRegistration] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[WdfwSrfDailyRegistrationId] = [Target].[WdfwSrfDailyRegistrationId];
END;
