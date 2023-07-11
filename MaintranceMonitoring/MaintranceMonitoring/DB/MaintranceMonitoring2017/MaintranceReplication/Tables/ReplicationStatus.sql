CREATE TABLE [MaintranceReplication].[ReplicationStatus] (
    [ID]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]    VARCHAR (20)  NOT NULL,
    [Caption] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_MaintranceReplication_ReplicationStatus] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

