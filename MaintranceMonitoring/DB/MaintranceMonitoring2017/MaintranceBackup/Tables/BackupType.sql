CREATE TABLE [MaintranceBackup].[BackupType] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        CHAR (1)      NOT NULL,
    [Caption]     NVARCHAR (50) NOT NULL,
    [CaptionSort] AS            ((CONVERT([varchar](10),[ID])+'-')+[Caption]) PERSISTED,
    CONSTRAINT [PK_dim_BackupType] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

