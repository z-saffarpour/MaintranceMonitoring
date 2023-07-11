CREATE VIEW Report.[SQLInstance]
AS
	SELECT mySQLInstance.ID, CONCAT(REPLICATE('0',3-LEN(myBranch.RegionNo)),myBranch.RegionNo) AS BranchSiteId, myBranch.BranchName, myBranch.BranchNumber, myBranchType.Name AS BranchType,
		   mySQLInstance.ComputerNamePhysicalNetBIOS, mySQLInstance.MachineName, mySQLInstance.ServerName, mySQLInstance.ServiceName,
		   myDatabseCollation.Caption AS DatabseCollation, myInstanceEdition.Caption AS Edition,
		   myInstanceProductBuild.Caption AS ProductBuild,myInstanceProductUpdateLevel.Caption AS ProductLevel,
		   myInstanceProductUpdateLevel.Caption AS ProductUpdateLevel, myInstanceProductVersion.Caption AS InstanceProductVersion,
		   myInstanceFilestreamConfiguredLevel.Caption AS FilestreamConfiguredLevel,
		   mySQLInstance.VersionDesc, mySQLInstance.ProductVersion, mySQLInstance.ErrorLogFileName, mySQLInstance.InstanceDefaultDataPath, mySQLInstance.InstanceDefaultLogPath,
		   mySQLInstance.FilestreamEffectiveLevel, mySQLInstance.FilestreamShareName, mySQLInstance.IsAdvancedAnalyticsInstalled, mySQLInstance.IsClustered,
		   mySQLInstance.IsFullTextInstalled, mySQLInstance.IsIntegratedSecurityOnly, mySQLInstance.IsPolybaseInstalled, mySQLInstance.IsSingleUser, mySQLInstance.IsXTPSupported,
		   mySQLInstance.IsLocalDB, mySQLInstance.ProductUpdateReference, mySQLInstance.ResourceLastUpdateDatetime, mySQLInstance.MaxWorkerThreads,
		   mySQLInstance.CostThresholdForParallelism, mySQLInstance.MaxDegreeOfParallelism, mySQLInstance.MinServerMemoryMB, mySQLInstance.MaxServerMemoryMB,
		   mySQLInstance.DefaultFillFactor_Percent, mySQLInstance.IsPriorityBoost, mySQLInstance.IsDefaultTraceEnabled, mySQLInstance.IsRemoteAdminConnections,
		   mySQLInstance.IsDefaultBackupCompression, mySQLInstance.IsDefaultBackupCheckSum, mySQLInstance.IsOptimizeForAdHocWorkloads,
		   mySQLInstance.IsAgentXPs, mySQLInstance.IsDatabaseMailXPs, mySQLInstance.IsSMODMOXPs, mySQLInstance.IsOleAutomationProcedures,
		   mySQLInstance.IsXPCmdShell, mySQLInstance.IsClrEnabled, mySQLInstance.RemoteProcTrans, mySQLInstance.IsC2AuditMode,
		   mySQLInstance.IsExternalScriptsEnabled, mySQLInstance.QueryGovernorCostLimit, mySQLInstance.InsertDatetime 
	FROM MaintranceInstance.SQLInstance AS mySQLInstance
	INNER JOIN Common.Branch AS myBranch ON myBranch.ID = mySQLInstance.Common_BranchRef
	INNER JOIN Common.BranchType AS myBranchType ON myBranchType.ID = myBranch.common_BranchTypeRef
	INNER JOIN MaintranceDatabase.DatabseCollation AS myDatabseCollation ON myDatabseCollation.ID = mySQLInstance.MaintranceDatabase_DatabseCollationRef
	INNER JOIN MaintranceInstance.Edition AS myInstanceEdition ON myInstanceEdition.ID = mySQLInstance.MaintranceInstance_EditionRef
	INNER JOIN MaintranceInstance.ProductBuild AS myInstanceProductBuild ON myInstanceProductBuild.ID = mySQLInstance.MaintranceInstance_ProductBuildRef
	INNER JOIN MaintranceInstance.ProductLevel AS myProductLevel ON myProductLevel.ID = mySQLInstance.MaintranceInstance_ProductLevelRef
	INNER JOIN MaintranceInstance.ProductUpdateLevel AS myInstanceProductUpdateLevel ON myInstanceProductUpdateLevel.ID = mySQLInstance.MaintranceInstance_ProductUpdateLevelRef
	INNER JOIN MaintranceInstance.ProductVersion AS myInstanceProductVersion ON myInstanceProductVersion.ID = mySQLInstance.MaintranceInstance_ProductVersionRef
	INNER JOIN MaintranceInstance.FilestreamConfiguredLevel AS myInstanceFilestreamConfiguredLevel ON myInstanceFilestreamConfiguredLevel.ID = mySQLInstance.MaintranceInstance_FilestreamConfiguredLevelRef
	WHERE myBranch.[Enabled] = 1 AND myBranch.[EnabledSQLInstance] = 1