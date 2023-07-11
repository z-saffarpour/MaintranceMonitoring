CREATE TABLE [MaintranceJob].[SSISExecutionFolder] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (128) NOT NULL,
    [Caption] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_MaintranceJob_SSISExecutionFolder] PRIMARY KEY CLUSTERED ([ID] ASC)
);

