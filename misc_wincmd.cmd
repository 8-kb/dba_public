-- check if an application is listening on a port and the application's name
netstat -ano | find "1234" | find "LISTEN"
tasklist /fi "PID eq 1234"


.\psping.exe -t SQL01:1433 |Foreach{"{0} - {1}" -f (Get-Date),$_} | Tee-object -FilePath "C:\Log\SQL01_log.txt"

msiexec /i "DataMigrationAssistant.msi" INSTALLFOLDER="D:\Program Files (x86)\DataMigrationAssistant\" /qb


netsh wlan show profile WiFiName key=clear

$server = @('s1','s2')
while($true)
{
$server | ForEach-Object {
if(-not(test-connection $PSItem -Count 1 -Quiet )){
    Write-Output "$($PSItem) : $(get-date) - Request Timed Out" |
    Out-File c:\_tools\S_log.txt -Append
}
}
}

mofcomp "C:\Program Files (x86)\Microsoft SQL Server\130\Shared\sqlmgmproviderxpsp2up.mof"

$Begin = Get-Date -Date '12/10/2020 04:30:00'
$End = Get-Date -Date '12/10/2020 05:30:00'
#Get-EventLog -LogName System -After $Begin -Before $End
Get-EventLog -LogName Application -After $Begin -Before $End
#Get-EventLog -LogName Setup -After $Begin -Before $End
Get-EventLog -LogName Security -After $Begin -Before $End | Where-Object {$_.EntryType -eq 'FailureAudit'} | Out-GridView

REM -- Delete empty folders
echo off
for /f "usebackq delims=" %%d in (`"dir "%~dp0" /ad/b/s | sort /R"`) do rd "%%d"
REM --

systeminfo | find /i "Boot Time"

REM -- Powershell Version 

$PSVersionTable.PSVersion

REM -- ComputerName 

$env:computername

Get-ChildItem "C:\Program Files\Microsoft SQL Server" -Filter *.exe -Recurse | % { $_.FullName }
Get-ChildItem "C:\Program Files (x86)\Microsoft SQL Server" -Filter *.exe -Recurse | % { $_.FullName }
Get-ChildItem C:\WINDOWS\System32 -Filter *.txt -Recurse | % { $_.FullName }

Get-ChildItem "K:\" -Filter "*.*" -Recurse -File | Where CreationTime -lt  (Get-Date).AddDays(-180) | select fullname, creationtime | Out-GridView
Get-ChildItem "J:\" -Filter "*.bak" -Recurse -File | Where CreationTime -lt  (Get-Date).AddDays(-20) |  select fullname, creationtime , @{N='SizeIngb';E={[double]('{0:N2}' -f ($_.Length/1gb))}} | Out-GridView

##Mention the path to search the files
$path = "\\d$"
##Find out the files greater than equal to below mentioned size
$size = 1MB
##Limit the number of rows
$limit = 500
##Find out the specific extension file
$Extension = "*.bak"
##script to find out the files based on the above input
$largeSizefiles = get-ChildItem -path $path -recurse -ErrorAction "SilentlyContinue" -include $Extension | ? { $_.GetType().Name -eq "FileInfo" } | where-Object {$_.Length -gt $size} | Where CreationTime -lt  (Get-Date).AddDays(-7) | sort-Object -property length -Descending | Select-Object fullname, creationtime , @{Name="SizeInGB";Expression={$_.Length / 1GB}}
#@{Name="Path";Expression={$_.directory}} -first $limit
$largeSizefiles |Out-GridView

REM -- Services 

Get-WmiObject win32_service | select Name, DisplayName, State, PathName | Export-Csv -path "C:\services.csv"

REM -- file system information 

fsutil fsinfo ntfsinfo d:\tempdb

REM -- Filestream BP

FSUTIL.EXE 8dot3name query F:
FSUTIL.EXE 8dot3name set F: 1 
fsutil.exe 8dot3name strip /s /v F:

REM -- Firewall 

netsh advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable=yes

REM -- Reset Session 

query session /server:SERVER_NAME
reset session [ID] /server: SERVER_NAME
for /f %i in (servers.txt) do query user *username* /server:%i  
for /f %i in (servers.txt) do query session /server:%i


REM -- Cluster BP

netsh int tcp show global

Netsh int tcp set global chimney=disabled
Netsh int tcp set global netdma=disabled
netsh int ipv4 set global taskoffload=disabled

get-cluster | fl *subnet*
(get-cluster).SameSubnetDelay = 2000 
(get-cluster).SameSubnetThreshold = 10 

REM -- Cluster Resouce Details 

Get-ClusterResource "SQL Network Name (XXXXXXXXX)" | %{ $_.Name = “YYYYYYYYYYY” }

REM -- Cluster AG Multisubnet 

Get-ClusterResource 
Get-ClusterResource ag01 | Get-ClusterParameter
Get-ClusterResource ag01 | Set-ClusterParameter RegisterAllProvidersIP 0
Get-ClusterResource ag01 | Set-ClusterParameter HostRecordTTL 30

Get-ChildItem "C:\Program Files\Microsoft SQL Server" -Filter *.exe -Recurse | % { $_.FullName }
Get-ChildItem "C:\Program Files (x86)\Microsoft SQL Server" -Filter *.exe -Recurse | % { $_.FullName }
Get-WmiObject win32_service | select Name, DisplayName, State, PathName | Export-Csv -path "C:\services.csv"

fsutil fsinfo ntfsinfo d:\tempdb

$wql = "SELECT Label, Blocksize, Name FROM Win32_Volume WHERE FileSystem='NTFS'"
Get-WmiObject -Query $wql -ComputerName '.' | Select-Object Label, Blocksize, Name

REM -- Filestream BP
FSUTIL.EXE 8dot3name query F:
FSUTIL.EXE 8dot3name set F: 1 
fsutil.exe 8dot3name strip /s /v F:

netsh advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable=yes

query session /server:SERVER_NAME
reset session [ID] /server: SERVER_NAME

netsh int tcp show global

Netsh int tcp set global chimney=disabled
Netsh int tcp set global netdma=disabled
netsh int ipv4 set global taskoffload=disabled

get-cluster | fl *subnet*
(get-cluster).SameSubnetDelay = 2000 
(get-cluster).SameSubnetThreshold = 10 

Get-ClusterResource "SQL Network Name (XXXXXXXXX)" | %{ $_.Name = “YYYYYYYYYYY” }

Get-ClusterResource 
Get-ClusterResource ag01 | Get-ClusterParameter
Get-ClusterResource ag01 | Set-ClusterParameter RegisterAllProvidersIP 0
Get-ClusterResource ag01 | Set-ClusterParameter HostRecordTTL 30

Get-ChildItem C:\WINDOWS\System32 -Filter *.txt -Recurse | % { $_.FullName }

REM -- Save PS Module

$wc = New-Object System.Net.WebClient
$wc.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

Find-Module -Name "azurerm.storage" -Repository "PSGallery" | Save-Module -Path "C:\temp\PSModules\" -Verbose

$env:PSModulePath

REM --------------------------------------------------------------------------Replace#USERNAME#
exec xp_cmdshell 'powershell -command "([adsi]''WinNT://Domain/#USERNAME#,user'').ChangePassword(''oldpassword'',''newpassword'')"'


REM -- ---------------

VMWareToolBoxCMD stat balloon
