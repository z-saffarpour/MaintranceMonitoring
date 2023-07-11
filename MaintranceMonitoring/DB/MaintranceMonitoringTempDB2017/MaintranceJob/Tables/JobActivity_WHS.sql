CREATE TABLE [MaintranceJob].[JobActivity_WHS] (
    [BranchRef]                INT              NOT NULL,
    [JobId]                    UNIQUEIDENTIFIER NOT NULL,
    [JobName]                  NVARCHAR (128)   NOT NULL,
    [CategoryName]             NVARCHAR (128)   NOT NULL,
    [StepName]                 NVARCHAR (128)   NOT NULL,
    [CurrentExecutedStepId]    INT              NOT NULL,
    [RunRequestedDatetime]     DATETIME         NOT NULL,
    [StartExecutionDatetime]   DATETIME         NOT NULL,
    [LastExecutedStepDatetime] DATETIME         NOT NULL,
    [Duration]                 INT              NOT NULL
);

