CREATE TABLE [MaintranceDatabase].[SQLDatabase] (
    [ID]                                           INT            IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]                             INT            NOT NULL,
    [DatabaseName]                                 VARCHAR (50)   NOT NULL,
    [MaintranceDatabase_CompatibilityLevelRef]     INT            NOT NULL,
    [MaintranceDatabase_DatabseCollationRef]       INT            NOT NULL,
    [MaintranceDatabase_RecoveryModelRef]          INT            NOT NULL,
    [MaintranceDatabase_RestrictAccessRef]         INT            NOT NULL,
    [MaintranceDatabase_PageVerifyRef]             INT            NOT NULL,
    [MaintranceDatabase_SnapshotIsolationStateRef] INT            NOT NULL,
    [MaintranceDatabase_UserAccessRef]             INT            NOT NULL,
    [Common_Date_CreateRef]                        INT            NULL,
    [Common_Time_CreateRef]                        INT            NULL,
    [Common_Date_LastGoodCheckDbRef]               INT            NULL,
    [Common_Time_LastGoodCheckDbRef]               INT            NULL,
    [DatabaseLSN]                                  NUMERIC (25)   NULL,
    [OwnerSid]                                     VARBINARY (85) NULL,
    [OwnerName]                                    VARCHAR (250)  NULL,
    [IsReadOnly]                                   BIT            NOT NULL,
    [IsAutoCloseOn]                                BIT            NOT NULL,
    [IsAutoShrinkOn]                               BIT            NOT NULL,
    [IsReadCommittedSnapshotOn]                    BIT            NOT NULL,
    [IsAutoCreateStatsOn]                          BIT            NOT NULL,
    [IsAutoUpdateStatsOn]                          BIT            NOT NULL,
    [IsAutoUpdateStatsAsyncOn]                     BIT            NOT NULL,
    [IsTrustworthyOn]                              BIT            NOT NULL,
    [IsMasterKeyEncryptedByServer]                 BIT            NOT NULL,
    [IsPublished]                                  BIT            NOT NULL,
    [IsSubscribed]                                 BIT            NOT NULL,
    [IsDistributor]                                BIT            NOT NULL,
    [IsCDCEnabled]                                 BIT            NOT NULL,
    [IsEncrypted]                                  BIT            NOT NULL,
    [InsertDatetime]                               DATETIME       NOT NULL,
    CONSTRAINT [PK_MaintranceDatabase_SQLDatabases] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_SQLDatabases_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_SQLDatabases_CompatibilityLevel] FOREIGN KEY ([MaintranceDatabase_CompatibilityLevelRef]) REFERENCES [MaintranceDatabase].[CompatibilityLevel] ([ID]),
    CONSTRAINT [FK_SQLDatabases_DatabseCollation] FOREIGN KEY ([MaintranceDatabase_DatabseCollationRef]) REFERENCES [MaintranceDatabase].[DatabseCollation] ([ID]),
    CONSTRAINT [FK_SQLDatabases_PageVerifyOption] FOREIGN KEY ([MaintranceDatabase_PageVerifyRef]) REFERENCES [MaintranceDatabase].[PageVerify] ([ID]),
    CONSTRAINT [FK_SQLDatabases_RecoveryModel] FOREIGN KEY ([MaintranceDatabase_RecoveryModelRef]) REFERENCES [MaintranceDatabase].[RecoveryModel] ([ID]),
    CONSTRAINT [FK_SQLDatabases_RestrictAccess] FOREIGN KEY ([MaintranceDatabase_RestrictAccessRef]) REFERENCES [MaintranceDatabase].[RestrictAccess] ([ID]),
    CONSTRAINT [FK_SQLDatabases_SnapshotIsolationState] FOREIGN KEY ([MaintranceDatabase_SnapshotIsolationStateRef]) REFERENCES [MaintranceDatabase].[SnapshotIsolationState] ([ID]),
    CONSTRAINT [FK_SQLDatabases_UserAccess] FOREIGN KEY ([MaintranceDatabase_UserAccessRef]) REFERENCES [MaintranceDatabase].[UserAccess] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);


GO
ALTER TABLE [MaintranceDatabase].[SQLDatabase] SET (LOCK_ESCALATION = AUTO);


GO
CREATE CLUSTERED INDEX [IX_MaintranceDatabase_SQLDatabases]
    ON [MaintranceDatabase].[SQLDatabase]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

