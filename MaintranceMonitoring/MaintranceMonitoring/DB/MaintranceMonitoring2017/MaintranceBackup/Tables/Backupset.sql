CREATE TABLE [MaintranceBackup].[Backupset] (
    [ID]                              BIGINT         IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]                INT            NOT NULL,
    [MaintranceBackup_BackupTypeRef]  INT            NOT NULL,
    [MachineName]                     NVARCHAR (128) NOT NULL,
    [ServerName]                      NVARCHAR (128) NOT NULL,
    [DatabaseName]                    NVARCHAR (128) NOT NULL,
    [RecoveryModel]                   NVARCHAR (60)  NOT NULL,
    [DatabaseVersion]                 INT            NOT NULL,
    [IsSingleUser]                    BIT            NOT NULL,
    [BackupSetId]                     INT            NOT NULL,
    [MediaSetId]                      INT            NOT NULL,
    [BackupName]                      NVARCHAR (128) NOT NULL,
    [BackupDescription]               NVARCHAR (255) NULL,
    [FirstLSN]                        NUMERIC (25)   NOT NULL,
    [LastLSN]                         NUMERIC (25)   NOT NULL,
    [CheckpointLSN]                   NUMERIC (25)   NOT NULL,
    [DatabaseBackupLSN]               NUMERIC (25)   NOT NULL,
    [Common_Date_BackupStartRef]      INT            NOT NULL,
    [Common_Date_BackupFinishRef]     INT            NOT NULL,
    [Common_Date_BackupExpirationRef] INT            NULL,
    [Common_Time_BackupStartRef]      INT            NOT NULL,
    [Common_Time_BackupFinishTimeRef] INT            NOT NULL,
    [Common_Time_BackupExpirationRef] INT            NULL,
    [BackupSize]                      NUMERIC (20)   NOT NULL,
    [CompressedBackupSize]            NUMERIC (20)   NOT NULL,
    [IsCopyOnly]                      BIT            NOT NULL,
    [HasBackupChecksums]              BIT            NOT NULL,
    [IsInternalDisaster]              AS             (case when charindex('InternalDisaster',[BackupDescription])>(0) then (1) else (0) end) PERSISTED NOT NULL,
    [IsTransfered]                    AS             (case when charindex('Transfered',[BackupDescription])>(0) then (1) else (0) end) PERSISTED NOT NULL,
    [InsertDatetime]                  DATETIME       NOT NULL,
    CONSTRAINT [PK_MaintranceBackup_Backupset] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_Backupset_BackupType] FOREIGN KEY ([MaintranceBackup_BackupTypeRef]) REFERENCES [MaintranceBackup].[BackupType] ([ID]),
    CONSTRAINT [FK_Backupset_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_Backupset_ExpirationDate] FOREIGN KEY ([Common_Date_BackupExpirationRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_Backupset_ExpirationTime] FOREIGN KEY ([Common_Time_BackupExpirationRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_Backupset_FinishDate] FOREIGN KEY ([Common_Date_BackupFinishRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_Backupset_FinishTime] FOREIGN KEY ([Common_Time_BackupFinishTimeRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_Backupset_StartDate] FOREIGN KEY ([Common_Date_BackupStartRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_Backupset_StartTime] FOREIGN KEY ([Common_Time_BackupStartRef]) REFERENCES [Common].[DimTime] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);


GO
ALTER TABLE [MaintranceBackup].[Backupset] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceBackup_Backupset]
    ON [MaintranceBackup].[Backupset]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

