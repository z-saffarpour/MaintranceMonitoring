CREATE TABLE [MaintranceDatabase].[RecoveryModel] (
    [ID]      INT           IDENTITY (1, 1) NOT NULL,
    [Code]    TINYINT       NOT NULL,
    [Name]    VARCHAR (20)  NOT NULL,
    [Caption] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_RecoveryModel] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

