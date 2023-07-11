CREATE TABLE [MaintranceBackup].[RestoreHistory] (
    [ID]                                      BIGINT         IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]                        INT            NOT NULL,
    [RestoreDatabase]                         NVARCHAR (128) NOT NULL,
    [RestoreUsername]                         NVARCHAR (128) NOT NULL,
    [Common_Date_RestoreRef]                  INT            NOT NULL,
    [Common_Time_RestoreRef]                  INT            NOT NULL,
    [BackupSetId]                             INT            NOT NULL,
    [OriginalMachineName]                     NVARCHAR (128) NOT NULL,
    [OriginalServerName]                      NVARCHAR (128) NOT NULL,
    [OriginalDatabase]                        NVARCHAR (128) NOT NULL,
    [OriginalRecoveryModel]                   NVARCHAR (60)  NOT NULL,
    [OriginalBackupName]                      NVARCHAR (128) NOT NULL,
    [MaintranceBackup_OriginalBackupTypeRef]  INT            NOT NULL,
    [OriginalBackupDatetime]                  DATETIME       NOT NULL,
    [OriginalFirstLSN]                        NUMERIC (25)   NOT NULL,
    [OriginalLastLSN]                         NUMERIC (25)   NOT NULL,
    [OriginalCheckpointLSN]                   NUMERIC (25)   NOT NULL,
    [OriginalDatabaseBackupLSN]               NUMERIC (25)   NOT NULL,
    [Common_Date_OriginalBackupStartRef]      INT            NOT NULL,
    [Common_Date_OriginalBackupFinishRef]     INT            NOT NULL,
    [Common_Date_OriginalBackupExpirationRef] INT            NOT NULL,
    [Common_Time_OriginalBackupStartRef]      INT            NOT NULL,
    [Common_Time_OriginalBackupFinishTimeRef] INT            NOT NULL,
    [Common_Time_OriginalBackupExpirationRef] INT            NOT NULL,
    [OriginalBackupSize]                      NUMERIC (20)   NOT NULL,
    [OriginalCompressedBackupSize]            NUMERIC (20)   NOT NULL,
    [OriginalBackupDescription]               NVARCHAR (255) NULL,
    [OriginalIsCopyOnly]                      BIT            NOT NULL,
    [OriginalDatabaseVersion]                 INT            NOT NULL,
    [OriginalIsSingleUser]                    BIT            NOT NULL,
    [OriginalIsReadOnly]                      BIT            NOT NULL,
    [HasLastBackupRestoreForDR]               BIT            NOT NULL,
    [InsertDatetime]                          DATETIME       NOT NULL,
    CONSTRAINT [PK_MaintranceBackup_RestoreHistory] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_OriginalBackupExpirationDate] FOREIGN KEY ([Common_Date_OriginalBackupExpirationRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_OriginalBackupExpirationTime] FOREIGN KEY ([Common_Time_OriginalBackupExpirationRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_OriginalBackupFinishDate] FOREIGN KEY ([Common_Date_OriginalBackupFinishRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_OriginalBackupFinishTime] FOREIGN KEY ([Common_Time_OriginalBackupFinishTimeRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_OriginalBackupStartDate] FOREIGN KEY ([Common_Date_OriginalBackupStartRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_OriginalBackupStartTime] FOREIGN KEY ([Common_Time_OriginalBackupStartRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_RestoreDate] FOREIGN KEY ([Common_Date_RestoreRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_Common_RestoreTime] FOREIGN KEY ([Common_Time_RestoreRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_MaintranceBackup_RestoreHistory_MaintranceBackup_OriginalBackupType] FOREIGN KEY ([MaintranceBackup_OriginalBackupTypeRef]) REFERENCES [MaintranceBackup].[BackupType] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);


GO
ALTER TABLE [MaintranceBackup].[RestoreHistory] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceBackup_RestoreHistory]
    ON [MaintranceBackup].[RestoreHistory]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

