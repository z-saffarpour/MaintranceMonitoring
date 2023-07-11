# Generate Input Files for Tabular Model Deployment

# DEPLOYMENT WIZARD
# https://learn.microsoft.com/en-us/sql/analysis-services/multidimensional-models/running-the-analysis-services-deployment-wizard#running-the-analysis-services-deployment-wizard-at-the-command-prompt

# navigate to directory of DeploymentWizard executable
Set-Location "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\"
# Run Deployment Wizard in "Silent Mode" redirecting relevant 
Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: dbo_BranchFaildLog' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\dbo_BranchFaildLog\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceBackup_Backupset' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceBackup_Backupset\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceBackup_RestoreHistory' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceBackup_RestoreHistory\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceInstance_Alwayson' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceInstance_Alwayson\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceJob_JobActivity' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceJob_JobActivity\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceJob_JobHistory' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceJob_JobHistory\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceJob_SSISExecution' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceJob_SSISExecution\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceReplication_DistributionAgent' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceReplication_DistributionAgent\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host 'Deploy Cube: MaintranceReplication_SubscriptionPendingCommand' -ForegroundColor Green
.\Microsoft.AnalysisServices.Deployment.exe "D:\Source\Git\MaintranceMonitoring\MaintranceMonitoring_SSAS\MaintranceReplication_SubscriptionPendingCommand\bin\Model.asdatabase" /s

Write-Host ('--'+'='*50) -ForegroundColor Green
Write-Host ([string]::Format("End Deploy : {0}",(Get-Date -Format 'yyyy-MM-dd hh:mm:ss'))) -ForegroundColor Green
Set-Location "C:\"