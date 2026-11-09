CREATE TABLE [dbo].[WdfwDaCatchDetail]
(
    [WdfwDaCatchDetailId] INT IDENTITY(1,1) NOT NULL,
    [WdfwDaCatchId] INT NOT NULL,
    [UndersizedCount] INT NULL,
    CONSTRAINT [PK_WdfwDaCatchDetail] PRIMARY KEY CLUSTERED ([WdfwDaCatchDetailId]),
    CONSTRAINT [FK_WdfwDaCatchDetail_WdfwDaCatch] FOREIGN KEY ([WdfwDaCatchId]) REFERENCES [dbo].[WdfwDaCatch] ([WdfwDaCatchId]),
    CONSTRAINT [UQ_WdfwDaCatchDetail_WdfwDaCatchId] UNIQUE ([WdfwDaCatchId]),
    CONSTRAINT [CK_WdfwDaCatchDetail_UndersizedCount_Nonnegative] CHECK ([UndersizedCount] IS NULL OR [UndersizedCount] >= 0)
);
