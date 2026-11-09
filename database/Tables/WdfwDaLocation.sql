CREATE TABLE [dbo].[WdfwDaLocation]
(
    [WdfwDaLocationId] INT IDENTITY(1,1) NOT NULL,
    [LocationName] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_WdfwDaLocation] PRIMARY KEY CLUSTERED ([WdfwDaLocationId]),
    CONSTRAINT [UQ_WdfwDaLocation_LocationName] UNIQUE ([LocationName])
);
