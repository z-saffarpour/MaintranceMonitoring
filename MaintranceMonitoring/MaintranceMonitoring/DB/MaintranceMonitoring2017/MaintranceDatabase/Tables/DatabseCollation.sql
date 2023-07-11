CREATE TABLE [MaintranceDatabase].[DatabseCollation] (
    [ID]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]    VARCHAR (55)  NOT NULL,
    [Caption] NVARCHAR (60) NOT NULL,
    CONSTRAINT [PK_DatabseCollation] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

