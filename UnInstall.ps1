
## This script is used for Uninstall script running as SYSTEM or USER.

## Serach for application by running from powershell winget search %Name% 
## Replace %Name% with name on application you want to install.  
## Replace $AppID with ID of application
## Replace $AppName with NAME of application

## Variables
$AppID = 'GitHub.GitHubDesktop'
$AppName = 'GitHub.GitHubDesktop'
## Variables End


# Who is running the script
$RunningAs=c:\windows\system32\whoami.exe


###################################################
#### Section if installation is Running as SYSTEM.
###################################################
if ($RunningAs -like "*system*") 
{ 
  # Start transcript
  Start-Transcript -Path "$env:ALLUSERSPROFILE\log\$AppName UnInstall.log"

  Write-Output "The script is Running as User $RunningAs"

  ## Help System to find winget.exe
  Write-Output "$RunningAs is provided with path to winget.exe"
  $JBNWinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
  $JBNWinGetPathExe = $JBNWinGetResolve[-1].Path

  $JBNWinGetPath = Split-Path -Path $JBNWinGetPathExe -Parent
  set-location $JBNWinGetPath 

  ## List installed $AppID
  .\Winget list --id $AppID --accept-source-agreements

  ## UnInstall parameters if app requires UAC prompt, and running as System.
  ## UnInstall version of $AppID in system Context. For uninstallation in system Context use:  .\winget uninstall -e --id $AppID --silent
 .\winget uninstall -e --id $AppID --silent --accept-source-agreements
}

else

###################################################
#### Section if installation is Running as USER.
###################################################
{
  # Start transcript
  Start-Transcript -Path "$env:APPDATA\$AppName UnInstall.log"

  Write-Output "The script is Running as User $RunningAs"

  # List installed $AppID
  Winget list --id $AppID --accept-source-agreements

  # UnInstall $AppID
  # winget uninstall for app installed in User Context. Then use  "winget uninstall -e --id $AppID --silent --scope=user 
  winget uninstall -e --id $AppID --silent --scope=user --accept-source-agreements 
}

Stop-Transcript