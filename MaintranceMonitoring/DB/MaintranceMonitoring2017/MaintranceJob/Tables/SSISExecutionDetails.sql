CREATE TABLE [MaintranceJob].[SSISExecutionDetails] (
    [ID]                           BIGINT         IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]             INT            NOT NULL,
    [Common_Date_MessageRef]       INT            NOT NULL,
    [Common_Time_MessageRef]       INT            NOT NULL,
    [ExecutionId]                  BIGINT         NOT NULL,
    [SSISExecution]                NVARCHAR (50)  NOT NULL,
    [MessageType]                  SMALLINT       NOT NULL,
    [MessageSourceType]            SMALLINT       NOT NULL,
    [EventName]                    NVARCHAR (50)  NOT NULL,
    [MessageSourceName]            NVARCHAR (250) NOT NULL,
    [MessageSourceTypeDescription] NVARCHAR (128) NOT NULL,
    [Message]                      NVARCHAR (MAX) NOT NULL,
    [SubcomponentName]             NVARCHAR (128) NULL,
    [EventPackagePath]             NVARCHAR (MAX) NOT NULL,
    [EventExecutionPath]           NVARCHAR (MAX) NOT NULL,
    [InsertDatetime]               DATETIME       NOT NULL,
    CONSTRAINT [PK_MaintranceJob_SSISExecutionDetails] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_MaintranceJob_SSISExecutionDetails_Common_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecutionDetails_Common_DimDate] FOREIGN KEY ([Common_Date_MessageRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecutionDetails_Common_DimTime] FOREIGN KEY ([Common_Time_MessageRef]) REFERENCES [Common].[DimTime] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);


GO
ALTER TABLE [MaintranceJob].[SSISExecutionDetails] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceJob_SSISExecutionDetails]
    ON [MaintranceJob].[SSISExecutionDetails]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);


GO
CREATE NONCLUSTERED INDEX [NCIX_ExecutionId_Common_BranchRef]
    ON [MaintranceJob].[SSISExecutionDetails]([ExecutionId] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

