CREATE TABLE [dbo].[State]
(
    [StateId] INT IDENTITY(1,1) NOT NULL,
    [StateCode] CHAR(2) NOT NULL,
    [StateName] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED ([StateId]),
    CONSTRAINT [UQ_State_StateCode] UNIQUE ([StateCode]),
    CONSTRAINT [UQ_State_StateName] UNIQUE ([StateName])
);
