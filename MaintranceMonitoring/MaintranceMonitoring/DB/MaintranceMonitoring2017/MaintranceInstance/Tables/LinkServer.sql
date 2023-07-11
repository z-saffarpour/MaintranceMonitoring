CREATE TABLE [MaintranceInstance].[LinkServer] (
    [ID]                                      BIGINT          IDENTITY (1, 1) NOT NULL,
    [Common_BranchRef]                        INT             NOT NULL,
    [LinkServerName]                          NVARCHAR (128)  NOT NULL,
    [LoginRemoteName]                         NVARCHAR (128)  NULL,
    [MaintranceInstance_ProductRef]           INT             NOT NULL,
    [MaintranceInstance_ProviderRef]          INT             NOT NULL,
    [MaintranceInstance_DataSourceRef]        INT             NOT NULL,
    [Location]                                NVARCHAR (4000) NULL,
    [ProviderString]                          NVARCHAR (4000) NULL,
    [DatabaseDefault]                         NVARCHAR (128)  NULL,
    [ConnectTimeout]                          INT             NULL,
    [QueryTimeout]                            INT             NULL,
    [IsLinked]                                BIT             NOT NULL,
    [IsRemoteLoginEnabled]                    BIT             NOT NULL,
    [IsRpcOutEnabled]                         BIT             NOT NULL,
    [IsDataAccessEnabled]                     BIT             NOT NULL,
    [IsCollationCompatible]                   BIT             NOT NULL,
    [UsesRemoteCollation]                     BIT             NOT NULL,
    [CollationName]                           NVARCHAR (128)  NULL,
    [LazySchemaValidation]                    BIT             NOT NULL,
    [IsSystem]                                BIT             NOT NULL,
    [IsPublisher]                             BIT             NOT NULL,
    [IsSubscriber]                            BIT             NULL,
    [IsDistributor]                           BIT             NULL,
    [IsNonSqlSubscriber]                      BIT             NULL,
    [IsRemoteProcTransactionPromotionEnabled] BIT             NULL,
    [IsRdaServer]                             BIT             NULL,
    [LocalPrincipalId]                        INT             NULL,
    [UsesSelfCredential]                      BIT             NOT NULL,
    [Common_Date_LinkServerModifyRef]         INT             NOT NULL,
    [Common_Time_LinkServerModifyRef]         INT             NOT NULL,
    [Common_Date_LoginModifyRef]              INT             NOT NULL,
    [Common_Time_LoginModifyRef]              INT             NOT NULL,
    [InsertDatetime]                          DATETIME        NOT NULL,
    CONSTRAINT [PK_MaintranceInstance_LinkServer] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90) ON [FG_Data],
    CONSTRAINT [FK_LinkServer_Branch] FOREIGN KEY ([Common_BranchRef]) REFERENCES [Common].[Branch] ([ID]),
    CONSTRAINT [FK_LinkServer_DataSource] FOREIGN KEY ([MaintranceInstance_DataSourceRef]) REFERENCES [MaintranceInstance].[DataSource] ([ID]),
    CONSTRAINT [FK_LinkServer_DimDate_LinkServerModify] FOREIGN KEY ([Common_Date_LinkServerModifyRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_LinkServer_DimDate_LoginModify] FOREIGN KEY ([Common_Date_LoginModifyRef]) REFERENCES [Common].[DimDate] ([ID]),
    CONSTRAINT [FK_LinkServer_DimTime_LinkServerModify] FOREIGN KEY ([Common_Time_LinkServerModifyRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_LinkServer_DimTime_LoginModify] FOREIGN KEY ([Common_Time_LoginModifyRef]) REFERENCES [Common].[DimTime] ([ID]),
    CONSTRAINT [FK_LinkServer_Product] FOREIGN KEY ([MaintranceInstance_ProductRef]) REFERENCES [MaintranceInstance].[Product] ([ID]),
    CONSTRAINT [FK_LinkServer_Provider] FOREIGN KEY ([MaintranceInstance_ProviderRef]) REFERENCES [MaintranceInstance].[Provider] ([ID])
) ON [PS_Branch] ([Common_BranchRef]);





GO



GO
CREATE CLUSTERED INDEX [IX_MaintranceInstance_LinkServer]
    ON [MaintranceInstance].[LinkServer]([ID] ASC, [Common_BranchRef] ASC) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
    ON [PS_Branch] ([Common_BranchRef]);

