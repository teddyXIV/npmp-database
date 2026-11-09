CREATE TABLE [dbo].[WdfwSrfDailyRegistration]
(
    [WdfwSrfDailyRegistrationId] INT IDENTITY(1,1) NOT NULL,
    [RegistrationDate] DATE NOT NULL,
    [StationId] INT NOT NULL,
    CONSTRAINT [PK_WdfwSrfDailyRegistration] PRIMARY KEY CLUSTERED ([WdfwSrfDailyRegistrationId]),
    CONSTRAINT [FK_WdfwSrfDailyRegistration_Station] FOREIGN KEY ([StationId]) REFERENCES [dbo].[Station] ([StationId])
);
GO
CREATE INDEX [IX_WdfwSrfDailyRegistration_StationId] ON [dbo].[WdfwSrfDailyRegistration] ([StationId]);
CREATE INDEX [IX_WdfwSrfDailyRegistration_RegistrationDate] ON [dbo].[WdfwSrfDailyRegistration] ([RegistrationDate]);
