CREATE TABLE [MaintranceJob].[SSISExecutionStatus] (
    [ID]      INT           IDENTITY (1, 1) NOT NULL,
    [Code]    TINYINT       NOT NULL,
    [Name]    NVARCHAR (50) NOT NULL,
    [Caption] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_MaintranceJob_SSISExecutionStatus] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

