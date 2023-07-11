CREATE TABLE [MaintranceReplication].[DistributionAgent_Store] (
    [BranchRef]          INT            NOT NULL,
    [ReplicationStatus]  VARCHAR (11)   NOT NULL,
    [LatestErrorMessage] NVARCHAR (MAX) NULL,
    [Publication]        NVARCHAR (128) NOT NULL,
    [Subscriber]         NVARCHAR (128) NOT NULL,
    [SubscriberDB]       NVARCHAR (128) NOT NULL,
    [PublisherDB]        NVARCHAR (128) NOT NULL,
    [Publisher]          NVARCHAR (128) NOT NULL,
    [CurrentLatency]     TIME (7)       NULL,
    [LatencyThreshold]   INT            NOT NULL,
    [AgentStopped]       DATETIME       NOT NULL,
    [AgentLastStopped]   DATETIME       NULL,
    [AgentLastSync]      DATETIME       NOT NULL,
    [LastEntryTimeStamp] DATETIME       NULL
);

