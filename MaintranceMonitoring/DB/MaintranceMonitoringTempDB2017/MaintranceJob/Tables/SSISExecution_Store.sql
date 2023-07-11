CREATE TABLE [MaintranceJob].[SSISExecution_Store] (
    [BranchRef]           INT            NOT NULL,
    [ExecutionId]         BIGINT         NOT NULL,
    [FolderName]          NVARCHAR (128) NOT NULL,
    [ProjectName]         NVARCHAR (128) NOT NULL,
    [PackageName]         NVARCHAR (260) NOT NULL,
    [ExecutionStatusCode] INT            NOT NULL,
    [StartDatetime]       DATETIME       NULL,
    [EndDatetime]         DATETIME       NULL,
    [CallerName]          NVARCHAR (128) NOT NULL,
    [ProcessId]           INT            NOT NULL,
    [StoppedByName]       NVARCHAR (128) NULL
);

