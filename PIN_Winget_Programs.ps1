
## ----- Pinning Winget applications to prevent versions updates  ----------
##
$PSDefaultParameterValues = @{ '*:Encoding' = 'utf8' }
$Version = "Version 1.0"

# Who is running the script
$RunningAs=c:\windows\system32\whoami.exe

if ($RunningAs -like "*system*") 
{
###################################################
#### Section if installation is Running as SYSTEM.#
###################################################

    Start-Transcript -Path "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log"
   
    ## Help System to find winget.exe
    Write-Output "$RunningAs is provided with path to winget.exe"
    $JBNWinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
    $JBNWinGetPathExe = $JBNWinGetResolve[-1].Path
    $JBNWinGetPath = Split-Path -Path $JBNWinGetPathExe -Parent
    set-location $JBNWinGetPath 

# $PSDefaultParameterValues

Write-Output "Pinning winget programs"

Write-Output "Path to Winget.exe is $JBNWinGetPath"

 
## Stopping Transcript because remediation script does not provide correct output to log file,.
Stop-Transcript


Write-Output "Winget.exe Version is" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe -v | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii



###################################################
####    PINNING programs                          #
###################################################

Write-Output "Pinning Microsoft.Teams" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe pin add --id Microsoft.Teams --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii

Write-Output "Pinning Microsoft.Office" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe pin add --id Microsoft.Office --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii

Write-Output "Pinning Microsoft.OneDrive" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe pin add --id Microsoft.OneDrive --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii

Write-Output "Adobe.Acrobat.Reader.64-bit" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe pin add --id Adobe.Acrobat.Reader.64-bit --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii

Write-Output "Microsoft.Edge" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe pin add --id Microsoft.Edge --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii

Write-Output "Google.Chrome" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe pin add --id Google.Chrome --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii


###################################################
####     Listing PINNED programs                  #
###################################################


Write-Output "Listing Pinned programs" | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append
.\winget.exe pin list --accept-source-agreements | Out-File -FilePath "$env:ALLUSERSPROFILE\log\Winget\PIN_Winget_Programs_$Version.log" -Append -encoding ascii



exit 0
}

else

{
###################################################
#### Section if installation is Running as USER. #
###################################################

    Start-Transcript -Path "$env:APPDATA\Winget\PIN_Winget_Programs_$Version.log"
 
    ## List programs installed and show versions in Winget.
    Winget List --accept-source-agreements

}
Stop-Transcript
exit 0
