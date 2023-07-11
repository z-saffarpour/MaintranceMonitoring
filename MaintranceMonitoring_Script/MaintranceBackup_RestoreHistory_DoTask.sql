USE msdb
GO
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DECLARE @RetainDays INT;
DECLARE @myDatetime DATE;
SET @RetainDays = 30
SET @myDatetime = DATEADD(DAY,-1*@RetainDays,CAST(GETDATE() AS DATE))

SELECT ROW_NUMBER()OVER(ORDER BY myRestore.RestoreDatabase, myRestore.RowNumber) AS RowNumber,
	   RestoreDatabase,
       RestoreUsername,
       RestoreDatetime,
       BackupSetId,
       BackupName,
       BackupType,
       FirstLSN,
       LastLSN,
       CheckpointLSN,
       DatabaseBackupLSN,
       BackupStartDatetime,
       BackupFinishDatetime,
       ExpirationDate,
       BackupSize_GB,
       CompressedBackupSize_GB,
       BackupDescription,
       IsCopyOnly,
       OriginalMachineName,
       OriginalServerName,
       OriginalDatabase,
       RecoveryModel,
       DatabaseVersion,
       IsSingleUser,
       IsReadOnly
FROM
(
	SELECT ROW_NUMBER()OVER(PARTITION BY myRestoreHistory.destination_database_name ORDER BY myRestoreHistory.restore_history_id DESC) AS RowNumber,
		   myRestoreHistory.destination_database_name AS RestoreDatabase,
		   myRestoreHistory.user_name AS RestoreUsername,
		   myRestoreHistory.restore_date AS RestoreDatetime,
		   myBackupSet.backup_set_id AS BackupSetId,
		   myBackupSet.name AS BackupName,
		   myBackupSet.type AS BackupType,
		   myBackupSet.first_lsn AS FirstLSN,
		   myBackupSet.last_lsn AS LastLSN,
		   myBackupSet.checkpoint_lsn AS CheckpointLSN,
		   myBackupSet.database_backup_lsn AS DatabaseBackupLSN,
		   myBackupSet.backup_start_date AS BackupStartDatetime,
		   myBackupSet.backup_finish_date AS BackupFinishDatetime,
		   myBackupSet.expiration_date AS ExpirationDate,
		   (myBackupSet.backup_size / (1024 * 1024 * 1024)) AS BackupSize_GB,
		   (myBackupSet.compressed_backup_size / (1024 * 1024 * 1024)) AS CompressedBackupSize_GB,
		   myBackupSet.description AS BackupDescription,
		   myBackupSet.is_copy_only AS IsCopyOnly,
		   myBackupSet.machine_name AS OriginalMachineName,
		   myBackupSet.server_name AS OriginalServerName,
		   myBackupSet.database_name AS OriginalDatabase,
		   myBackupSet.recovery_model AS RecoveryModel,
		   myBackupSet.database_version AS DatabaseVersion,
		   myBackupSet.is_single_user AS IsSingleUser,
		   myBackupSet.is_readonly AS IsReadOnly
	FROM dbo.restorehistory AS myRestoreHistory
	INNER JOIN dbo.backupset AS myBackupSet ON myBackupSet.backup_set_id = myRestoreHistory.backup_set_id
	WHERE myRestoreHistory.destination_database_name IN (SELECT myDatabases.name FROM sys.databases AS myDatabases WHERE state = 1 OR is_in_standby = 1)
		 AND CAST(myBackupSet.backup_start_date AS DATE) >= @myDatetime
) AS myRestore
