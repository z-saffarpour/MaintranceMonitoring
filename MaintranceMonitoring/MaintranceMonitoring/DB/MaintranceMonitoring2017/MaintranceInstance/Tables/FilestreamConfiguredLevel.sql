CREATE TABLE [MaintranceInstance].[FilestreamConfiguredLevel] (
    [ID]      INT           IDENTITY (1, 1) NOT NULL,
    [Code]    VARCHAR (5)   NOT NULL,
    [Name]    VARCHAR (60)  NOT NULL,
    [Caption] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_InstanceFilestreamConfiguredLevel] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

