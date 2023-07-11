CREATE TABLE [MaintranceJob].[SSISExecution_Details_HQ] (
    [BranchRef]                    INT            NOT NULL,
    [ExecutionId]                  BIGINT         NOT NULL,
    [MessageDatetime]              DATETIME       NOT NULL,
    [MessageType]                  SMALLINT       NOT NULL,
    [MessageSourceType]            SMALLINT       NOT NULL,
    [EventName]                    NVARCHAR (50)  NOT NULL,
    [MessageSourceName]            NVARCHAR (250) NOT NULL,
    [MessageSourceTypeDescription] NVARCHAR (128) NOT NULL,
    [Message]                      NVARCHAR (MAX) NOT NULL,
    [SubcomponentName]             NVARCHAR (128) NULL,
    [EventPackagePath]             NVARCHAR (MAX) NOT NULL,
    [EventExecutionPath]           NVARCHAR (MAX) NOT NULL
);

