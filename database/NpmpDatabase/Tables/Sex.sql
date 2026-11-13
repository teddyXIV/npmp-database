CREATE TABLE [dbo].[Sex]
(
    [SexId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Sex_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_Sex_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [SexCode] NVARCHAR(20) NOT NULL,
    [SexName] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Sex] PRIMARY KEY CLUSTERED ([SexId]),
    CONSTRAINT [UQ_Sex_SexCode] UNIQUE ([SexCode]),
    CONSTRAINT [UQ_Sex_SexName] UNIQUE ([SexName])
);
GO
CREATE TRIGGER [dbo].[TR_Sex_SetUpdatedAt]
ON [dbo].[Sex]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[Sex]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[Sex] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[SexId] = [Target].[SexId];
END;
