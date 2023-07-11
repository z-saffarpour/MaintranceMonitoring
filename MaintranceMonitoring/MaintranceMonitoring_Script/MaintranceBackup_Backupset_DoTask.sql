USE msdb
GO
;WITH myCTE
AS
(
    SELECT ROW_NUMBER() OVER (PARTITION BY myBackupSet.database_name, myBackupSet.type ORDER BY myBackupSet.backup_set_id DESC ) AS RowNumber,
           myBackupSet.backup_set_id AS BackupSetId,
           myBackupSet.database_name AS DatabaseName,
           myBackupSet.last_lsn AS LastLSN,
		   myBackupSet.checkpoint_lsn AS CheckpointLSN,
           myBackupSet.type AS BackupType,
           myBackupSet.name AS BackupName
    FROM dbo.backupset AS myBackupSet
    WHERE myBackupSet.database_name NOT IN ( 'SSISDB', 'master', 'model', 'msdb', 'distribution' )
          AND myBackupSet.server_name = @@SERVERNAME
          AND myBackupSet.type = 'D'
),FullBackup
AS
(
    SELECT ROW_NUMBER() OVER (ORDER BY myCTE.DatabaseName) AS RowNumber,
           myCTE.BackupSetId,
           myCTE.DatabaseName,
           myCTE.LastLSN,
		   myCTE.CheckpointLSN,
           myCTE.BackupType,
           myCTE.BackupName
    FROM myCTE
    WHERE myCTE.RowNumber = 1
),DiffBackup
AS
(
    SELECT ROW_NUMBER() OVER (PARTITION BY myBackupSet.database_name, myBackupSet.type ORDER BY myBackupSet.backup_set_id DESC ) AS RowNumber,
           myBackupSet.backup_set_id AS BackupSetId,
           myBackupSet.database_name AS DatabaseName,
           myBackupSet.last_lsn AS LastLSN,
		   myBackupSet.checkpoint_lsn AS CheckpointLSN,
           myBackupSet.type AS BackupType,
           myBackupSet.name AS BackupName
    FROM dbo.backupset AS myBackupSet
    INNER JOIN FullBackup AS myFullBackup ON myBackupSet.database_name = myFullBackup.DatabaseName AND myBackupSet.type = 'I' AND myBackupSet.last_lsn >= myFullBackup.CheckpointLSN
),LogBackup
AS
(
    SELECT 1 AS RowNumber,
           myBackupSet.backup_set_id AS BackupSetId,
           myBackupSet.database_name AS DatabaseName,
           myBackupSet.last_lsn AS LastLSN,
		   myBackupSet.checkpoint_lsn AS CheckpointLSN,
           myBackupSet.type AS BackupType,
           myBackupSet.name AS BackupName
    FROM dbo.backupset AS myBackupSet
    INNER JOIN FullBackup AS myFullBackup ON myBackupSet.database_name = myFullBackup.DatabaseName AND myBackupSet.type = 'L' AND myBackupSet.last_lsn >= myFullBackup.CheckpointLSN
    WHERE myBackupSet.database_name IN ( SELECT name FROM sys.databases AS myDatabase WHERE myDatabase.recovery_model = 1 AND myDatabase.is_read_only = 0)
), myBackupsetCTE
AS
(
    SELECT *
    FROM FullBackup
    UNION ALL
    SELECT *
    FROM DiffBackup
    WHERE DiffBackup.RowNumber = 1
    UNION ALL
    SELECT *
    FROM LogBackup
)
SELECT ROW_NUMBER() OVER (PARTITION BY myBackupSet.database_name, myBackupSet.type ORDER BY myBackupSet.backup_set_id ASC ) AS RowNumber,
       myBackupSet.backup_set_id AS BackupSetId,
       myBackupSet.media_set_id AS MediaSetId,
       myBackupSet.machine_name COLLATE SQL_Latin1_General_CP1256_CI_AS AS MachineName,
       myBackupSet.name COLLATE SQL_Latin1_General_CP1256_CI_AS AS BackupName,
       myBackupSet.type COLLATE SQL_Latin1_General_CP1256_CI_AS AS BackupType,
       myBackupSet.first_lsn AS FirstLSN,
       myBackupSet.last_lsn AS LastLSN,
       myBackupSet.checkpoint_lsn AS CheckpointLSN,
       myBackupSet.database_backup_lsn AS DatabaseBackupLSN,
       myBackupSet.backup_start_date AS BackupStartDatetime,
       myBackupSet.backup_finish_date AS BackupFinishDatetime,
       myBackupSet.expiration_date AS ExpirationDate,
       myBackupSet.backup_size AS BackupSize,
       myBackupSet.compressed_backup_size AS CompressedBackupSize,
       myBackupSet.description COLLATE SQL_Latin1_General_CP1256_CI_AS AS BackupDescription,
       myBackupSet.is_copy_only AS IsCopyOnly,
       myBackupSet.server_name AS ServerName,
       myBackupSet.database_name AS DatabaseName,
       myBackupSet.recovery_model AS RecoveryModel,
       myBackupSet.database_version AS DatabaseVersion,
       myBackupSet.is_single_user AS IsSingleUser,
       myBackupSet.has_backup_checksums AS HasBackupChecksums
FROM dbo.backupset AS myBackupSet
INNER JOIN myBackupsetCTE ON myBackupSet.backup_set_id = myBackupsetCTE.BackupSetId
WHERE myBackupSet.server_name = @@SERVERNAME