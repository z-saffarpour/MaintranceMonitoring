CREATE TABLE [Common].[BranchType] (
    [ID]      INT           NOT NULL,
    [Code]    INT           NOT NULL,
    [Name]    NVARCHAR (10) NOT NULL,
    [Caption] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Common_BranchType] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

