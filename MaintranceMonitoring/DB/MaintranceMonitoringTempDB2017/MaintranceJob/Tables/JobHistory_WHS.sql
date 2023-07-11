CREATE TABLE [MaintranceJob].[JobHistory_WHS] (
    [BranchRef]        INT              NOT NULL,
    [InstanceId]       INT              NOT NULL,
    [JobId]            UNIQUEIDENTIFIER NOT NULL,
    [ExecutionId]      BIGINT           NULL,
    [JobName]          NVARCHAR (128)   NOT NULL,
    [RunDate]          DATE             NOT NULL,
    [RunTime]          TIME (0)         NOT NULL,
    [JobStatus]        INT              NOT NULL,
    [CategoryName]     NVARCHAR (128)   NOT NULL,
    [CategoryCode]     TINYINT          NOT NULL,
    [Step]             INT              NOT NULL,
    [StepName]         NVARCHAR (128)   NOT NULL,
    [SubcomponentName] NVARCHAR (4000)  NULL,
    [Message]          NVARCHAR (4000)  NOT NULL,
    [Duration]         NUMERIC (18, 6)  NOT NULL
);

