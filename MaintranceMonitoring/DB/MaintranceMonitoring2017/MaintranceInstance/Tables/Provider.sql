CREATE TABLE [MaintranceInstance].[Provider] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (128) NOT NULL,
    [Caption] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_MaintranceInstance_Provider] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

