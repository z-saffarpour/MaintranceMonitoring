USE distribution
GO
EXEC sys.sp_replmonitorrefreshjob @iterations = 1;
GO
--=V1======
WITH MaxXact_CTE
AS 
(
	SELECT myServer.name AS ServerName, myAgent.publisher_database_id AS PublisherDBID, MAX(myHistory.xact_seqno) AS XactSeqNo
    FROM distribution.dbo.MSdistribution_history AS myHistory WITH(NOLOCK)
    INNER JOIN distribution.dbo.MSdistribution_agents AS myAgent WITH(NOLOCK) ON myAgent.id = myHistory.agent_id
    INNER JOIN master.sys.servers AS myServer WITH(NOLOCK)ON myServer.server_id = myAgent.subscriber_id
    GROUP BY myServer.name, myAgent.publisher_database_id
)
,OldestXact_CTE
AS 
(
	SELECT myMaxXact.ServerName AS ServerName, PublisherDBID,MIN(entry_time) as OldestEntryTime
    FROM distribution.dbo.msrepl_transactions AS myTransaction WITH(NOLOCK)
    INNER JOIN MaxXact_CTE AS myMaxXact On myMaxXact.XactSeqNo < myTransaction.xact_seqno And myMaxXact.PublisherDBID = myTransaction.publisher_database_id
    Group By myMaxXact.ServerName,PublisherDBID
), Error_CTE
AS
(
	SELECT ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNumber, id
	FROM distribution.dbo.MSrepl_errors  
), Latest_Error_CTE
AS
(
	SELECT time,error_code, error_text, xact_seqno
	FROM distribution.dbo.MSrepl_errors  
	WHERE Id IN (SELECT id FROM Error_CTE WHERE RowNumber = 1)
)
SELECT Case myMonitorData.status
		WHEN 1 THEN 'Started'
		WHEN 2 THEN 'Succeeded'
		WHEN 3 THEN 'In progress'
		WHEN 4 THEN 'Idle'
		WHEN 5 THEN 'Retrying'
		WHEN 6 THEN 'Failed'
      END COLLATE SQL_Latin1_General_CP1_CI_AS AS [ReplicationStatus],
	  STUFF((SELECT ','+ error_text FROM Latest_Error_CTE WHERE time >= myMonitorData.last_distsync FOR XML PATH('')),1,1,'') COLLATE SQL_Latin1_General_CP1_CI_AS AS [LatestError],
	  myMonitorData.publication COLLATE SQL_Latin1_General_CP1_CI_AS AS [PublicationName],
      mySubscriber.name COLLATE SQL_Latin1_General_CP1_CI_AS AS [Subscriber],
      myAgent.subscriber_db COLLATE SQL_Latin1_General_CP1_CI_AS AS [SubscriberDB],
      myMonitorData.publisher_db COLLATE SQL_Latin1_General_CP1_CI_AS AS [PublisherDB],
      myMonitorData.publisher COLLATE SQL_Latin1_General_CP1_CI_AS AS [Publisher],
      Right('00' + Cast(myMonitorData.cur_latency/3600 AS VARCHAR), 2) + ':' + Right('00' + Cast((myMonitorData.cur_latency%3600)/60 AS VARCHAR), 2) + ':' + Right('00' + Cast(myMonitorData.cur_latency%60 AS VARCHAR), 2) COLLATE SQL_Latin1_General_CP1_CI_AS AS [CurrentLatency],
      Cast(myPublicationThreshold.value As Int) AS [LatencyThreshold],
	  agentstoptime - 1 AS [AgentStopped],
      DateDiff(hour, agentstoptime, getdate()) - 1 AS [AgentLastStopped],
      myMonitorData.last_distsync AS [AgentLastSync],
	  myOldestXact.OldestEntryTime AS [LastEntryTimeStamp]
FROM distribution.dbo.MSreplication_monitordata AS myMonitorData WITH(NOLOCK)
INNER JOIN distribution.dbo.MSdistribution_agents AS myAgent WITH(NOLOCK) On myAgent.id = myMonitorData.agent_id
INNER JOIN master.sys.servers AS mySubscriber on mySubscriber.server_id = myAgent.subscriber_id
INNER JOIN distribution.dbo.MSpublicationthresholds AS myPublicationThreshold WITH(NOLOCK) ON myPublicationThreshold.publication_id = myMonitorData.publication_id And myPublicationThreshold.metric_id = 2 -- Latency
LEFT JOIN OldestXact_CTE AS myOldestXact on myOldestXact.PublisherDBID = DB_ID(myMonitorData.publisher_db)
WHERE myMonitorData.publication_type = 0 -- 0 = Transactional publication
	AND myMonitorData.agent_type = 3 -- 3 = distribution agent
