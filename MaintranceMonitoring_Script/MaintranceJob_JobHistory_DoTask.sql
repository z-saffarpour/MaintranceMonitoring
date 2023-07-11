USE msdb
GO
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT myJobHistory.instance_id AS InstanceId,
       myJob.job_id AS JobId,
       myJob.name COLLATE SQL_Latin1_General_CP1256_CI_AS AS JobName,
       CONVERT(DATE, CONVERT(VARCHAR, run_date), 112) AS RunDate,
       CONVERT(TIME(0),
               DATEADD(   S,
                          (run_time / 10000) * 60 * 60 /* hours */
                          + ((run_time - (run_time / 10000) * 10000) / 100) * 60 /* mins */
                          + (run_time - (run_time / 100) * 100), /* secs */
                          CONVERT(DATETIME, RTRIM(run_date), 112)
                      )
              ) AS RunTime,
       myJobHistory.run_status AS JobStatus,
       myCategory.name COLLATE SQL_Latin1_General_CP1256_CI_AS AS CategoryName,
       myCategory.category_type AS CategoryCode,
       myJobHistory.step_id AS Step,
       myJobHistory.step_name COLLATE SQL_Latin1_General_CP1256_CI_AS AS StepName,
	   myJobHistory.message COLLATE SQL_Latin1_General_CP1256_CI_AS AS Message,
       --myJobHistory.run_duration / 10000 * 60 + myJobHistory.run_duration / 100 % 100 + myJobHistory.run_duration % 100/ 60.0 AS Duration,
	   ((myJobHistory.run_duration/1000000)*86400) + (((myJobHistory.run_duration-((myJobHistory.run_duration/1000000)*1000000))/10000)*3600) + (((myJobHistory.run_duration-((myJobHistory.run_duration/10000)*10000))/100)*60) + (myJobHistory.run_duration-(myJobHistory.run_duration/100)*100) AS Duration,
	   SUBSTRING(myJobHistory.message, NULLIF(CHARINDEX('Execution ID: ', myJobHistory.message),0)+14 ,PATINDEX('%[^0-9]%',SUBSTRING(myJobHistory.message, NULLIF(CHARINDEX('Execution ID: ', myJobHistory.message),0)+14 ,20))-1) AS ExecutionID
FROM dbo.sysjobhistory AS myJobHistory
INNER JOIN dbo.sysjobs AS myJob ON myJobHistory.job_id = myJob.job_id
INNER JOIN dbo.syscategories AS myCategory ON myCategory.category_id = myJob.category_id
WHERE CONVERT(DATETIME, RTRIM(run_date), 112) >= DATEADD(d, -1*30, CONVERT(DATE, GETDATE()))