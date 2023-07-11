USE msdb;
GO
SELECT myJobActivity.job_id,
       myJob.name AS job_name,
       myJobCategory.name AS category_name,
       myJobStep.step_name,
       myJobActivity.run_requested_date,
       myJobActivity.start_execution_date,
       ISNULL(myJobActivity.last_executed_step_date, myJobActivity.start_execution_date) AS last_executed_step_date,
       ISNULL(last_executed_step_id, 0) + 1 AS current_executed_step_id,
       DATEDIFF(SECOND, myJobActivity.start_execution_date, GETDATE()) AS Duration
FROM dbo.sysjobactivity AS myJobActivity
INNER JOIN dbo.sysjobs AS myJob ON myJobActivity.job_id = myJob.job_id
INNER JOIN dbo.syscategories AS myJobCategory ON myJobCategory.category_id = myJob.category_id
INNER JOIN dbo.sysjobsteps AS myJobStep ON myJobActivity.job_id = myJobStep.job_id AND ISNULL(myJobActivity.last_executed_step_id, 0) + 1 = myJobStep.step_id
LEFT JOIN dbo.sysjobhistory AS myJobHistory ON myJobActivity.job_history_id = myJobHistory.instance_id
WHERE myJobActivity.start_execution_date IS NOT NULL
      AND myJobActivity.stop_execution_date IS NULL
      AND myJobActivity.session_id =
      (
          SELECT TOP 1
                 session_id
          FROM dbo.syssessions
          ORDER BY agent_start_date DESC
      );