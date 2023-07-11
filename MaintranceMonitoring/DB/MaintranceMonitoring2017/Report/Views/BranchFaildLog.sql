CREATE VIEW Report.BranchFaildLog
AS
SELECT ROW_NUMBER() OVER (PARTITION BY myBranch.BranchNumber ORDER BY myBranchFaildLog.InsertDatetime ASC ) AS RowNumber,
       myBranchFaildLog.ID,
       myBranchType.Name,
       myBranchType.Caption,
       myBranch.BranchName,
       myBranch.MachinName,
       myBranch.BranchNumber,
       IIF(myBranch.Enabled = 1, N'است', N'نیست') AS BranchEnabled,
       myBranchFaildLog.ServerExecutionId,
       myBranchFaildLog.PackageName,
       myBranchFaildLog.ErrorCode,
       myBranchFaildLog.ErrorMessage,
       FORMAT( myBranchFaildLog.InsertDatetime, 'yyyy/MM/dd hh:mm' ) AS InsertDatetime
FROM dbo.BranchFaildLog AS myBranchFaildLog WITH (READPAST)
INNER JOIN Common.Branch AS myBranch WITH (READPAST) ON myBranch.ID = myBranchFaildLog.Common_BranchRef
INNER JOIN Common.BranchType AS myBranchType WITH (READPAST) ON myBranchType.ID = myBranch.common_BranchTypeRef;