@echo off
title PC Diagnostic and Repair Tool

:Start
cls
echo.
echo ==================================================
echo PC Diagnostic and Repair Tool
echo ==================================================

echo.
echo 1. Check Disk Integrity
echo 2. Scan for Malware (Windows Defender)
echo 3. Scan for Malware (MRT)
echo 4. Update Drivers
echo 5. Check Network Connectivity
echo 6. Clean Temporary Files
echo 7. Scan System Health (DISM)
echo 8. Restore System Health (DISM)
echo 9. System File Checker (SFC)
echo 10. Open Computer Management and Check Event Log
echo 11. Perform All Tasks
echo 12. Check for Updates
echo 13. Optimize System Performance
echo 14. Manage Startup Programs
echo 15. View System Information
echo 16. Manage Packages (Winget)
echo 17. Defragment Disk
echo 18. Check Disk Usage
echo 19. Run Disk Cleanup
echo 20. Exit

set /p choice=Enter your choice (1-20):

if %choice%==1 goto CheckDisk
if %choice%==2 goto WindowsDefenderScan
if %choice%==3 goto MRTScan
if %choice%==4 goto UpdateDrivers
if %choice%==5 goto NetworkCheck
if %choice%==6 goto CleanTemp
if %choice%==7 goto DISMScanHealth
if %choice%==8 goto DISMRestoreHealth
if %choice%==9 goto SFCScannow
if %choice%==10 goto OpenComputerManagement
if %choice%==11 goto PerformAllTasks
if %choice%==12 goto CheckForUpdates
if %choice%==13 goto OptimizePerformance
if %choice%==14 goto ManageStartup
if %choice%==15 goto ViewSystemInfo
if %choice%==16 goto ManagePackages
if %choice%==17 goto DefragmentDisk
if %choice%==18 goto CheckDiskUsage
if %choice%==19 goto RunDiskCleanup
if %choice%==20 goto Exit

:CheckDisk
echo.
echo Checking disk integrity...
chkdsk /f /r %systemdrive%
goto Start

:WindowsDefenderScan
echo.
echo Scanning for malware using Windows Defender...
start "Windows Defender" "msmpeng.exe" /scan
goto Start

:MRTScan
echo.
echo Scanning for malware using Microsoft Safety Scanner (MRT)...
start "MRT" "msrt.exe" /scan
goto Start

:UpdateDrivers
echo.
echo Updating drivers...
start "Device Manager" "devmgmt.msc"
goto Start

:NetworkCheck
echo.
echo Checking network connectivity...
ping 8.8.8.8
goto Start

:CleanTemp
echo.
echo Cleaning temporary files...
del /q /f /s "%temp%\*"
goto Start

:DISMScanHealth
echo.
echo Scanning system health using DISM...
dism.exe /online /cleanup-image /checkhealth
goto Start

:DISMRestoreHealth
echo.
echo Restoring system health using DISM...
dism.exe /online /cleanup-image /restorehealth
goto Start

:SFCScannow
echo.
echo Running System File Checker (SFC)...
sfc /scannow
goto Start

:OpenComputerManagement
echo.
echo Opening Computer Management...
start compmgmt.msc
echo.
echo Please check the Event Log for more details.
pause
goto Start

:PerformAllTasks
echo.
echo Performing all tasks...
chkdsk /f /r %systemdrive%
start "Windows Defender" "msmpeng.exe" /scan
start "MRT" "msrt.exe" /scan
start "Device Manager" "devmgmt.msc"
ping 8.8.8.8
del /q /f /s "%temp%\*"
dism.exe /online /cleanup-image /checkhealth
dism.exe /online /cleanup-image /restorehealth
sfc /scannow
start compmgmt.msc
echo.
echo Please check the Event Log for more details.
pause
goto Start

:CheckForUpdates
echo Checking for Windows updates...
start ms-settings:windowsupdate-summary
echo Checking for driver updates...
start devmgmt.msc
goto Start

:OptimizePerformance
echo Disk Cleanup...
cleanmgr /sageset:65535 & cleanmgr /sagerun:65535
echo Create System Restore Point...
wbadmin start backup -backupTarget:C:\ -backupName:"System Restore Point" -quiet
echo Memory Diagnostics...
mdsched.exe /check -reboot
goto Start

:ManageStartup
echo Managing Startup Programs...
start msconfig
goto Start

:ViewSystemInfo
echo System Information...
systeminfo
goto Start

:ManagePackages
echo Managing Packages (Winget)...
start winget
goto Start

:DefragmentDisk
echo Defragmenting disk...
defrag %systemdrive%
goto Start

:CheckDiskUsage
echo Checking disk usage...
dir /a /s %systemdrive% | sort /s /r > disk_usage.txt
echo Disk usage report saved to disk_usage.txt
goto Start

:RunDiskCleanup
echo Running Disk Cleanup...
cleanmgr /sageset:65535 & cleanmgr /sagerun:65535
goto Start

:Exit
echo.
echo Exiting...
echo Changes may require a system reboot. Do you want to reboot now? (Y/N)
set /p confirm=
if /i "%confirm%"=="y" || /i "%confirm%"=="yes" (
    echo Rebooting...
    shutdown /r /t 0
) else (
    echo Exiting without reboot.
    pause
)
