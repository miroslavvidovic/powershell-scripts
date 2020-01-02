<#
.SYNOPSIS
    List installed software
.DESCRIPTION
    This script extracts a lists all installed software on a local computer
    and saves it in a csv file on the user desktop named 
    ${UserName}-appllications.csv
.NOTES
    File Name  : Installed-Software.ps1
    Date       : 12.05.2018.
    Author     : Miroslav Vidović
#>

# user name used for the path and file name
$UserName = $env:UserName

$UninstallKey = "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall"

$array = @()

$computername=$env:computername

$reg=[microsoft.win32.registrykey]::OpenRemoteBaseKey('LocalMachine',$computername) 
$regkey=$reg.OpenSubKey($UninstallKey) 
$subkeys=$regkey.GetSubKeyNames() 

foreach($key in $subkeys){
    $thisKey=$UninstallKey+"\\"+$key 
    $thisSubKey=$reg.OpenSubKey($thisKey)  
    $obj = New-Object PSObject
    $obj | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $computername
    $obj | Add-Member -MemberType NoteProperty -Name "DisplayName" -Value $($thisSubKey.GetValue("DisplayName"))
    $obj | Add-Member -MemberType NoteProperty -Name "DisplayVersion" -Value $($thisSubKey.GetValue("DisplayVersion"))
    $obj | Add-Member -MemberType NoteProperty -Name "InstallLocation" -Value $($thisSubKey.GetValue("InstallLocation"))
    $obj | Add-Member -MemberType NoteProperty -Name "Publisher" -Value $($thisSubKey.GetValue("Publisher"))
    $array += $obj
}

$array | Where-Object { $_.DisplayName } | select ComputerName, DisplayName, DisplayVersion, Publisher |
Export-Csv -Path "c:\users\${UserName}\desktop\${UserName}-applications.csv" -Encoding ascii -NoTypeInformation
