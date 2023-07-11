CREATE TABLE [MaintranceJob].[JobActivity] (
    [ID]                              BIGINT           IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]                INT              NOT NULL,
    [Common_Date_RunRequestedRef]     INT              NOT NULL,
    [Common_Time_RunRequestedRef]     INT              NOT NULL,
    [Common_Date_StartExecutionRef]   INT              NOT NULL,
    [Common_Time_StartExecutionRef]   INT              NOT NULL,
    [Common_Date_LastExecutedStepRef] INT              NOT NULL,
    [Common_Time_LastExecutedStepRef] INT              NOT NULL,
    [JobId]                           UNIQUEIDENTIFIER NOT NULL,
    [JobName]                         NVARCHAR (128)   NOT NULL,
    [CategoryName]                    NVARCHAR (128)   NOT NULL,
    [StepName]                        NVARCHAR (128)   NOT NULL,
    [CurrentExecutedStepId]           INT              NOT NULL,
    [Duration]                        INT              NOT NULL,
    [InsertDatetime]                  DATETIME         NOT NULL,
    CONSTRAINT [PK_MaintranceJob_JobActivity] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_MaintranceJob_JobActivity_Common_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobActivity_Common_DimDate_LastExecutedStep] FOREIGN KEY ([Common_Date_LastExecutedStepRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobActivity_Common_DimDate_RunRequested] FOREIGN KEY ([Common_Date_RunRequestedRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobActivity_Common_DimDate_StartExecution] FOREIGN KEY ([Common_Date_StartExecutionRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobActivity_Common_DimTime_LastExecutedStep] FOREIGN KEY ([Common_Time_LastExecutedStepRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobActivity_Common_DimTime_RunRequested] FOREIGN KEY ([Common_Time_RunRequestedRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceJob_JobActivity_Common_DimTime_StartExecution] FOREIGN KEY ([Common_Time_StartExecutionRef]) REFERENCES [Common].[DimTime] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);





GO
ALTER TABLE [MaintranceJob].[JobActivity] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceJob_JobActivity]
    ON [MaintranceJob].[JobActivity]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

