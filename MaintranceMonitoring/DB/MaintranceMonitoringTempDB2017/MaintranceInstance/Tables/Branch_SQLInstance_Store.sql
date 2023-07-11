CREATE TABLE [MaintranceInstance].[Branch_SQLInstance_Store] (
    [ID]                   INT           IDENTITY (1, 1) NOT NULL,
    [BranchRef]            INT           NULL,
    [BranchName]           NVARCHAR (50) NOT NULL,
    [ServerIP]             VARCHAR (60)  NOT NULL,
    [AuthenticationType]   VARCHAR (10)  NOT NULL,
    [ProcessStatus]        VARCHAR (50)  DEFAULT ('NoAction') NOT NULL,
    [StartProcessDatetime] DATETIME      NULL,
    [EndProcessDatetime]   DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

