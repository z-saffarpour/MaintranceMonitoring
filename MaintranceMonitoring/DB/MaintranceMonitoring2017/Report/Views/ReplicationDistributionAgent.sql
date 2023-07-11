CREATE VIEW Report.ReplicationDistributionAgent
AS
	SELECT myBranch.BranchNumber, myBranch.BranchName, 
		   CONCAT(REPLICATE('0',3-LEN(myBranch.RegionNo)),myBranch.RegionNo) AS BranchSiteId, 
		   myBranchType.Caption AS BranchTypeCaption,
		   myReplicationStatus.Caption AS ReplicationStatus, [LatestErrorMessage], 
		   myPublication.Caption AS Publication, mySubscriber.Caption AS Subscriber, 
		   mySubscriberDB.Caption AS SubscriberDB, myPublisherDB.Caption AS PublisherDB, 
		   myPublisher.Caption AS Publisher, myCurrentLatency.FullTime AS CurrentLatency, LatencyThreshold, 
		   myAgentStoppedDate.PersianDate AS AgentStoppedDate, myAgentStoppedTime.FullTime AS AgentStoppedTime, 
		   myAgentLastSyncDate.PersianDate AS AgentLastSyncDate, myAgentLastSyncTime.FullTime AS AgentLastSyncTime,
		   myMonitoring.InsertDatetime
	FROM Common.Branch AS myBranch WITH(READPAST) 
	INNER JOIN [Common].BranchType AS myBranchType WITH(READPAST) ON myBranch.common_BranchTypeRef = myBranchType.ID
	INNER JOIN [MaintranceReplication].DistributionAgent AS myMonitoring WITH(READPAST) ON myMonitoring.Common_BranchRef = myBranch.ID
	INNER JOIN [MaintranceReplication].Publication AS myPublication WITH(READPAST) ON myMonitoring.MaintranceReplication_PublicationRef = myPublication.ID
	INNER JOIN [MaintranceReplication].Publisher AS myPublisher WITH(READPAST) ON myMonitoring.MaintranceReplication_PublisherRef = myPublisher.ID
	INNER JOIN [MaintranceReplication].PublisherDB AS myPublisherDB WITH(READPAST) ON myMonitoring.MaintranceReplication_PublisherDBRef = myPublisherDB.ID
	INNER JOIN [MaintranceReplication].ReplicationStatus AS myReplicationStatus WITH(READPAST) ON myMonitoring.MaintranceReplication_ReplicationStatusRef = myReplicationStatus.ID
	INNER JOIN [MaintranceReplication].Subscriber AS mySubscriber WITH(READPAST) ON myMonitoring.MaintranceReplication_SubscriberRef = mySubscriber.ID
	INNER JOIN [MaintranceReplication].SubscriberDB AS mySubscriberDB WITH(READPAST) ON myMonitoring.MaintranceReplication_SubscriberDBRef = mySubscriberDB.ID
	INNER JOIN [Common].DimTime AS myCurrentLatency WITH(READPAST) ON myMonitoring.Common_Time_CurrentLatencyRef = myCurrentLatency.ID
	INNER JOIN [Common].DimDate AS myAgentStoppedDate WITH(READPAST) ON myMonitoring.Common_Date_AgentStoppedRef = myAgentStoppedDate.ID
	INNER JOIN [Common].DimTime AS myAgentStoppedTime WITH(READPAST) ON myMonitoring.Common_Time_AgentStoppedRef = myAgentStoppedTime.ID
	INNER JOIN [Common].DimDate AS myAgentLastSyncDate WITH(READPAST) ON myMonitoring.Common_Date_AgentLastSyncRef = myAgentLastSyncDate.ID
	INNER JOIN [Common].DimTime AS myAgentLastSyncTime WITH(READPAST) ON myMonitoring.Common_Time_AgentLastSyncRef = myAgentLastSyncTime.ID
	WHERE   myBranch.Enabled = 1 
		AND myBranch.EnabledReplicationDistributionAgent = 1