CREATE TABLE [MaintranceJob].[JobHistory] (
    [ID]                         BIGINT          IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]           INT             NOT NULL,
    [Common_Date_RunRef]         INT             NOT NULL,
    [Common_Time_RunRef]         INT             NOT NULL,
    [MaintranceJob_JobStatusRef] INT             NOT NULL,
    [InstanceId]                 INT             NOT NULL,
    [CategoryCode]               INT             NOT NULL,
    [CategoryName]               NVARCHAR (128)  NOT NULL,
    [JobName]                    NVARCHAR (128)  NOT NULL,
    [Duration]                   NUMERIC (18, 6) NOT NULL,
    [Step]                       INT             NOT NULL,
    [SSISExecutionId]            BIGINT          NULL,
    [SSISExecution]              NVARCHAR (50)   NULL,
    [StepName]                   NVARCHAR (128)  NOT NULL,
    [Message]                    NVARCHAR (4000) NOT NULL,
    [InsertDatetime]             DATETIME        NOT NULL,
    CONSTRAINT [PK_MaintranceJob_JobHistory] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_MaintranceJob_JobHistory_Common_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobHistory_Common_DimDate] FOREIGN KEY ([Common_Date_RunRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobHistory_Common_DimTime] FOREIGN KEY ([Common_Time_RunRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobHistory_MaintranceJob_JobStatus] FOREIGN KEY ([MaintranceJob_JobStatusRef]) REFERENCES [MaintranceJob].[JobStatus] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);


GO
ALTER TABLE [MaintranceJob].[JobHistory] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceJob_JobHistory]
    ON [MaintranceJob].[JobHistory]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

