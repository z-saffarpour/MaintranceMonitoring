CREATE VIEW Report.[Backupset]
AS
	SELECT BranchSiteId, BranchName, BranchNumber, BranchTypeName, BackupType, MachineName, ServerName, DatabaseName, RecoveryModel, DatabaseVersion, IsSingleUser, BackupSetId, MediaSetId, 
		   BackupName, BackupDescription, FirstLSN, LastLSN, CheckpointLSN, DatabaseBackupLSN, BackupStart, BackupStartDate, BackupStartTime, BackupFinish, BackupFinishDate, BackupFinishTime, 
		   BackupExpiration, BackupExpirationDate, BackupExpirationTime, BackupSize, CompressedBackupSize, IsCopyOnly, HasBackupChecksums, IsInternalDisaster, IsTransfered, InsertDatetime, 
		   MAX(BackupStart_Full)OVER(PARTITION BY BranchName,MachineName,DatabaseName ORDER BY BranchName,MachineName,DatabaseName ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LatestFullBackupStart, 
		   MAX(BackupStart_Diffrential)OVER(PARTITION BY BranchName,MachineName,DatabaseName ORDER BY BranchName,MachineName,DatabaseName ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LatestDiffrentialBackupStart,
		   MAX(BackupStart_Log)OVER(PARTITION BY BranchName,MachineName,DatabaseName ORDER BY BranchName,MachineName,DatabaseName ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LatestLogBackupStart
	FROM
	(
		SELECT CONCAT(REPLICATE('0',3-LEN(myBranch.RegionNo)),myBranch.RegionNo) AS BranchSiteId, myBranch.BranchName, myBranch.BranchNumber, myBranchType.Name AS BranchTypeName, 
			   myBackupType.Caption AS BackupType,
			   myBackupset.MachineName, myBackupset.ServerName, myBackupset.DatabaseName, myBackupset.RecoveryModel, myBackupset.DatabaseVersion,
			   myBackupset.IsSingleUser, myBackupset.BackupSetId, myBackupset.MediaSetId, myBackupset.BackupName,
			   myBackupset.BackupDescription, myBackupset.FirstLSN, myBackupset.LastLSN, myBackupset.CheckpointLSN, myBackupset.DatabaseBackupLSN,
			   CONCAT(myStartDate.PersianDate , ' ' , myStartTime.FullTimeString24) AS BackupStart,
			   myStartDate.PersianDate AS BackupStartDate, myStartTime.FullTimeString24 AS BackupStartTime,
			   CONCAT(myFinishDate.PersianDate , ' ' , myFinishTime.FullTimeString24) AS BackupFinish,
			   myFinishDate.PersianDate AS BackupFinishDate, myFinishTime.FullTimeString24 AS BackupFinishTime,
			   CONCAT(myExpirationDate.PersianDate , ' ' , myExpirationTime.FullTimeString24) AS BackupExpiration,
			   myExpirationDate.PersianDate AS BackupExpirationDate, myExpirationTime.FullTimeString24 AS BackupExpirationTime,
			   myBackupset.BackupSize, myBackupset.CompressedBackupSize,
			   myBackupset.IsCopyOnly, myBackupset.HasBackupChecksums, myBackupset.IsInternalDisaster, myBackupset.IsTransfered,
			   myBackupset.InsertDatetime,
			   CASE WHEN myBackupType.Name = 'D' THEN myStartDate.PersianDate ELSE '' END AS BackupStart_Full,
			   CASE WHEN myBackupType.Name = 'I' THEN CONCAT(myStartDate.PersianDate,' ',myStartTime.FullTimeString24) ELSE '' END AS BackupStart_Diffrential,
			   CASE WHEN myBackupType.Name = 'L' THEN CONCAT(myStartDate.PersianDate,' ',myStartTime.FullTimeString24) ELSE '' END AS BackupStart_Log
		FROM MaintranceBackup.Backupset AS myBackupset WITH (READPAST)
		INNER JOIN MaintranceBackup.BackupType AS myBackupType WITH (READPAST) ON myBackupType.ID = myBackupset.MaintranceBackup_BackupTypeRef
		INNER JOIN Common.Branch AS myBranch WITH (READPAST) ON myBranch.ID = myBackupset.Common_BranchRef
		INNER JOIN Common.BranchType AS myBranchType WITH (READPAST) ON myBranchType.ID = myBranch.common_BranchTypeRef
		INNER JOIN Common.DimDate AS myStartDate WITH (READPAST) ON myStartDate.ID = myBackupset.Common_Date_BackupStartRef
		INNER JOIN Common.DimTime AS myStartTime WITH (READPAST) ON myStartTime.ID = myBackupset.Common_Time_BackupStartRef
		INNER JOIN Common.DimDate AS myFinishDate WITH (READPAST) ON myFinishDate.ID = myBackupset.Common_Date_BackupFinishRef
		INNER JOIN Common.DimTime AS myFinishTime WITH (READPAST) ON myFinishTime.ID = myBackupset.Common_Time_BackupFinishTimeRef
		LEFT  JOIN Common.DimDate AS myExpirationDate WITH (READPAST) ON myExpirationDate.ID = myBackupset.Common_Date_BackupExpirationRef
		LEFT  JOIN Common.DimTime AS myExpirationTime WITH (READPAST) ON myExpirationTime.ID = myBackupset.Common_Time_BackupExpirationRef
		WHERE myBranch.Enabled = 1
	) AS myReport