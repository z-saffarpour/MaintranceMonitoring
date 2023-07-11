USE SSISDB
GO
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT myExecution.execution_id AS ExecutionID,
       myExecution.folder_name AS FolderName,
       myExecution.project_name AS ProjectName,
       myExecution.package_name AS PackageName,
       myOperation.status AS status_code,
       CAST(myOperation.start_time AS DATETIME2(0)) AS start_time,
       CAST(myOperation.end_time AS DATETIME2(0)) AS end_time,
       myOperation.caller_name,
       myOperation.process_id,
       myOperation.stopped_by_name
FROM [internal].[executions] AS myExecution
INNER JOIN [internal].[operations] AS myOperation ON myExecution.[execution_id] = myOperation.[operation_id]
WHERE myOperation.status NOT IN (1,2)
	AND
	(
          myOperation.start_time > DATEADD(DAY, -1 * 30, CONVERT(DATE, GETDATE()))
          OR myOperation.start_time IS NULL
    )
GO
--=Details============================
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @startexecutionid INT;
SELECT @startexecutionid = MIN(execution_id)
FROM catalog.executions AS myExecution
WHERE myExecution.start_time > DATEADD(DAY, -1 * 30, CONVERT(DATE, GETDATE()));

SELECT myOperation.operation_message_id AS OperationMessageID,
       myOperation.operation_id AS ExecutionID,
       CONVERT(DATETIME2(3), myOperation.message_time) AS MessageTime,
       myOperation.message_type AS MessageType,
       myOperation.message_source_type AS MessageSourceType,
       myEvent.event_name AS EventName,
       myEvent.message_source_name AS MessageSourceName,
       CASE
           WHEN myOperation.message_source_type = 10 THEN 'Entry APIs, such as T-SQL and CLR Stored procedures'
           WHEN myOperation.message_source_type = 20 THEN 'External process used to run package (ISServerExec.exe)'
           WHEN myOperation.message_source_type = 30 THEN 'Package-level objects'
           WHEN myOperation.message_source_type = 40 THEN 'Control Flow tasks'
           WHEN myOperation.message_source_type = 50 THEN 'Control Flow containers'
           WHEN myOperation.message_source_type = 60 THEN 'Data Flow task'
       END AS MessageSourceTypeDescription,
       myOperation.message AS Message,
       myEvent.subcomponent_name AS SubcomponentName,
       myEvent.package_path AS EventPackagePath,
       myEvent.execution_path AS EventExecutionPath
FROM catalog.operation_Messages AS myOperation
INNER JOIN catalog.event_messages AS myEvent ON myEvent.event_message_id = myOperation.operation_message_id AND myEvent.operation_id = myOperation.operation_id
WHERE myOperation.message_type = 120
      AND myOperation.operation_id >= @startexecutionid
	  AND myEvent.package_path > ''
	  AND myEvent.execution_path > ''
