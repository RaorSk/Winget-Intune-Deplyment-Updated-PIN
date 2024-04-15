## ----- Installed App with the latest versjon. ----------
##

## ----- What To Do ----------
## Search for application by running from powershell winget search %Name% 
## Or to get all Winget applications run from powershell to an output file run winget search -q `"`" >>c:\data\wingetApps.txt
## Replace %Name% with name on application you want to install.  
## Replace $AppID with ID of application.
## Replace $AppName with NAME of application.


## ----- How To Download App just for testing and possible test downgrade the app version (testing purpose). --------
## Run winget show -q AppID --versions
## Example run winget show -q Notepad++.Notepad++ --versions
## Run winget download --query 'AppID' --version versionnumber --download-directory c:\data
## Example run winget download --query 'Notepad++.Notepad++' --version 8.5.7 --download-directory c:\data
## Take a look at files downloaded one file will contain lot of info about the app itself.
## Also when downloading, se source for download, if you trust it.


## Variables
$AppID = 'GitHub.GitHubDesktop'
$AppName = 'GitHub.GitHubDesktop'
## Variables End


# Who is running the script
$RunningAs=c:\windows\system32\whoami.exe
Write-Output "The script is Running as User $RunningAs"

###################################################
#### Section if installation is Running as SYSTEM.
###################################################
if ($RunningAs -like "*system*") 
{
  # Start transcript to system path
  Start-Transcript -Path "$env:ALLUSERSPROFILE\log\$AppName Install.log"

  Write-Output "The script is Running as User $RunningAs"

  ## Help System to find winget.exe
  Write-Output "$RunningAs is provided with path to winget.exe"
  $JBNWinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
  $JBNWinGetPathExe = $JBNWinGetResolve[-1].Path

  $JBNWinGetPath = Split-Path -Path $JBNWinGetPathExe -Parent
  set-location $JBNWinGetPath 

Write-Output "Path til Winget $JBNWinGetPath"

  ## Install parameters if app requires UAC prompt, and running as System.
  ## Install newest version of $AppID in system Context. For installation in system Context use:  .\winget install -e --id $AppID --silent --accept-source-agreements --accept-package-agreements
 .\Winget -v
 .\Winget list -e --id $AppID --accept-source-agreements
 .\winget install -e --id $AppID --silent --accept-source-agreements --accept-package-agreements 
}

else

###################################################
#### Section if installation is Running as USER.
###################################################
{
  # Start transcript to user path
  Start-Transcript -Path "$env:APPDATA\$AppName Install.log"

  Write-Output "The script is Running as User $RunningAs"

  ## Install newest version of $AppID in user Context. For installation in User Context use: .\winget install -e --id $AppID --silent --scope=user --accept-source-agreements --accept-package-agreements
  Winget list -e --id $AppID --accept-source-agreements
  winget install -e --id $AppID --silent --scope=user --accept-source-agreements --accept-package-agreements
Write-Output "$LASTEXITCODE"
}

Stop-Transcript