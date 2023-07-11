CREATE TABLE [MaintranceJob].[SSISExecution] (
    [ID]                                    BIGINT         IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]                      INT            NOT NULL,
    [Common_Date_StartRef]                  INT            NOT NULL,
    [Common_Date_EndRef]                    INT            NOT NULL,
    [Common_Time_StartRef]                  INT            NOT NULL,
    [Common_Time_EndRef]                    INT            NOT NULL,
    [MaintranceJob_SSISExecutionFolderRef]  INT            NOT NULL,
    [MaintranceJob_SSISExecutionProjectRef] INT            NOT NULL,
    [MaintranceJob_SSISExecutionPackageRef] INT            NOT NULL,
    [MaintranceJob_SSISExecutionStatusRef]  INT            NOT NULL,
    [Duration]                              INT            NOT NULL,
    [ExecutionId]                           BIGINT         NOT NULL,
    [SSISExecution]                         NVARCHAR (50)  NOT NULL,
    [CallerName]                            NVARCHAR (128) NOT NULL,
    [ProcessId]                             INT            NOT NULL,
    [StoppedByName]                         NVARCHAR (128) NULL,
    [InsertDatetime]                        DATETIME       NOT NULL,
    CONSTRAINT [PK_MaintranceJob_SSISExecution] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_MaintranceJob_SSISExecution_Common_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_Common_DimDate_End] FOREIGN KEY ([Common_Date_EndRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_Common_DimDate_Start] FOREIGN KEY ([Common_Date_StartRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_Common_DimTime_End] FOREIGN KEY ([Common_Time_EndRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_Common_DimTime_Start] FOREIGN KEY ([Common_Time_StartRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_MaintranceJob_SSISExecutionFolder] FOREIGN KEY ([MaintranceJob_SSISExecutionFolderRef]) REFERENCES [MaintranceJob].[SSISExecutionFolder] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_MaintranceJob_SSISExecutionPackage] FOREIGN KEY ([MaintranceJob_SSISExecutionPackageRef]) REFERENCES [MaintranceJob].[SSISExecutionPackage] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_MaintranceJob_SSISExecutionProject] FOREIGN KEY ([MaintranceJob_SSISExecutionProjectRef]) REFERENCES [MaintranceJob].[SSISExecutionProject] ([ID]),
    CONSTRAINT [FK_MaintranceJob_SSISExecution_MaintranceJob_SSISExecutionStatus] FOREIGN KEY ([MaintranceJob_SSISExecutionStatusRef]) REFERENCES [MaintranceJob].[SSISExecutionStatus] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);


GO
ALTER TABLE [MaintranceJob].[SSISExecution] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceJob_SSISExecution]
    ON [MaintranceJob].[SSISExecution]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

