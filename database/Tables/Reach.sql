CREATE TABLE [dbo].[Reach]
(
    [ReachId] INT IDENTITY(1,1) NOT NULL,
    [ReachCode] NVARCHAR(50) NOT NULL,
    [CommonName] NVARCHAR(255) NULL,
    CONSTRAINT [PK_Reach] PRIMARY KEY CLUSTERED ([ReachId]),
    CONSTRAINT [UQ_Reach_ReachCode] UNIQUE ([ReachCode])
);
