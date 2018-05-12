<#
.SYNOPSIS
    List installed software
.DESCRIPTION
    This script extracts a lists all installed software on a local computer
    and saves it in a csv file on the user desktop named 
    ${UserName}-appllications.csv
.NOTES
    File Name  : installed-software.ps1
    Date       : 12.05.2018.
    Author     : Miroslav Vidović
#>

# user name used for the path and file name
$UserName = $env:UserName

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
sort DisplayName |
Export-Csv -Path "c:\users\${UserName}\desktop\${UserName}-applications.csv" -Encoding ascii -NoTypeInformation
