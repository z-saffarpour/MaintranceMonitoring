CREATE VIEW Report.[SQLDatabase]
AS
	SELECT myDatabase.ID, CONCAT(REPLICATE('0',3-LEN(myBranch.RegionNo)),myBranch.RegionNo) AS BranchSiteId, myBranch.BranchName, myBranch.BranchNumber, myBranchType.Name AS BranchType,
		   myDatabase.DatabaseName, myCompatibilityLevel.Caption AS CompatibilityLevel, myDatabseCollation.Caption AS DatabseCollation,
		   myRecoveryModelKey.Caption AS RecoveryModel, myUserAccess.Caption AS UserAccess, myRestrictAccess.Caption AS RestrictAccess,
		   mySnapshotIsolationState.Caption AS SnapshotIsolationState, myPageVerify.Caption AS PageVerify,
		   myDatabase.DatabaseLSN, myDatabase.OwnerSid, myDatabase.OwnerName,
		   myCreateDate.PersianDate AS CreatePersianDate, myCreateTime.FullTime AS CreateTime,
		   myLastGoodCheckDbDate.PersianDate AS LastGoodCheckDbPersianDate, myLastGoodCheckDbTime.FullTime AS LastGoodCheckDbTimeKey,
		   myDatabase.IsReadOnly, myDatabase.IsAutoCloseOn, myDatabase.IsAutoShrinkOn, myDatabase.IsReadCommittedSnapshotOn,
		   myDatabase.IsAutoCreateStatsOn, myDatabase.IsAutoUpdateStatsOn, myDatabase.IsAutoUpdateStatsAsyncOn, myDatabase.IsTrustworthyOn,
		   myDatabase.IsMasterKeyEncryptedByServer, myDatabase.IsPublished, myDatabase.IsSubscribed, myDatabase.IsDistributor,
		   myDatabase.IsCDCEnabled, myDatabase.IsEncrypted, myDatabase.InsertDatetime 
	FROM MaintranceDatabase.SQLDatabase AS myDatabase
	INNER JOIN Common.Branch AS myBranch ON myBranch.ID = myDatabase.Common_BranchRef
	INNER JOIN Common.BranchType AS myBranchType ON myBranchType.ID = myBranch.common_BranchTypeRef
	INNER JOIN MaintranceDatabase.DatabseCollation AS myDatabseCollation ON myDatabseCollation.ID = myDatabase.MaintranceDatabase_DatabseCollationRef
	INNER JOIN MaintranceDatabase.CompatibilityLevel AS myCompatibilityLevel ON myCompatibilityLevel.ID = myDatabase.MaintranceDatabase_CompatibilityLevelRef
	INNER JOIN MaintranceDatabase.RecoveryModel AS myRecoveryModelKey ON myRecoveryModelKey.ID = myDatabase.MaintranceDatabase_RecoveryModelRef
	INNER JOIN MaintranceDatabase.UserAccess AS myUserAccess ON myUserAccess.ID = myDatabase.MaintranceDatabase_UserAccessRef
	INNER JOIN MaintranceDatabase.RestrictAccess AS myRestrictAccess ON myRestrictAccess.ID = myDatabase.MaintranceDatabase_RestrictAccessRef
	INNER JOIN MaintranceDatabase.SnapshotIsolationState AS mySnapshotIsolationState ON mySnapshotIsolationState.ID = myDatabase.MaintranceDatabase_SnapshotIsolationStateRef
	INNER JOIN MaintranceDatabase.PageVerify AS myPageVerify ON myPageVerify.ID = myDatabase.MaintranceDatabase_PageVerifyRef
	INNER JOIN Common.DimDate AS myCreateDate ON myCreateDate.ID = myDatabase.Common_Date_CreateRef
	INNER JOIN Common.DimTime AS myCreateTime ON myCreateTime.ID = myDatabase.Common_Time_CreateRef
	LEFT JOIN Common.DimDate AS myLastGoodCheckDbDate ON myLastGoodCheckDbDate.ID = myDatabase.Common_Date_LastGoodCheckDbRef
	LEFT JOIN Common.DimTime AS myLastGoodCheckDbTime ON myLastGoodCheckDbTime.ID = myDatabase.Common_Time_LastGoodCheckDbRef
	WHERE myBranch.[Enabled] = 1 AND [myBranch].[EnabledDatabases] = 1