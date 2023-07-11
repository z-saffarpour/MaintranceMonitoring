USE master
GO
SELECT CAST(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS VARCHAR(128)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ComputerNamePhysicalNetBIOS,
       CAST(SERVERPROPERTY('MachineName') AS VARCHAR(128)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS MachineName,
       CAST(@@SERVERNAME AS VARCHAR(128)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ServerName,
       CAST(@@SERVICENAME AS VARCHAR(128)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ServiceName,
       CAST(SERVERPROPERTY('Collation') AS VARCHAR(128)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS Collation,
       CAST(SERVERPROPERTY('Edition') AS VARCHAR(128)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS Edition,
       CAST(@@VERSION AS VARCHAR(250)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS VersionDesc,
       CAST(SERVERPROPERTY('ProductBuild') AS VARCHAR(10)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ProductBuild,
       CAST(SERVERPROPERTY('ProductLevel') AS VARCHAR(10)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ProductLevel,
       CAST(SERVERPROPERTY('ProductUpdateLevel') AS VARCHAR(50)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ProductUpdateLevel,
       CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(10)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ProductVersion,
       CAST(SERVERPROPERTY('ErrorLogFileName') AS VARCHAR(250)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ErrorLogFileName,
       CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS VARCHAR(250)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS InstanceDefaultDataPath,
       CAST(SERVERPROPERTY('InstanceDefaultLogPath') AS VARCHAR(250)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS InstanceDefaultLogPath,
       CAST(SERVERPROPERTY('FilestreamConfiguredLevel') AS VARCHAR(5)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS FilestreamConfiguredLevel,
       CAST(SERVERPROPERTY('FilestreamEffectiveLevel') AS VARCHAR(5)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS FilestreamEffectiveLevel,
       CAST(SERVERPROPERTY('FilestreamShareName') AS VARCHAR(50)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS FilestreamShareName,
       CAST(SERVERPROPERTY('IsAdvancedAnalyticsInstalled') AS BIT) AS IsAdvancedAnalyticsInstalled,
       CAST(SERVERPROPERTY('IsClustered') AS BIT) AS IsClustered,
       CAST(SERVERPROPERTY('IsFullTextInstalled') AS BIT) AS IsFullTextInstalled,
       CAST(SERVERPROPERTY('IsIntegratedSecurityOnly') AS BIT) AS IsIntegratedSecurityOnly,
       CAST(SERVERPROPERTY('IsPolybaseInstalled') AS BIT) AS IsPolybaseInstalled,
       CAST(SERVERPROPERTY('IsSingleUser') AS BIT) AS IsSingleUser,
       CAST(SERVERPROPERTY('IsXTPSupported') AS BIT) AS IsXTPSupported,
       CAST(SERVERPROPERTY('IsLocalDB') AS BIT) AS IsLocalDB,
       CAST(SERVERPROPERTY('ProductUpdateReference') AS VARCHAR(128)) COLLATE SQL_Latin1_General_CP1256_CI_AS AS ProductUpdateReference,
       CAST(SERVERPROPERTY('ResourceLastUpdateDateTime') AS DATETIME) AS ResourceLastUpdateDatetime,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name = 'max worker threads'
       ) AS MaxWorkerThreads,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'priority boost'
       ) AS PriorityBoost,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name LIKE 'cost threshold for parallelism'
       ) AS CostThresholdForParallelism,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name LIKE 'max degree of parallelism'
       ) AS MaxDegreeOfParallelism,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name LIKE 'min server memory%'
       ) AS MinServerMemory_MB,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name LIKE 'max server memory%'
       ) AS MaxServerMemory_MB,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name LIKE 'fill factor%'
       ) AS DefaultFillFactor_Percent,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'default trace enabled%'
       ) AS DefaultTraceEnabled,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'remote admin connections%'
       ) AS RemoteAdminConnections,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'backup compression default%'
       ) AS DefaultBackupCompression,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'backup checksum default%'
       ) AS DefaultBackupCheckSum,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'optimize for ad hoc workloads'
       ) AS OptimizeForAdHocWorkloads,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'Agent XPs%'
       ) AS AgentXPs,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'Database Mail XPs%'
       ) AS DatabaseMailXPs,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'SMO and DMO XPs'
       ) AS SMO_DMOXPs,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'Ole Automation Procedures'
       ) AS OleAutomationProcedures,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'xp_cmdshell'
       ) AS XPCmdShell,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'clr enabled%'
       ) AS ClrEnabled,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name LIKE 'remote proc trans'
       ) AS RemoteProcTrans,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'c2 audit mode'
       ) AS C2AuditMode,
       (
           SELECT TOP 1
                  CAST(value AS INT)
           FROM sys.configurations
           WHERE name LIKE 'query governor cost limit%'
       ) AS QueryGovernorCostLimit,
       (
           SELECT TOP 1
                  CAST(value AS BIT)
           FROM sys.configurations
           WHERE name LIKE 'external scripts enabled'
       ) AS ExternalScriptsEnabled
