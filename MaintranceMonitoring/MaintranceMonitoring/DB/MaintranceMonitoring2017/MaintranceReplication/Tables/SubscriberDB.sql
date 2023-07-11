CREATE TABLE [MaintranceReplication].[SubscriberDB] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (128) NOT NULL,
    [Caption] NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_MaintranceReplication_SubscriberDB] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