ORDER BY [PublicationName],[PublisherDB]
GO
--=V2=====================
WITH MaxXact_CTE
AS 
(
	SELECT myServer.name AS ServerName, myAgent.publisher_database_id AS PublisherDBID, MAX(myHistory.xact_seqno) AS XactSeqNo
    FROM distribution.dbo.MSdistribution_history AS myHistory WITH(NOLOCK)
    INNER JOIN distribution.dbo.MSdistribution_agents AS myAgent WITH(NOLOCK) ON myAgent.id = myHistory.agent_id
    INNER JOIN master.sys.servers AS myServer WITH(NOLOCK)ON myServer.server_id = myAgent.subscriber_id
    GROUP BY myServer.name, myAgent.publisher_database_id
)
,OldestXact_CTE
AS 
(
	SELECT myMaxXact.ServerName AS ServerName, PublisherDBID,MIN(entry_time) as OldestEntryTime
    FROM distribution.dbo.msrepl_transactions AS myTransaction WITH(NOLOCK)
    INNER JOIN MaxXact_CTE AS myMaxXact On myMaxXact.XactSeqNo < myTransaction.xact_seqno And myMaxXact.PublisherDBID = myTransaction.publisher_database_id
    Group By myMaxXact.ServerName,PublisherDBID
), Error_CTE
AS
(
	SELECT ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNumber, id
	FROM distribution.dbo.MSrepl_errors  
), Latest_Error_CTE
AS
(
	SELECT time,error_code, error_text, xact_seqno
	FROM distribution.dbo.MSrepl_errors  
	WHERE Id IN (SELECT id FROM Error_CTE WHERE RowNumber = 1)
)
SELECT Case myMonitorData.status
		WHEN 1 THEN 'Started'
		WHEN 2 THEN 'Succeeded'
		WHEN 3 THEN 'In progress'
		WHEN 4 THEN 'Idle'
		WHEN 5 THEN 'Retrying'
		WHEN 6 THEN 'Failed'
      END COLLATE SQL_Latin1_General_CP1_CI_AS AS [ReplicationStatus],
	  NULL AS [LatestError],
	  myMonitorData.publication COLLATE SQL_Latin1_General_CP1_CI_AS AS [PublicationName],
      mySubscriber.name COLLATE SQL_Latin1_General_CP1_CI_AS AS [Subscriber],
      myAgent.subscriber_db COLLATE SQL_Latin1_General_CP1_CI_AS AS [SubscriberDB],
      myMonitorData.publisher_db COLLATE SQL_Latin1_General_CP1_CI_AS AS [PublisherDB],
      myMonitorData.publisher COLLATE SQL_Latin1_General_CP1_CI_AS AS [Publisher],
      Right('00' + Cast(myMonitorData.cur_latency/3600 AS VARCHAR), 2) + ':' + Right('00' + Cast((myMonitorData.cur_latency%3600)/60 AS VARCHAR), 2) + ':' + Right('00' + Cast(myMonitorData.cur_latency%60 AS VARCHAR), 2) COLLATE SQL_Latin1_General_CP1_CI_AS AS [CurrentLatency],
      Cast(myPublicationThreshold.value As Int) AS [LatencyThreshold],
	  agentstoptime - 1 AS [AgentStopped],
      DateDiff(hour, agentstoptime, getdate()) - 1 AS [AgentLastStopped],
      myMonitorData.last_distsync AS [AgentLastSync],
	  myOldestXact.OldestEntryTime AS [LastEntryTimeStamp]
FROM distribution.dbo.MSreplication_monitordata AS myMonitorData WITH(NOLOCK)
INNER JOIN distribution.dbo.MSdistribution_agents AS myAgent WITH(NOLOCK) On myAgent.id = myMonitorData.agent_id
INNER JOIN master.sys.servers AS mySubscriber on mySubscriber.server_id = myAgent.subscriber_id
INNER JOIN distribution.dbo.MSpublicationthresholds AS myPublicationThreshold WITH(NOLOCK) ON myPublicationThreshold.publication_id = myMonitorData.publication_id And myPublicationThreshold.metric_id = 2 -- Latency
LEFT JOIN OldestXact_CTE AS myOldestXact on myOldestXact.PublisherDBID = DB_ID(myMonitorData.publisher_db)
WHERE myMonitorData.publication_type = 0 -- 0 = Transactional publication
	AND myMonitorData.agent_type = 3 -- 3 = distribution agent
ORDER BY [PublicationName],[PublisherDB]