USE master
GO
SELECT CAST(myDatabase.name AS VARCHAR(50)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS DataBaseName,
       CASE WHEN myDatabaseFile.redo_start_lsn IS NULL THEN
                myDatabaseFile.differential_base_lsn
            ELSE
                myDatabaseFile.redo_start_lsn
       END AS DatabaseLSN,
       owner_sid AS OwnerSid,
       CAST(myLogin.name AS VARCHAR(250)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS OwnerName,
       compatibility_level AS CompatibilityLevel,
       CAST(collation_name AS VARCHAR(31)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS [CollationName],
       myDatabase.create_date AS CreateDatetime,
       CAST(DATABASEPROPERTYEX(myDatabase.name, 'LastGoodCheckDbTime') AS DATETIME) AS LastGoodCheckDbDatetime,
       user_access AS UserAccess,
       user_access_desc COLLATE SQL_Latin1_General_CP1256_CI_AS AS UserAccessDesc,
       is_read_only AS IsReadOnly,
       is_auto_close_on AS IsAutoCloseOn,
       is_auto_shrink_on AS IsAutoShrinkOn,
       state AS RestrictAccess,
       state_desc COLLATE SQL_Latin1_General_CP1256_CI_AS AS RestrictAccessDesc,
       snapshot_isolation_state AS SnapshotIsolationState,
       snapshot_isolation_state_desc COLLATE SQL_Latin1_General_CP1256_CI_AS AS SnapshotIsolationStateDesc,
       is_read_committed_snapshot_on AS IsReadCommittedSnapshotOn,
       recovery_model AS RecoveryModel,
       recovery_model_desc COLLATE SQL_Latin1_General_CP1256_CI_AS AS RecoveryModelDesc,
       page_verify_option AS PageVerifyOption,
       page_verify_option_desc COLLATE SQL_Latin1_General_CP1256_CI_AS AS PageVerifyOptionDesc,
       is_auto_create_stats_on AS IsAutoCreateStatsOn,
       is_auto_update_stats_on AS IsAutoUpdateStatsOn,
       is_auto_update_stats_async_on AS IsAutoUpdateStatsAsyncOn,
       is_trustworthy_on AS IsTrustworthyOn,
       is_master_key_encrypted_by_server AS IsMasterKeyEncryptedByServer,
       is_published AS IsPublished,
       is_subscribed AS IsSubscribed,
       is_distributor AS IsDistributor,
       is_cdc_enabled AS IsCDCEnabled,
       is_encrypted AS IsEncrypted
FROM sys.databases AS myDatabase
INNER JOIN
(
    SELECT database_id,
           redo_start_lsn,
           differential_base_lsn
    FROM sys.master_files
    WHERE file_id = 1
) AS myDatabaseFile ON myDatabaseFile.database_id = myDatabase.database_id
LEFT JOIN sys.syslogins AS myLogin ON myDatabase.owner_sid = myLogin.sid
WHERE myDatabase.name != 'tempdb'
