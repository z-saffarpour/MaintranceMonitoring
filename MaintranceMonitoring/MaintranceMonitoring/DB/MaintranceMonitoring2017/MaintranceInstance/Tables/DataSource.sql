CREATE TABLE [MaintranceInstance].[DataSource] (
    [ID]      INT             IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (4000) NOT NULL,
    [Caption] NVARCHAR (4000) NOT NULL,
    CONSTRAINT [PK_MaintranceInstance_DataSource] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

