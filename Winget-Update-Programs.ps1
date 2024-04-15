﻿
## ----- Updating Winget applications to newer versions from Winget repository  ----------
##

# Useing $Time to create logging to Log files to see Version history.
$TimeSystemTime = Get-Date -Format "yyyy/MM/dd HH"
## If useing US format. Replace / with . in format. Othewise you are getting folders insted of a singel file.
$Time = $TimeSystemTime.replace('/','.')

Start-Transcript -Path "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log"


$PSDefaultParameterValues = @{ '*:Encoding' = 'utf8' }


# Who is running the script
$RunningAs=c:\windows\system32\whoami.exe

if ($RunningAs -like "*system*") 
{
###################################################
#### Section if installation is Running as SYSTEM.#
###################################################

    ## Help System to find winget.exe
    Write-Output "$RunningAs is provided with path to winget.exe"
    $JBNWinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
    $JBNWinGetPathExe = $JBNWinGetResolve[-1].Path
    $JBNWinGetPath = Split-Path -Path $JBNWinGetPathExe -Parent
    set-location $JBNWinGetPath 

    Stop-Transcript


    Write-Output "Path til Winget $JBNWinGetPath" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii
    

    ## List programs installed and show versions in Winget.
    Write-Output "Running .\Winget List --accept-source-agreements" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii
    .\Winget List --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii

    Write-Output "------------------" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii
    Write-Output "Listing already Pinned programs set by intune Remediation script, Prod - PIN winget Programs" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii
    .\Winget pin List --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii

    Write-Output "------------------" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii
    Write-Output "Update programs to newer versions from Winget." | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii 
    .\Winget upgrade --all --silent --accept-source-agreements --accept-package-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii

}

else

{
###################################################
#### Section if installation is Running as USER.  #
###################################################
Stop-Transcript
Write-Output "Running script as user (Not SYSTEM), no winget programs needing UAC update will be executed !." | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii
}

###################################################
#### Delete files older than 30 days.             #
###################################################
Write-Output "Delete files from C:\ProgramData\log\Winget\ older than 30 days. " | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\Winget_Update_Programs_$Time.log" -Append -encoding ascii
Get-ChildItem "C:\ProgramData\log\Winget\" -Recurse -File | Where CreationTime -lt  (Get-Date).AddDays(-30)  | Remove-Item -Force
