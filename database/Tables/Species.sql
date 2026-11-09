CREATE TABLE [dbo].[Species]
(
    [SpeciesId] INT IDENTITY(1,1) NOT NULL,
    [CommonName] NVARCHAR(255) NOT NULL,
    [ScientificName] NVARCHAR(255) NULL,
    CONSTRAINT [PK_Species] PRIMARY KEY CLUSTERED ([SpeciesId]),
    CONSTRAINT [UQ_Species_CommonName] UNIQUE ([CommonName])
);
GO
CREATE UNIQUE INDEX [UQ_Species_ScientificName]
    ON [dbo].[Species] ([ScientificName])
    WHERE [ScientificName] IS NOT NULL;
