## Welcome ## - DBA Scripts and Links.  

sqlcollaborative : [DBATools](https://dbatools.io/)

Adam Machanic : [sp_whoisactive](http://whoisactive.com/downloads/)

Ola Hallengren : [SQL Server Maintenance](https://ola.hallengren.com/downloads.html)

Brent Ozar Unlimited : [sp_blitz*](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/releases)

Glenn Berry : [Dynamic Management Views](https://sqlserverperformance.wordpress.com/)

Erik Darling  : [sp_pressure_detector](https://github.com/erikdarlingdata/DarlingData/tree/master/sp_pressure_detector)

Paul Brewer : [sp_RestoreScriptGenie](https://paulbrewer.wordpress.com/sp_restoregene/)

Daniel Janik : [How’s My Plan?](http://www.howsmyplan.com/)

Richie Rump : [Statistics Parser](http://statisticsparser.com/)

Kenneth Fisher : [sp_srvpermissions & sp_dbpermissions](https://github.com/sqlstudent144/SQL-Server-Scripts)

Andy M Mallon : [Blocking_Alert](https://am2.co/2017/12/alerting-sql-server-blocking/)

Microsoft : [MissingMsi](https://docs.microsoft.com/en-US/troubleshoot/sql/install/restore-missing-windows-installer-cache-files)

Microsoft : [SqlNexus](https://github.com/Microsoft/SqlNexus)

Microsoft : [tigertoolbox](https://github.com/Microsoft/tigertoolbox) 

Microsoft : [SQLServerTiger Blog](https://techcommunity.microsoft.com/t5/SQL-Server/bg-p/SQLServer/label-name/SQLServerTiger)

Microsoft : [Reporting-Services](https://github.com/Microsoft/Reporting-Services)

Microsoft : [DiagManager](https://github.com/Microsoft/DiagManager)

Microsoft : [kerberos configuration manager](https://www.microsoft.com/en-us/download/details.aspx?id=39046)

Microsoft : [sp_help_revlogin](https://support.microsoft.com/en-nz/help/918992/how-to-transfer-logins-and-passwords-between-instances-of-sql-server)

CurrPorts : [CurrPorts](http://www.nirsoft.net/utils/cports.html#DownloadLinks)

SQL Max Memory Calculator : [SqlMax](http://sqlmax.chuvash.eu/)

MSSQL Credentials : [NetSPI_PS](https://github.com/NetSPI/Powershell-Modules)

dba-multitool : [dba-multitool](https://github.com/LowlyDBA/dba-multitool)

WorkloadTools : [WorkloadTools](https://github.com/spaghettidba/WorkloadTools)

The Best SQL Server Performance Monitor Counters to Analyze

    Memory – Available MBytes
    Physical Disk – Avg. Disk sec/Read
    Physical Disk – Avg. Disk sec/Write
    Physical Disk – Disk Reads/sec
    Physical Disk – Disk Writes/sec
    Processor – % Processor Time
    SQLServer: General Statistics – User Connections
    SQLServer: Memory Manager – Memory Grants Pending
    SQLServer: SQL Statistics – Batch Requests/sec
    SQLServer: SQL Statistics – Compilations/sec
    SQLServer: SQL Statistics – Recompilations/sec
    System – Processor Queue Length
    
    
logman.exe create counter Perf-Log -o "C:\PerfLogs\Admin\Perf-Log" -f bincirc -v mmddhhmm -max 500 -c "\Memory\Available MBytes" "\PhysicalDisk(*)\Avg. Disk sec/Read" "\PhysicalDisk(*)\Avg. Disk sec/Write" "\PhysicalDisk(*)\Disk Reads/sec" "\PhysicalDisk(*)\Disk Writes/sec" "\Processor(_Total)\% Processor Time" "\SQLServer:General Statistics\User Connections" "\SQLServer:Memory Manager\Memory Grants Pending" "\SQLServer:SQL Statistics\Batch Requests/sec" "\SQLServer:SQL Statistics\SQL Compilations/sec" "\SQLServer:SQL Statistics\SQL Re-Compilations/sec" "\System\Processor Queue Length"  -si 00:00:01

logman start Perf-Log

logman stop Perf-Log

relog C:\PerfLogs\Admin\Perf-Log_000001.blg /o C:\Perflogs\Admin\Reduced_Log_000001.csv /f csv


