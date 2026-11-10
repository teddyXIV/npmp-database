CREATE TABLE [dbo].[FishedLocation]
(
    [FishedLocationId] INT IDENTITY(1,1) NOT NULL,
    [Code] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_FishedLocation] PRIMARY KEY CLUSTERED ([FishedLocationId]),
    CONSTRAINT [UQ_FishedLocation_Code] UNIQUE ([Code])
);
