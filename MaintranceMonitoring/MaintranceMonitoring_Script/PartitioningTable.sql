USE [SqlDeep_MaintranceMonitoring]
GO

--==============================================================================================================================================
DROP TABLE IF EXISTS #PartitionRangeValue
SELECT ID
INTO #PartitionRangeValue
FROM Common.Branch AS myBranch
WHERE myBranch.ID NOT IN
      (
          SELECT CAST(myPartitionRangeValues.value AS INT)
          FROM sys.partition_range_values AS myPartitionRangeValues
          INNER JOIN sys.partition_functions AS myPartitionFunctions ON myPartitionFunctions.function_id = myPartitionRangeValues.function_id
          WHERE myPartitionFunctions.name = 'PF_Branch'
      )
IF EXISTS(SELECT 1 FROM #PartitionRangeValue)
BEGIN

	DECLARE @myPFScript VARCHAR(MAX)
	DECLARE @myPSScript VARCHAR(MAX)
	
	SET @myPFScript = ''
	SELECT @myPFScript = @myPFScript + 'ALTER PARTITION SCHEME [PS_Branch] NEXT USED [FG_Data];' + CHAR(13) + CHAR(10)
	FROM #PartitionRangeValue

	SET @myPSScript = ''
	SELECT @myPSScript = @myPSScript + 'ALTER PARTITION FUNCTION [PF_Branch]() SPLIT RANGE('+ CAST(ID AS VARCHAR(10)) + ');' + CHAR(13) + CHAR(10)
	FROM #PartitionRangeValue

	EXECUTE DBA.dbo.dbasp_print_text @myPFScript
	EXECUTE DBA.dbo.dbasp_print_text @myPSScript
END
GO
--=MaintranceBackup==Backupset=============================================================================================================================================
ALTER TABLE [MaintranceBackup].[Backupset] DROP CONSTRAINT [PK_MaintranceBackup_Backupset] WITH ( ONLINE = OFF )
GO
ALTER TABLE [MaintranceBackup].[Backupset] ADD  CONSTRAINT [PK_MaintranceBackup_Backupset] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [FG_Data]
GO
CREATE CLUSTERED INDEX IX_MaintranceBackup_Backupset ON [MaintranceBackup].[Backupset](ID,Common_BranchRef)
WITH (PAD_INDEX = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [PS_Branch](Common_BranchRef)
GO
--=MaintranceDatabase==SQLDatabases=============================================================================================================================================
ALTER TABLE [MaintranceDatabase].[SQLDatabases] DROP CONSTRAINT [PK_MaintranceDatabase_SQLDatabases] WITH ( ONLINE = OFF )
GO
ALTER TABLE [MaintranceDatabase].[SQLDatabases] ADD  CONSTRAINT [PK_MaintranceDatabase_SQLDatabases] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [FG_Data]
GO
CREATE CLUSTERED INDEX IX_MaintranceDatabase_SQLDatabases ON [MaintranceDatabase].[SQLDatabases](ID,Common_BranchRef)
WITH (PAD_INDEX = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [PS_Branch](Common_BranchRef)
GO
--=MaintranceDatabase==SQLDatabases=============================================================================================================================================
ALTER TABLE [MaintranceInstance].[SQLInstance] DROP CONSTRAINT [PK_MaintranceInstance_SQLInstance] WITH ( ONLINE = OFF )
GO
ALTER TABLE [MaintranceInstance].[SQLInstance] ADD  CONSTRAINT [PK_MaintranceInstance_SQLInstance] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [FG_Data]
GO
CREATE CLUSTERED INDEX IX_MaintranceInstance_SQLInstance ON [MaintranceInstance].[SQLInstance](ID,Common_BranchRef)
WITH (PAD_INDEX = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [PS_Branch](Common_BranchRef)
GO
--=MaintranceJob==JobHistory=============================================================================================================================================
ALTER TABLE [MaintranceJob].[JobActivity] DROP CONSTRAINT [PK_MaintranceJob_JobActivity] WITH ( ONLINE = OFF )
GO
ALTER TABLE [MaintranceJob].[JobActivity] ADD  CONSTRAINT [PK_MaintranceJob_JobActivity] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [FG_Data]
GO
CREATE CLUSTERED INDEX IX_MaintranceJob_JobActivity ON [MaintranceJob].[JobActivity](ID,Common_BranchRef)
WITH (PAD_INDEX = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [PS_Branch](Common_BranchRef)
GO
--=MaintranceJob==JobHistory=============================================================================================================================================
ALTER TABLE [MaintranceJob].[JobHistory] DROP CONSTRAINT [PK_MaintranceJob_JobHistory] WITH ( ONLINE = OFF )
GO
ALTER TABLE [MaintranceJob].[JobHistory] ADD  CONSTRAINT [PK_MaintranceJob_JobHistory] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [FG_Data]
GO
CREATE CLUSTERED INDEX IX_MaintranceJob_JobHistory ON [MaintranceJob].[JobHistory](ID,Common_BranchRef)
WITH (PAD_INDEX = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [PS_Branch](Common_BranchRef)
GO
--=MaintranceJob==JobHistory=============================================================================================================================================
ALTER TABLE [MaintranceReplication].[DistributionAgent] DROP CONSTRAINT [PK_MaintranceReplication_DistributionAgent] WITH ( ONLINE = OFF )
GO
ALTER TABLE [MaintranceReplication].[DistributionAgent] ADD  CONSTRAINT [PK_MaintranceReplication_DistributionAgent] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [FG_Data]
GO
CREATE CLUSTERED INDEX IX_MaintranceReplication_DistributionAgent ON [MaintranceReplication].[DistributionAgent](ID,Common_BranchRef)
WITH (PAD_INDEX = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, FILLFACTOR = 90) 
ON [PS_Branch](Common_BranchRef)
GO
--==============================================================================================================================================
SELECT $PARTITION.PF_Branch(Common_BranchRef) AS [Partition Number],
       MIN(Common_BranchRef) AS MIN,
       MAX(Common_BranchRef) AS MAX
FROM [MaintranceJob].[JobHistory] WITH (NOLOCK)
GROUP BY $PARTITION.PF_Branch(Common_BranchRef)
ORDER BY [Partition Number];
GO
--==================================================================
SELECT OBJECT_NAME(i.object_id) AS Object_Name,
       p.partition_number,
       fg.name AS Filegroup_Name,
       rows,
       au.total_pages,
       CASE boundary_value_on_right WHEN 1 THEN 'less than' ELSE 'less than or equal to' END AS 'comparison',
       value
FROM sys.partitions p
JOIN sys.indexes i ON p.object_id = i.object_id AND p.index_id = i.index_id
INNER JOIN sys.partition_schemes ps ON ps.data_space_id = i.data_space_id
INNER JOIN sys.partition_functions f ON f.function_id = ps.function_id
LEFT JOIN sys.partition_range_values rv ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
INNER JOIN sys.destination_data_spaces dds ON dds.partition_scheme_id = ps.data_space_id AND dds.destination_id = p.partition_number
INNER JOIN sys.filegroups fg ON dds.data_space_id = fg.data_space_id
INNER JOIN
(
    SELECT container_id, SUM(total_pages) AS total_pages
    FROM sys.allocation_units
    GROUP BY container_id
) AS au ON au.container_id = p.partition_id
WHERE i.index_id < 2
ORDER BY 1, 2;
