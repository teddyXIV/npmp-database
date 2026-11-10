CREATE TABLE [dbo].[WdfwSrfTrip]
(
    [WdfwSrfTripId] INT IDENTITY(1,1) NOT NULL,
    [WdfwSrfDailyRegistrationId] INT NOT NULL,
    CONSTRAINT [PK_WdfwSrfTrip] PRIMARY KEY CLUSTERED ([WdfwSrfTripId]),
    CONSTRAINT [FK_WdfwSrfTrip_WdfwSrfDailyRegistration] FOREIGN KEY ([WdfwSrfDailyRegistrationId]) REFERENCES [dbo].[WdfwSrfDailyRegistration] ([WdfwSrfDailyRegistrationId])
);
GO
CREATE INDEX [IX_WdfwSrfTrip_WdfwSrfDailyRegistrationId] ON [dbo].[WdfwSrfTrip] ([WdfwSrfDailyRegistrationId]);
