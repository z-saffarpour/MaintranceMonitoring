CREATE TABLE [MaintranceJob].[SSISExecutionProject] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (128) NOT NULL,
    [Caption] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_MaintranceJob_SSISExecutionProject] PRIMARY KEY CLUSTERED ([ID] ASC)
);

