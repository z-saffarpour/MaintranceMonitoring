CREATE TABLE [MaintranceReplication].[DistributionAgent] (
    [ID]                                         INT            IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]                           INT            NOT NULL,
    [MaintranceReplication_ReplicationStatusRef] INT            NOT NULL,
    [MaintranceReplication_PublicationRef]       INT            NOT NULL,
    [MaintranceReplication_SubscriberRef]        INT            NOT NULL,
    [MaintranceReplication_SubscriberDBRef]      INT            NOT NULL,
    [MaintranceReplication_PublisherDBRef]       INT            NOT NULL,
    [MaintranceReplication_PublisherRef]         INT            NOT NULL,
    [Common_Date_AgentStoppedRef]                INT            NOT NULL,
    [Common_Date_AgentLastSyncRef]               INT            NOT NULL,
    [Common_Time_AgentStoppedRef]                INT            NOT NULL,
    [Common_Time_AgentLastSyncRef]               INT            NOT NULL,
    [Common_Time_CurrentLatencyRef]              INT            NOT NULL,
    [LatencyThreshold]                           INT            NOT NULL,
    [LatestErrorMessage]                         NVARCHAR (MAX) NULL,
    [InsertDatetime]                             DATETIME       NOT NULL,
    CONSTRAINT [PK_MaintranceReplication_DistributionAgent] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_DistributionAgent_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_DistributionAgent_DimDate_AgentLastSync] FOREIGN KEY ([Common_Date_AgentLastSyncRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_DistributionAgent_DimDate_AgentStopped] FOREIGN KEY ([Common_Date_AgentStoppedRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_DistributionAgent_DimTime] FOREIGN KEY ([Common_Time_CurrentLatencyRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_DistributionAgent_Publication] FOREIGN KEY ([MaintranceReplication_PublicationRef]) REFERENCES [MaintranceReplication].[Publication] ([ID]),
    CONSTRAINT [FK_DistributionAgent_Publisher] FOREIGN KEY ([MaintranceReplication_PublisherRef]) REFERENCES [MaintranceReplication].[Publisher] ([ID]),
    CONSTRAINT [FK_DistributionAgent_PublisherDB] FOREIGN KEY ([MaintranceReplication_PublisherDBRef]) REFERENCES [MaintranceReplication].[PublisherDB] ([ID]),
    CONSTRAINT [FK_DistributionAgent_Subscriber] FOREIGN KEY ([MaintranceReplication_SubscriberRef]) REFERENCES [MaintranceReplication].[Subscriber] ([ID]),
    CONSTRAINT [FK_DistributionAgent_SubscriberDB] FOREIGN KEY ([MaintranceReplication_SubscriberDBRef]) REFERENCES [MaintranceReplication].[SubscriberDB] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);


GO
ALTER TABLE [MaintranceReplication].[DistributionAgent] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceReplication_DistributionAgent]
    ON [MaintranceReplication].[DistributionAgent]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

