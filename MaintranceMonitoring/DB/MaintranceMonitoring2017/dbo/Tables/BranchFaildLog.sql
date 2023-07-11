CREATE TABLE [dbo].[BranchFaildLog] (
    [ID]                BIGINT         IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]  INT            NOT NULL,
    [PackageName]       NVARCHAR (50)  NOT NULL,
    [ServerExecutionId] BIGINT         CONSTRAINT [DF_BranchFaildLog_ServerExecutionId] DEFAULT ((0)) NOT NULL,
    [ErrorCode]         INT            NOT NULL,
    [ErrorMessage]      NVARCHAR (MAX) NOT NULL,
    [InsertDatetime]    DATETIME       CONSTRAINT [DF_BranchFaildLog_InsertDatetime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_dbo_BranchFaildLog] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);



