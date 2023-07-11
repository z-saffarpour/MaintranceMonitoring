﻿CREATE TABLE [MaintranceInstance].[ProductUpdateLevel] (
    [ID]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]    VARCHAR (60)  NOT NULL,
    [Caption] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_InstanceProductUpdateLevel] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

