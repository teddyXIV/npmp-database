CREATE TABLE [dbo].[State]
(
    [StateId] INT IDENTITY(1,1) NOT NULL,
    [CreatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_State_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(7) NOT NULL CONSTRAINT [DF_State_UpdatedAt] DEFAULT (SYSUTCDATETIME()),
    [StateCode] CHAR(2) NOT NULL,
    [StateName] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED ([StateId]),
    CONSTRAINT [UQ_State_StateCode] UNIQUE ([StateCode]),
    CONSTRAINT [UQ_State_StateName] UNIQUE ([StateName])
);
GO
CREATE TRIGGER [dbo].[TR_State_SetUpdatedAt]
ON [dbo].[State]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF TRIGGER_NESTLEVEL() > 1 RETURN;

    UPDATE [dbo].[State]
    SET [UpdatedAt] = SYSUTCDATETIME()
    FROM [dbo].[State] AS [Target]
    INNER JOIN [inserted] AS [Source] ON [Source].[StateId] = [Target].[StateId];
END;
