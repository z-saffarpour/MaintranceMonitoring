CREATE TABLE [MaintranceJob].[SSISExecutionPackage] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (260) NOT NULL,
    [Caption] NVARCHAR (260) NOT NULL,
    CONSTRAINT [PK_MaintranceJob_SSISExecutionPackage] PRIMARY KEY CLUSTERED ([ID] ASC)
);

